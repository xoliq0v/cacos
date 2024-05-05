import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_view_app/data/repo/onboard_repo/onboard_repo.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/general_setting/general_setting_response_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../model/onboard/on_board_response_model.dart';

class OnboardController extends GetxController{

  OnboardRepo onboardRepo;

  OnboardController({required this.onboardRepo});

  int currentIndex = 0;
  PageController? controller = PageController();

  void setCurrentIndex(int index){
    currentIndex = index;
    update();
  }
  List<ObsContent> onboardContentList = [];

  bool isLoading = true;

  Future<void> getAllData() async{

    await getOnboardData();
    await loadData();
    onboardRepo.apiClient.storeAppOpeningStatus(true); //todo: used for showing first time onboard screen
    isLoading = false;
    update();
  }

  GeneralSettingResponseModel generalSettingResponseModel = GeneralSettingResponseModel();

  List<String> onBoardImage = [];
  Future<void> loadData() async {

    generalSettingResponseModel = onboardRepo.apiClient.getGSData();


  }

  Future<void> getOnboardData()async{
    ResponseModel model = await onboardRepo.getOnboardContent();
    if(model.statusCode == 200){
      OnBoardResponseModel onboardResponseModel = OnBoardResponseModel.fromJson(jsonDecode(model.responseJson));
      if(onboardResponseModel.data?.obsContent != null && onboardResponseModel.data!.obsContent!.isNotEmpty){
        onboardContentList.clear();
        onboardContentList.addAll(onboardResponseModel.data!.obsContent!);
      }
    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

}