import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../app/appStyles.dart';
import '../app/appStrings.dart';
import '../models/post.dart';
import '../components/app_scaffold.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  PostDetailScreen({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: Text('${AppStrings.appTitle}', style: AppStyles.titleText),
      backgroundColor: AppStyles.navBarColorDefault,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 30, top: 20, right: 30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                postDate(),
                postPhoto(context),
                leftoverItems(),
                latitudeAndLongitude()
              ]
            )
          )
        )
      ),
      floatingActionBtn: null,
      floatingActionBtnLocation: null,
    );
  }

  Widget postDate() {
    final weekDay = DateFormat('EEEE').format(post.dateTime);
    final monthName = DateFormat('MMMM').format(post.dateTime); 
    final day = post.dateTime.day;
    final year = post.dateTime.year;

    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Text('$weekDay, $monthName $day $year', style: AppStyles.textLarge)
          ),
        )
      ]
    );
  }

  Widget postPhoto(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Image.network(
              post.photoUrl, 
              height: photoSize(context),
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                if (loadingProgress == null)
                  return child;
                return CircularProgressIndicator();
              },
              fit: BoxFit.cover
            )
          )
        )
      ],
    );
  }

  Widget leftoverItems() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Text('Items: ${post.numLeftoverItems}', style: AppStyles.textLarge)
          )
        )
      ],
    );
  }

  Widget latitudeAndLongitude() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Text('(${post.latitude}, ${post.longitude})', style: AppStyles.textDefault)
          )
        )
      ],
    );
  }

  double photoSize(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.height * 0.5;
    } else {
      return MediaQuery.of(context).size.height * 0.275;
    }
  }
}