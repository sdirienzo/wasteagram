import 'package:flutter/material.dart';
import 'app/appStrings.dart';
import 'screens/list_screen.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      home: ListScreen()
    );
  }
}