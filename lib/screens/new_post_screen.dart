import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:location/location.dart';
import 'list_screen.dart';
import '../app/appStyles.dart';
import '../app/appStrings.dart';
import '../components/app_scaffold.dart';
import '../models/post.dart';

class NewPostScreen extends StatefulWidget {
  final File image;

  NewPostScreen({Key key, this.image}) : super(key: key);

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final foodWastePost = Post();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  retrieveLocation() async {
    var locationService = Location();
    var locationData = await locationService.getLocation();
    foodWastePost.latitude = locationData.latitude;
    foodWastePost.longitude = locationData.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: Text('${AppStrings.appTitle}', style: AppStyles.titleText),
      backgroundColor: AppStyles.navBarColorDefault,
      body: SafeArea(
        child: postBody()
      ),
      floatingActionBtn: null,
      floatingActionBtnLocation: null,
    );
  }

  Widget postBody() {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            selectedPhoto(),
            leftoverItemsField(),
            uploadButton()
          ]
        )
      )
    );
  }

  Widget selectedPhoto() {
    return Expanded(
      flex: 3,
      child: Image.file(
        widget.image,
        fit: BoxFit.contain
      )
    );
  }

  Widget leftoverItemsField() {
    return Expanded(
      flex: 2,
        child: Form(
        key: _formKey,
        child: TextFormField(
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: '${AppStrings.leftoverItemsFieldLabel}',
            labelStyle: AppStyles.textLarge,
          ),
          validator: (value) {
            return validateLeftoverItems(value);
          },
          onSaved: (value) {
            foodWastePost.numLeftoverItems = int.parse(value);
          }
        ),
      )
    );
  }

  Widget uploadButton() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.only(top: padding(context)),
        child: SizedBox.expand(
          child: Semantics(
            child: RaisedButton(
              color: AppStyles.uploadPostButtonColor,
              textColor: Colors.white,
              child: Icon(Icons.cloud_upload, size: 75.0,),
              onPressed: () {
                if(_formKey.currentState.validate())
                  uploadPost();
                  pushList(context);
              },
            ),
            button: true,
            enabled: true,
            onTapHint: '${AppStrings.uploadButtonHint}',
          )
        )
      ),
    );
  }

  void uploadPost() async {
    _formKey.currentState.save(); 
    foodWastePost.dateTime = DateTime.now();
    foodWastePost.photoUrl = await savePhotoToStorage(widget.image);
    saveFoodWastePostToStorage();
  }

  Future<String> savePhotoToStorage(File photo) async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child('${DateTime.now().toString()}${p.basename(photo.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(photo);
    await uploadTask.onComplete;
    final url = await storageReference.getDownloadURL();
    return url;
  }

  void saveFoodWastePostToStorage() {
    Firestore.instance.collection('${AppStrings.collectionKey}').add({
      '${AppStrings.dateTimeKey}': foodWastePost.dateTime.toString(),
      '${AppStrings.latitudeKey}': foodWastePost.latitude,
      '${AppStrings.longitudeKey}': foodWastePost.longitude,
      '${AppStrings.numLeftoverItemsKey}': foodWastePost.numLeftoverItems,
      '${AppStrings.photoUrlKey}': foodWastePost.photoUrl
    });
  }

  String validateLeftoverItems(String value) {
    if (isNumericInt(value)) {
      return null;
    } else {
      return '${AppStrings.leftoverItemsFieldHint}';
    }
  }

  double padding(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.height * 0.02;
    } else {
      return MediaQuery.of(context).size.height * 0.125;
    }
  }
  
  bool isNumericInt(String stringToTest) {
    return int.tryParse(stringToTest) != null;
  }

  void pushList(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (context) => ListScreen()),
      (Route<dynamic> route) => false);
  }
}