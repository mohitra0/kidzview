import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Resize {
  static final Resize _singleton = Resize._internal();

  late double _height;
  late double _width;
  late double _bodyText;
  late double _paddingTop;
  late double _resposiveConst;
  late double _lableText;
  late double _titleText;
  late double _headerText;
  late double _iconSize;

  late double fontSizeSmall;
  late double fontSizebase;
  late double fontSizeLarge;
  late double heading4;
  late double heading3;
  late double heading2;
  late double heading1;
  late double linheight = 1.4;
  String? font = GoogleFonts.poppins().fontFamily;

  TextStyle get appBarTitleStyle => TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w600,
      fontSize: _headerText,
      fontFamily: GoogleFonts.lato().fontFamily);
  String get globalFontFamily => font!;

  get mediumSpace => const SizedBox(
        height: 30,
      );
  get fromPaddingHorizontal => _headerText;
  get fromPaddingHorizontal2 => _headerText;
  get formPaddingVertical => resposiveConst * 40;
  //vertical2 is used forms inside app
  get formPaddingVertical2 => resposiveConst * 20;
  get resposiveConst => _resposiveConst;
  get tempConst => double.parse((12.3412).toStringAsFixed(2));
  get height => _height;
  get width => _width;
  get lableText => _lableText;
  get titleText => _titleText;
  get headerText => _headerText;
  get bodyText => _bodyText;
  get paddingTop => _paddingTop;
  get iconSize => _iconSize;
  void setValue(BuildContext context) {
    _singleton._height = 0.9 * MediaQuery.of(context).size.height;
    _singleton._width = MediaQuery.of(context).size.width;
    _singleton._paddingTop = MediaQuery.of(context).padding.top;
    _singleton._bodyText = _height * 0.02; //! for the body of container * 14-16
    _singleton._titleText = _height * 0.027; //! for name of user
    _singleton._iconSize = _height * 0.02; //! for all the icons inside
    _singleton._headerText =
        height * 0.023; //! for container heading -- respnsiveConst * 18-20
    _singleton._lableText =
        height * 0.016; //! lable for pending, completed :) 10-13
    _singleton._resposiveConst = (_height / _width) / 2.345; // 3.09000298;
    // Initialize font sizes
    fontSizeSmall = _height * 0.018;
    fontSizebase = _height * 0.020;
    fontSizeLarge = _height * 0.024;
    heading4 = _height * 0.026;
    heading3 = _height * 0.028;
    heading2 = _height * 0.032;
    heading1 = _height * 0.034;
  }

  factory Resize() {
    return _singleton;
  }

  Resize._internal();
}
