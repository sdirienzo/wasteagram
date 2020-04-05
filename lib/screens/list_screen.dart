import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'photo_screen.dart';
import 'post_detail_screen.dart';
import '../app/appStyles.dart';
import '../app/appStrings.dart';
import '../components/app_scaffold.dart';
import '../models/post.dart';

class ListScreen extends StatefulWidget {

  ListScreen({Key key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('${AppStrings.collectionKey}').orderBy('${AppStrings.dateTimeKey}', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.documents != null && snapshot.data.documents.length > 0) {
          return scaffoldWithPosts(context, snapshot);
        } else {
          return scaffoldWithoutPosts(context);
        }
      },
    );
  }

  Widget scaffoldWithPosts(BuildContext context, snapshot) {
    return AppScaffold(
      title: Text('${AppStrings.appTitle} - ${getTotalWastedItems(snapshot)}', style: AppStyles.titleText),
      backgroundColor: AppStyles.navBarColorDefault,
      body: SafeArea(
        child: foodWastePosts(context, snapshot),
      ),
      floatingActionBtn: floatingActionButton(context),
      floatingActionBtnLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget scaffoldWithoutPosts(BuildContext context) {
    return AppScaffold(
      title: Text('${AppStrings.appTitle} - 0', style: AppStyles.titleText),
      backgroundColor: AppStyles.navBarColorDefault,
      body: SafeArea(child: Center(child: CircularProgressIndicator())),
      floatingActionBtn: floatingActionButton(context),
      floatingActionBtnLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget foodWastePosts(BuildContext context, snapshot) {
    return ListView.separated(
      itemCount: snapshot.data.documents.length,
      separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black38),
      itemBuilder: (context, index) {
        var entry = snapshot.data.documents[index];
        var post = Post(
          photoUrl: entry['${AppStrings.photoUrlKey}'], 
          numLeftoverItems: entry['${AppStrings.numLeftoverItemsKey}'],
          dateTime: DateTime.parse(entry['${AppStrings.dateTimeKey}']),
          latitude: entry['${AppStrings.latitudeKey}'],
          longitude: entry['${AppStrings.longitudeKey}']
        );
        return postListItem(context, index, post);
    });
  }

  Widget postListItem(BuildContext context, int index, Post post) {
    final weekDay = DateFormat('EEEE').format(post.dateTime);
    final monthName = DateFormat('MMMM').format(post.dateTime); 
    final day = post.dateTime.day;
    final numLeftoverItems = post.numLeftoverItems;

    return ListTile(
      title: Text('$weekDay, $monthName $day', style: AppStyles.textLarge,),
      trailing: Text('$numLeftoverItems', style: AppStyles.textLarge,),
      onTap: () { pushPostDetail(context, post); },
    );
  }

  Widget floatingActionButton(BuildContext context) {
    return Semantics(
      child: FloatingActionButton(
        onPressed: () { pushNewPhoto(context); },
        child: Icon(Icons.add),
        backgroundColor: AppStyles.newPostButtonColor,
      ),
      button: true,
      enabled: true,
      onTapHint: '${AppStrings.newPostButtonHint}',
    );
  }

  int getTotalWastedItems(snapshot) {
    var totalWastedItems = 0;
    snapshot.data.documents.forEach( (post) => totalWastedItems += post['${AppStrings.numLeftoverItemsKey}']);
    return totalWastedItems;
  }
  
  void pushNewPhoto(BuildContext context) {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => PhotoScreen()));
  }

  void pushPostDetail(BuildContext context, Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostDetailScreen(post: post)));
  }
}