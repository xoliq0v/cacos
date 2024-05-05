import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:web_view_app/core/helper/shared_preference_helper.dart';
import 'package:web_view_app/core/route/route.dart';
import 'package:web_view_app/core/utils/messages.dart';
import 'package:web_view_app/core/utils/my_strings.dart';
import 'package:web_view_app/data/controller/localization/localization_controller.dart';
import 'package:web_view_app/data/model/general_setting/general_setting_response_model.dart';
import 'package:web_view_app/data/model/global/response_model/response_model.dart';
import 'package:web_view_app/data/repo/auth/general_setting_repo.dart';
import 'package:web_view_app/view/components/snack_bar/show_custom_snackbar.dart';

import '../../../view/components/show_custom_snackbar.dart';

class SplashController extends GetxController  {

  GeneralSettingRepo repo;
  LocalizationController localizationController;
  SplashController({required this.repo,required this.localizationController});

  bool isLoading = true;

  GeneralSettingResponseModel model = GeneralSettingResponseModel();

  gotoNextPage() async {

    await loadLanguage();
    await repo.sendUserToken();
    bool isRemember = repo.apiClient.sharedPreferences.getBool(SharedPreferenceHelper.rememberMeKey) ?? false;
    noInternet      = false;
    update();
    initSharedData();
    getGSData(isRemember);

  }

  bool appOpenFirstTime = false;

  bool noInternet=false;

  void getGSData(bool isRemember)async{

    ResponseModel response = await repo.getGeneralSetting(); // its hit general setting api and store status -- true, 'Success', 200, response.body

    if(response.statusCode==200){
      model = GeneralSettingResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase()==MyStrings.success) {
        repo.apiClient.storeGeneralSetting(model);
        repo.apiClient.storeAppLogo(model.data!.logo.toString());
      }
      else {
        List<String>message=[MyStrings.somethingWentWrong];
        CustomSnackBar.error(errorList:message);
      }
    }else{
      if(response.statusCode==503){
        noInternet=true;
        update();
      }
      CustomSnackBar.error(errorList:[response.message]);
    }

    GeneralSettingResponseModel gsModel = repo.apiClient.getGSData(); //todo: i take sf stored data

    repo.apiClient.storeColor(gsModel.data!.generalSetting!.baseColor.toString(),gsModel.data!.generalSetting!.secondaryColor.toString());

    isLoading = false;
    update();



    if (isRemember) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(RouteHelper.bottomNavBar);
      });
    }
    else {
      Future.delayed(const Duration(seconds: 2), () {

        var gsData = gsModel.data?.generalSetting;

        if(gsData!.onBoardScreen == "1" && repo.apiClient.getFirstTimeAppOpeningStatus() == false){
            if(gsData.activeOnBoardScreen.toString() == "firstscreen"){
              Get.offAndToNamed(RouteHelper.onboardScreen1);
            }
            else if(gsData.activeOnBoardScreen.toString() == "secondscreen"){
              Get.offAndToNamed(RouteHelper.onboardScreen2);
            }
            else if(gsData.activeOnBoardScreen.toString() == "thirdscreen"){
              Get.offAndToNamed(RouteHelper.onboardScreen3);
            }
            else{
              Get.offAndToNamed(RouteHelper.onboardScreen4);
          }
        }
        else{
          Get.offAndToNamed(RouteHelper.primaryScreen);
        }
      });
    }
  }


  Future<bool> initSharedData() {

    if(!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.countryCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.countryCode, MyStrings.myLanguages[0].countryCode);
    }
    if(!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.languageCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageCode, MyStrings.myLanguages[0].languageCode);
    }
    return Future.value(true);
  }

  Future<void>loadLanguage()async{
    localizationController.loadCurrentLanguage();
    String languageCode = localizationController.locale.languageCode;
    ResponseModel response = await repo.getLanguage(languageCode);
    if(response.statusCode == 200){
      try{
        Map<String,Map<String,String>> language = {};
        var resJson = jsonDecode(response.responseJson); //this json comes from api
        saveLanguageList(response.responseJson); //saved in share preference
        var value = resJson['data']['language_data']=='{}'?{}:resJson['data']['language_data'] as Map<String,dynamic>;
        Map<String,String> json = {}; //keep language data as a key value pair
        value.forEach((key, value) {
          json[key] = value.toString();
        });
        language['${localizationController.locale.languageCode}_${localizationController.locale.countryCode}'] = json; //key:value
        Get.addTranslations(Messages(languages: language).keys);
      }catch(e){
        CustomSnackbar.showCustomSnackbar(errorList: [e.toString()], msg: [], isError: true);
      }

    } else{
      CustomSnackbar.showCustomSnackbar(errorList: [response.message],msg: [],isError: true);
    }

  }

  void saveLanguageList(String languageJson)async{
    print("LanguageData: ${languageJson}");
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, languageJson);
    return;
  }


}
