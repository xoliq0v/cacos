import 'package:flutter/material.dart';

import '../utils/my_color.dart';

ThemeData light = ThemeData(
    fontFamily: 'Inter',
    primaryColor:MyColor.getPrimaryColor(),
    brightness: Brightness.light,
    scaffoldBackgroundColor: MyColor.getBackgroundColor(),
    hintColor: MyColor.hintTextColor,
    buttonTheme: ButtonThemeData(
      buttonColor: MyColor.getPrimaryColor(),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: MyColor.getPrimaryColor(),
        elevation: 0,
        iconTheme: IconThemeData(
            size: 20,
            color: MyColor.getTextFieldTextColor()
        )
    ),
    checkboxTheme: CheckboxThemeData(
     checkColor: MaterialStateProperty.all(MyColor.colorBlack),
     fillColor: MaterialStateProperty.all(MyColor.primaryColor),

));