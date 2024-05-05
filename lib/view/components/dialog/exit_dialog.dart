import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web_view_app/core/utils/dimensions.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/core/utils/my_strings.dart';
import 'package:web_view_app/core/utils/style.dart';
import 'package:web_view_app/view/components/buttons/rounded_button.dart';



showExitDialog(BuildContext context){

    AwesomeDialog(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.space10),
      context: context,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: MyColor.getCardBgColor(),
      width: MediaQuery.of(context).size.width,
      buttonsBorderRadius: BorderRadius.circular(Dimensions.defaultRadius),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      onDismissCallback: (type) {},
      headerAnimationLoop: false,
      animType: AnimType.scale,
      title: MyStrings.exitTitle.tr,
      titleTextStyle: regularLarge.copyWith(color: MyColor.getPrimaryTextColor(), fontWeight: FontWeight.w600),
      showCloseIcon: false,
      btnCancel: RoundedButton(text: MyStrings.no.tr, press: (){
        Navigator.pop(context);
      },horizontalPadding: 3,verticalPadding: 3,color: MyColor.getHintTextColor(),),
      btnOk: RoundedButton(text: MyStrings.yes.tr, press: (){
        SystemNavigator.pop();
      },horizontalPadding: 3,verticalPadding: 3,color: MyColor.colorRed, textColor: MyColor.colorWhite),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        SystemNavigator.pop();
      },
    ).show();
  }
