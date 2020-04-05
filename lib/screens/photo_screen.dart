import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'new_post_screen.dart';
import '../app/appStyles.dart';
import '../app/appStrings.dart';
import '../components/app_scaffold.dart';

class PhotoScreen extends StatefulWidget {

  PhotoScreen({Key key}) : super(key: key);

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  File image;

  void getImageFromCamera() async {
    File tempImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (tempImage != null) {
      setState(() {
        image = tempImage;
      });
      pushNewPost(context, image);
    }
  }

  void getImageFromGallery() async {
    File tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (tempImage != null) {
      setState(() {
        image = tempImage;
      });
      pushNewPost(context, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: Text('${AppStrings.appTitle}', style: AppStyles.titleText,),
      backgroundColor: AppStyles.navBarColorDefault,
      body: photoSourceChoices(context),
      floatingActionBtn: null,
      floatingActionBtnLocation: null,
    );
  }

  Widget photoSourceChoices(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            galleryButton(context),         
            cameraButton(context)
          ],
        )
      ),
    );
  }

  Widget galleryButton(BuildContext context){
    return Semantics(
      child: IconButton(
        icon: Icon(Icons.photo),
        iconSize: 100.0,
        onPressed: () {
          getImageFromGallery();
        },
      ),
      button: true,
      enabled: true,
      onTapHint: '${AppStrings.galleryButtonHint}',
    );
  }

  Widget cameraButton(BuildContext context) {
    return Semantics(
      child: IconButton(
        icon: Icon(Icons.photo_camera),
        iconSize: 100.0,
        onPressed: () {
          getImageFromCamera();
        },
      ),
      button: true,
      enabled: true,
      onTapHint: '${AppStrings.cameraButtonHint}',
    );
  }

  void pushNewPost(BuildContext context, File photo) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewPostScreen(image: photo)));
  }

}