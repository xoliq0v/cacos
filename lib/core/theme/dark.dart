
import 'package:flutter/material.dart';

import '../utils/my_color.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Inter',
  primaryColor: MyColor.getPrimaryColor(),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: MyColor.getBackgroundColor(),
  hintColor: MyColor.hintTextColor,
  buttonTheme: ButtonThemeData(
    buttonColor: MyColor.getButtonColor(),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: MyColor.getPrimaryColor(),
    iconTheme: IconThemeData(
      size: 20,
      color: MyColor.getTextFieldTextColor()
    )
  ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(MyColor.colorWhite),
      fillColor: MaterialStateProperty.all(MyColor.colorWhite),
      overlayColor: MaterialStateProperty.all(MyColor.greenSuccessColor),
    )
);