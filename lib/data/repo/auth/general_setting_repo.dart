import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_view_app/core/helper/shared_preference_helper.dart';
import 'package:web_view_app/core/utils/method.dart';
import 'package:web_view_app/core/utils/my_strings.dart';
import 'package:web_view_app/core/utils/url_container.dart';
import 'package:web_view_app/data/model/global/response_model/response_model.dart';
import 'package:web_view_app/data/services/api_service.dart';


class GeneralSettingRepo {
  SharedPreferences sharedPreferences;
  ApiClient apiClient;
  GeneralSettingRepo({required this.apiClient,required this.sharedPreferences});

  Future<dynamic> getGeneralSetting() async {
    String url='${UrlContainer.baseUrl}${UrlContainer.generalSettingEndPoint}';
    ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: false); //store here -- true, 'Success', 200, response.body
    return response; // return -- true, 'Success', 200, response.body
  }


  Future<dynamic> getLanguage(String languageCode) async {
    try{

      String url= "${UrlContainer.baseUrl}${UrlContainer.language}$languageCode";
      ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: false);
      return response;
    }catch(e){
      return ResponseModel(false, MyStrings.somethingWentWrong, 300, '');
    }
  }

  Future<bool> sendUserToken() async {

    String deviceToken;
    if (apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.fcmDeviceKey)) {
      deviceToken = apiClient.sharedPreferences.getString(SharedPreferenceHelper.fcmDeviceKey) ?? '';
      return false;
    } else {
      deviceToken = '';
    }

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    bool success = false;

    if (deviceToken.isEmpty) {

      firebaseMessaging.getToken().then((fcmDeviceToken) async {
        success = await sendUpdatedToken(fcmDeviceToken ?? '');
      });

    } else {
      firebaseMessaging.onTokenRefresh.listen((fcmDeviceToken) async {
        if (deviceToken == fcmDeviceToken) {
          success = true;
        } else {
          apiClient.sharedPreferences.setString(SharedPreferenceHelper.fcmDeviceKey, fcmDeviceToken);
          success = await sendUpdatedToken(fcmDeviceToken);
        }
      });
    }
    return success;
  }
  Future<bool> sendUpdatedToken(String deviceToken) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.deviceTokenEndPoint}';
    Map<String, String> map = deviceTokenMap(deviceToken,deviceToken);
    var respon = await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return true;
  }

  Map<String, String> deviceTokenMap(String deviceToken,String imei) {
    Map<String, String> map = {
      'token': deviceToken.toString(),
      'imei': imei,
    };
    return map;
  }

}

