import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_view_app/data/controller/common/theme_controller.dart';
import 'package:web_view_app/data/controller/primary/primary_screen_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_view_app/data/services/api_service.dart';

class MyColor{

  static Color getAppbarTextColor() {
    double brightness = getPrimaryColor().computeLuminance();
    return brightness > 0.5 ? Colors.black : Colors.white;
  }

  static const Color primaryColor                = colorBlackSolid;
  static const Color lPrimaryColor               = colorWhite;
  static const Color secondaryColor              = Color(0xffF6F7FE);
  static const Color screenBgColor               = Color(0xFFFFFFFF);
  static const Color primaryTextColor            = Color(0xff474747);
  static const Color contentTextColor            = Color(0xff777777);
  static const Color lineColor                   = Color(0xffECECEC);
  static const Color borderColor                 = Color(0xffD9D9D9);
  static const Color bodyTextColor               = Color(0xFF898989);
  static const Color iconsBackground             = Color(0xFFF9F9F9);
  static const Color backGroundScreenColor       = colorLightGrey;

  static const Color titleColor                  = Color(0xff474747);
  static const Color labelTextColor              = Color(0xff444444);
  static const Color smallTextColor1             = Color(0xff555555);

  static const Color appBarColor                 = primaryColor;
  static const Color appBarContentColor          = colorWhite;

  static const Color lineThroughColor          =  bodyTextColor;

  static const Color textFieldDisableBorderColor = Color(0xffCFCEDB);
  static const Color textFieldEnableBorderColor  = primaryColor;
  static const Color hintTextColor               = Color(0xff98a1ab);

  static const Color primaryButtonColor          = primaryColor;
  static const Color primaryButtonTextColor      = colorWhite;
  static const Color secondaryButtonColor        = colorWhite;
  static const Color secondaryButtonTextColor    = colorBlack;

  static const Color iconColor                   = Color(0xff555555);
  static const Color filterEnableIconColor       = primaryColor;
  static const Color filterIconColor             = iconColor;
  static const Color cartSubtitleColor           = iconColor;

  static const Color colorWhite                  = Color(0xffFFFFFF);
  static const Color colorBlack                  = Color(0xff262626);
  static const Color colorBlackSolid             = Color(0xff000000);
  static const Color colorGreen                  = Color(0xff28C76F);
  static const Color colorRed                    = Color(0xFFD92027);
  static const Color colorGrey                   = Color(0xff555555);
  static const Color colorBlue                   = Color(0xff2692F4);
  static const Color colorLightGrey              = Color(0xffF2F2F2);
  static const Color colorOrange                 = Color(0xffF2994A);
  static const Color colorLightBrown             = Color(0xffC4A484);
  static const Color transparentColor            = Colors.transparent;

  static const Color greenSuccessColor           = greenP;
  static const Color redCancelTextColor          = Color(0xFFF93E2C);
  static const Color highPriorityPurpleColor     = Color(0xFF7367F0);
  static const Color pendingColor                = Colors.orange;

  static const int primaryColorCode              = 0xFF1C3A6F;
  static const Color greenP                      = Color(0xFF28C76F);
  static const Color containerBgColor            = Color(0xffF9F9F9);
  static const Color stockTextColor              = Color(0xff19BC5A);
  static const Color paidContentColor            = Color(0xff1EC892);
  static const Color deliveryTextColor           = Color(0xff0BD236);
  static const Color canceledTextColor           = Color(0xffED1F23);
  static const Color inProgressTextColor         = Color(0xffFFA500);
  static const Color unpaidColor                 = Color(0xff5F6FFF);
  static const Color textFieldColor              = Color(0xff23262B);
  static const Color textFieldColors             = Color(0xff232023);
  static const Color tabBgColor                  = Color(0xff232023);
  static const Color drawerColorDarkMode         = Color(0xFF2E303A);
  static const int defaultPrimaryColor           = 0xFF1C3A6F;
  // static String defaultPrimaryColor = "FF0060";

  static Color getPrimaryColor(){
    // return Get.find<ThemeController>().darkTheme ? colorBlackSolid : colorWhite;
    return Get.find<ApiClient>().getPrimaryColor();
  }

  static Color getNavBarColor(){
    return Get.find<ThemeController>().darkTheme ? colorBlackSolid : colorWhite;
  }

  static Color getPrimaryTextColor(){
    return Get.find<ThemeController>().darkTheme ? colorWhite : colorBlack;
  }
  static Color getIconColor(){
    return Get.find<ThemeController>().darkTheme ? colorWhite : colorBlack;
  }

  static Color getBackgroundColor(){
    return Get.find<ThemeController>().darkTheme ? colorBlack : colorWhite;
  }

  static Color getLoginBgColor(){
    return Get.find<ThemeController>().darkTheme ? colorBlackSolid : colorWhite;
  }

  static Color getTextFieldColor(){
    return Get.find<ThemeController>().darkTheme ? textFieldColors : textFieldColor.withOpacity(.4);
    return textFieldColor;
  }

  static Color getLightGrayColor(){
    return Get.find<ThemeController>().darkTheme ? MyColor.colorWhite.withOpacity(.7) : textFieldColor.withOpacity(.4);
  }

  static Color getTextFieldTextColor(){
    return Get.find<ThemeController>().darkTheme ? MyColor.colorWhite : colorBlack;
  }

  static Color getDrawerColor(){
    // return Get.find<ThemeController>().darkTheme ? MyColor.tabBgColor : colorWhite;
    return Get.find<ThemeController>().darkTheme ? drawerColorDarkMode : colorWhite;
  }

  static Color getSplashColor(){
    return colorBlack;
  }

  static Color getButtonColor(){
    // return highPriorityPurpleColor;
    return colorBlue;
  }

  static Color getOnboardTextColor(){
    return colorWhite;
  }

  static Color getTabBgColor(){
    return tabBgColor;
  }

  static Color getNavBarIconBgColor(){
    return MyColor.colorWhite.withOpacity(.5);
  }

  static Color getNavRippleColor(){
    return Colors.grey[300]!;
  }






  static Color getScreenBgColor(){
    return screenBgColor;
  }

  static Color getGreyText(){
    return  MyColor.colorBlack.withOpacity(0.5);
  }

  static Color getAppBarColor(){
    return appBarColor;
  }
  static Color getAppBarContentColor(){
    return appBarContentColor;
  }

  static Color getHeadingTextColor(){
    return primaryTextColor;
  }

  static Color getContentTextColor(){
    return contentTextColor;
  }

  static Color getLabelTextColor(){
    return colorWhite;
  }

  static Color getHintTextColor(){
    return hintTextColor;
  }

  static Color getTextFieldDisableBorder(){
    return textFieldDisableBorderColor;
  }

  static Color getTextFieldEnableBorder(){
    return textFieldEnableBorderColor;
  }

  static Color getPrimaryButtonColor(){
    return primaryButtonColor;
  }

  static Color getPrimaryButtonTextColor(){
    return primaryButtonTextColor;
  }

  static Color getSecondaryButtonColor(){
    return secondaryButtonColor;
  }

  static Color getSecondaryButtonTextColor(){
    return secondaryButtonTextColor;
  }

  static Color getFilterDisableIconColor(){
    return filterIconColor;
  }

  static Color getSearchEnableIconColor(){
    return colorRed;
  }

  static Color getTransparentColor(){
    return transparentColor;
  }

  static Color getTextColor(){
    return colorWhite;
  }

  static Color getCardBgColor(){
    return Get.find<ThemeController>().darkTheme? colorBlackSolid : colorWhite;
  }

  static List<Color>symbolPlate = [
  const Color(0xffDE3163),
  const Color(0xffC70039),
  const Color(0xff900C3F),
  const Color(0xff581845),
  const Color(0xffFF7F50),
  const Color(0xffFF5733),
  const Color(0xff6495ED),
  const Color(0xffCD5C5C),
  const Color(0xffF08080),
  const Color(0xffFA8072),
  const Color(0xffE9967A),
  const Color(0xff9FE2BF),
  ];

  static getSymbolColor(int index) {
     int colorIndex = index>10?index%10:index;
     return symbolPlate[colorIndex];
  }

}