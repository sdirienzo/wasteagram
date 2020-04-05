import 'package:flutter/material.dart';
import '../app/appStyles.dart';

class AppScaffold extends StatelessWidget {

  final Widget title;
  final Color backgroundColor;
  final Widget body;
  final Widget floatingActionBtn;
  final FloatingActionButtonLocation floatingActionBtnLocation;

  AppScaffold({Key key, this.title, this.backgroundColor, this.body, this.floatingActionBtn, this.floatingActionBtnLocation}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        backgroundColor: backgroundColor,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: AppStyles.navBarIconColor),
      ),
      body: body,
      floatingActionButton: floatingActionBtn,
      floatingActionButtonLocation: floatingActionBtnLocation,
    );
  }
}