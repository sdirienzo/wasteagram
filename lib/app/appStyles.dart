import 'package:flutter/material.dart';

class AppStyles {
  static const _textSizeTitle = 25.0;
  static const _textSizeLarge = 22.0;
  static const _textSizeDefault = 16.0;
  static const _textSizeSmall = 12.0;
  static final Color _textColorTitle = Colors.black;
  static final Color _textColorDefault = Colors.black;
  static final String _fontNameTitle = 'Pacifico';
  static final String _fontNameDefault = 'Montserrat';

  static final navBarColorDefault = Colors.white;
  static final Color navBarIconColor = Colors.black;

  static final newPostButtonColor = Colors.black;
  static final uploadPostButtonColor = Colors.black;

  static final titleText = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeTitle,
    color: _textColorTitle
  );

  static final textLarge = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeLarge,
    color: _textColorDefault
  );

  static final textDefault = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorDefault
  );

  static final textSmall = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize:  _textSizeSmall,
    color: _textColorDefault
  );

}