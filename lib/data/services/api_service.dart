import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_view_app/core/helper/shared_preference_helper.dart';
import 'package:web_view_app/core/route/route.dart';
import 'package:web_view_app/core/utils/method.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/core/utils/my_images.dart';
import 'package:web_view_app/core/utils/my_strings.dart';
import 'package:web_view_app/data/model/authorization/authorization_response_model.dart';
import 'package:web_view_app/data/model/general_setting/general_setting_response_model.dart';
import 'package:web_view_app/data/model/global/response_model/response_model.dart';

import '../model/drawing_item/dreawing_item_respoonse_model.dart';
import '../model/floating_button/floating_button_response_model.dart';
import '../model/nav_bar/nav_bar_model.dart';
import '../model/social/social_media_response_model.dart';


class ApiClient extends GetxService{

  SharedPreferences sharedPreferences;
  ApiClient({required this.sharedPreferences});

  Future<ResponseModel> request(
      String uri,
      String method,
      Map<String, dynamic>? params,
      {bool passHeader=false,
        bool isOnlyAcceptType=false,}) async {

    Uri url=Uri.parse(uri);
    http.Response response;


    try {
      if (method == Method.postMethod) {

        if(passHeader){

          initToken();
          if(isOnlyAcceptType){
            response = await http.post(url, body: params,headers: {
              "Accept": "application/json",
            });
          }
          else{
            response = await http.post(url, body: params,headers: {
              "Accept": "application/json",
              "Authorization": "$tokenType $token"
            });
          }
        }

        else{
          response = await http.post(url, body: params);
        }
      }
       else if (method == Method.postMethod) {

        if(passHeader){

          initToken();

          response = await http.post(
              url,
              body: params,
              headers: {
            "Accept": "application/json",
            "Authorization": "$tokenType $token"
          });

        }
        else{
          response = await http.post(
              url,
              body: params
          );
        }
      }
      else if (method == Method.deleteMethod) {

        response = await http.delete(url);

      } else if (method == Method.updateMethod) {

        response = await http.patch(url);

      } else {

        if(passHeader){
          initToken();
          response = await http.get(
              url,headers: {
            "Accept": "application/json",
            "Authorization": "$tokenType $token"
          });

        }else{
          response = await http.get(
            url,
          );
        }
      }

      print('url--------------${uri.toString()}');
      print('params-----------${params.toString()}');
      print('status-----------${response.statusCode}');
      print('body-------------${response.body.toString()}');
      print('token------------${token}');

      if (response.statusCode == 200) {
        try{
          AuthorizationResponseModel model=AuthorizationResponseModel.fromJson(jsonDecode(response.body));
          if( model.remark == 'profile_incomplete' ){
            Get.toNamed(RouteHelper.profileCompleteScreen);
          }else if( model.remark == 'kyc_verification' ){
            Get.offAndToNamed(RouteHelper.kycScreen);
          }else if( model.remark == 'unauthenticated' ){
            sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
            sharedPreferences.remove(SharedPreferenceHelper.token);
            Get.offAllNamed(RouteHelper.loginScreen);
          }
        }catch(e){
          e.toString();
        }

        return ResponseModel(true, 'Success', 200, response.body);
      } else if (response.statusCode == 401) {
        sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
        Get.offAllNamed(RouteHelper.loginScreen);
        return ResponseModel(false, MyStrings.unAuthorized.tr, 401, response.body);
      } else if (response.statusCode == 500) {
        return ResponseModel(false, MyStrings.serverError.tr, 500, response.body);
      } else {
        return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, response.body);
      }
    } on SocketException {
      return ResponseModel(false, MyStrings.noInternet.tr, 503, '');
    } on FormatException {
      return ResponseModel(false, MyStrings.badResponseMsg.tr, 400, '');
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, '');
    }
  }

  String token='';
  String tokenType='';

  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t =
      sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
      String? tType =
      sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
      token = t ?? '';
      tokenType = tType ?? 'Bearer';
    } else {
      token = '';
      tokenType = 'Bearer';
    }
  }

  storeGeneralSetting(GeneralSettingResponseModel model){
    String json=jsonEncode(model.toJson());
    sharedPreferences.setString(SharedPreferenceHelper.generalSettingKey, json);
    getGSData();
  }

  storeAppLogo(String logo){
    sharedPreferences.setString(SharedPreferenceHelper.appLogo, logo);
  }

  storeColor(String primaryColor,secondaryColor){
    sharedPreferences.setString(SharedPreferenceHelper.primaryColor, primaryColor);
    sharedPreferences.setString(SharedPreferenceHelper.secondaryColor, secondaryColor);
  }

  setFirstTimeAppOpeningStatus(bool value){
    sharedPreferences.setBool(SharedPreferenceHelper.appOpeningStatus, value);
  }

  setInitPrimaryScreenStatus(bool value){
    sharedPreferences.setBool(SharedPreferenceHelper.initPrimaryScreenStatus, value);
  }

  bool getInitPrimaryScreenStatus(){
    bool status =  sharedPreferences.getBool(SharedPreferenceHelper.initPrimaryScreenStatus) ?? false;
    return status;
  }

  setInitAboutUsScreenStatus(bool value){
    sharedPreferences.setBool(SharedPreferenceHelper.initAboutUsScreenStatus, value);
  }

  bool getInitAboutUsScreenStatus(){
    bool status =  sharedPreferences.getBool(SharedPreferenceHelper.initAboutUsScreenStatus) ?? false;
    return status;
  }

  GeneralSettingResponseModel getGSData(){
    String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
    GeneralSettingResponseModel model=GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    return model;
  }


  String getAppLogo(){
    String logo = sharedPreferences.getString(SharedPreferenceHelper.appLogo)??MyImages.city;
    return logo;
  }

  Color getPrimaryColor() {
    String primaryColor = sharedPreferences.getString(SharedPreferenceHelper.primaryColor) ?? MyColor.primaryColorCode.toString();

    // Make sure the color value is in a valid format (e.g., '20e85e' -> '0xFF20e85e')
    String colorValue = primaryColor.startsWith('0xFF') ? primaryColor : '0xFF$primaryColor';
    // String colorValue = primaryColor.startsWith('0xFF') ? primaryColor : '0xFF${MyColor.defaultPrimaryColor}';

    int color = int.parse(colorValue);
    Color mainColor = Color(color);

    return mainColor;
  }

  Color getSecondaryColor() {
    String secondaryColor = sharedPreferences.getString(SharedPreferenceHelper.secondaryColor) ?? MyColor.primaryColorCode.toString();

    // Make sure the color value is in a valid format (e.g., '20e85e' -> '0xFF20e85e')
    String colorValue = secondaryColor.startsWith('0xFF') ? secondaryColor : '0xFF$secondaryColor';

    int color = int.parse(colorValue);
    Color secondColor = Color(color);

    return secondColor;
  }


  storeAppOpeningStatus(bool status){
    sharedPreferences.setBool(SharedPreferenceHelper.appOpeningStatus, status);
  }

  bool getFirstTimeAppOpeningStatus(){
    bool status =  sharedPreferences.getBool(SharedPreferenceHelper.appOpeningStatus) ?? false;
    return status;
  }



  setNavBarList(List<NavBars> navList){
    var navBarList = navList.map((nav) => nav.toJson()).toList();
    String navBarListJson = jsonEncode(navBarList);
    sharedPreferences.setString(SharedPreferenceHelper.navBarList, navBarListJson);
  }

  List<NavBars> getNavBarList() {
    String navBarListJson = sharedPreferences.getString(SharedPreferenceHelper.navBarList) ?? "";
    List<dynamic> decodedList = jsonDecode(navBarListJson);
    List<NavBars> navList = decodedList.map((json) => NavBars.fromJson(json)).toList();
    return navList;
  }

  setFabItemList(List<FloatingButtons> fabList){
    var favList = fabList.map((fab) => fab.toJson()).toList();
    String favListJson = jsonEncode(favList);
    sharedPreferences.setString(SharedPreferenceHelper.favList, favListJson);
  }

  List<FloatingButtons> getFavItemList(){
    String favListJson = sharedPreferences.getString(SharedPreferenceHelper.favList) ?? "";
    List<dynamic> decodedList = jsonDecode(favListJson);
    List<FloatingButtons> favList = decodedList.map((json) => FloatingButtons.fromJson(json)).toList();
    return favList;
  }

  setDrawersItemList(List<Drawers> drawers){
    var drawerList = drawers.map((drawer) => drawer.toJson()).toList();
    String drawerListJson = jsonEncode(drawerList);
    sharedPreferences.setString(SharedPreferenceHelper.drawersList, drawerListJson);
  }

  List<Drawers> getDrawersItemList(){
    String drawerListJson = sharedPreferences.getString(SharedPreferenceHelper.drawersList) ?? "";
    List<dynamic> decodedList = jsonDecode(drawerListJson);
    List<Drawers> drawerList = decodedList.map((json) => Drawers.fromJson(json)).toList();
    return drawerList;
  }


  setSocialMediaData(List<SocialsMedia> social){
    var socialMediaList = social.map((social) => social.toJson()).toList();
    String socialListJson = jsonEncode(socialMediaList);
    sharedPreferences.setString(SharedPreferenceHelper.socialMediaData, socialListJson);
  }

  List<SocialsMedia> getSocialMediaData(){
    String socialMediaListJson = sharedPreferences.getString(SharedPreferenceHelper.socialMediaData) ?? "";
    List<dynamic> decodedList = jsonDecode(socialMediaListJson);
    List<SocialsMedia> socialList = decodedList.map((json) => SocialsMedia.fromJson(json)).toList();
    return socialList;
  }

  // String getCurrencyOrUsername({bool isCurrency = true,bool isSymbol = false}){
  //
  //   if(isCurrency){
  //     String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
  //     GeneralSettingResponseModel model=GeneralSettingResponseModel.fromJson(jsonDecode(pre));
  //     String currency = isSymbol?model.data?.generalSetting?.curSym??'':model.data?.generalSetting?.curText??'';
  //     return currency;
  //   } else{
  //     String username = sharedPreferences.getString(SharedPreferenceHelper.userNameKey)??'';
  //     return username;
  //   }
  //
  // }


  String getUserEmail(){
      String email = sharedPreferences.getString(SharedPreferenceHelper.userEmailKey)??'';
      return email;
  }

  bool getPasswordStrengthStatus(){
      String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
      GeneralSettingResponseModel model=GeneralSettingResponseModel.fromJson(jsonDecode(pre));
      bool checkPasswordStrength = model.data?.generalSetting?.securePassword.toString() == '0' ? false : true;
      return checkPasswordStrength;
  }

  String getPreviousDeviceUniqueId(){
    String uniqueId = sharedPreferences.getString(SharedPreferenceHelper.previousDeviceUniqueId)??'';
    return uniqueId;
  }

  Future<void> storeDeviceUniqueId(String uniqueId)async{
    await sharedPreferences.setString(SharedPreferenceHelper.previousDeviceUniqueId,uniqueId);
  }


  // String getTemplateName (){
  //     String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
  //     GeneralSettingResponseModel model=GeneralSettingResponseModel.fromJson(jsonDecode(pre));
  //     String templateName = model.data?.generalSetting?.activeTemplate??'';
  //     return templateName;
  // }

}