import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_view_app/core/utils/my_images.dart';
import 'package:web_view_app/data/model/drawing_item/dreawing_item_respoonse_model.dart';
import 'package:web_view_app/data/model/floating_button/floating_button_response_model.dart';
import 'package:web_view_app/data/model/general_setting/general_setting_response_model.dart';
import 'package:web_view_app/data/model/global/response_model/response_model.dart';
import 'package:web_view_app/data/model/nav_bar/nav_bar_model.dart';
import 'package:web_view_app/data/repo/primary_repo/primary_repo.dart';
import 'package:web_view_app/data/services/api_service.dart';
import 'package:web_view_app/view/screens/web_view/my_web_view.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../../view/screens/bottom_nav_section/home/home_screen.dart';

class PrimaryScreenController extends GetxController{

  PrimaryRepo primaryRepo;

  PrimaryScreenController({required this.primaryRepo});

  final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 0;
  bool isExpanded = false;
  int totalRating = 23;

  bool isLoading = true;
  String siteName = "";
  bool isShowQr = true;
  bool isShowNavBar = true;
  bool isShowAdd = true;
  bool isShowRating = true;
  bool isShowShareOption = true;
  bool isShowLanguage = true;

  bool navBarWebView = true;

  List<NavBars> navBarList = [];
  List<FloatingButtons> floatingButtonList = [];
  List<Drawers> drawingItemList = [];

  RxString selectedUrl = ''.obs;
  setNavBarWebViewStatus(bool status){
    navBarWebView = status;
    update();
  }


  bool isUrlChanging= false;

  void setSelectedIndex(int index){
    isUrlChanging = true;
    update();
    selectedIndex = index;
    selectedUrl.value = navBarList[selectedIndex].url??'';
    isUrlChanging = true;
    update();
  }

  void toggleExpand() {
    isExpanded = !isExpanded;
    update();
  }



  Future<void> getAllData() async{

    loadData();
    await getNavBarList();
    await getFloatingButtonList();
    await getDrawingItemList();

    isLoading = false;
    update();

    primaryRepo.apiClient.setInitPrimaryScreenStatus(true);
  }

  GeneralSettingResponseModel generalSettingResponseModel = GeneralSettingResponseModel();

  Future<void> loadData() async {
    generalSettingResponseModel = primaryRepo.apiClient.getGSData();
    siteName =  generalSettingResponseModel.data?.generalSetting?.siteName ?? "";
    isShowQr = generalSettingResponseModel.data?.generalSetting?.qrCode == "1" ? true : false;
    isShowLanguage = generalSettingResponseModel.data?.generalSetting?.multiLanguage == "1" ? true : false;
    isShowRating = generalSettingResponseModel.data?.generalSetting?.rating == "1" ? true : false;
    isShowShareOption = generalSettingResponseModel.data?.generalSetting?.linkShareStatus == "1" ? true : false;

    if(primaryRepo.apiClient.getInitPrimaryScreenStatus()){
      navBarList = primaryRepo.apiClient.getNavBarList();
      floatingButtonList = primaryRepo.apiClient.getFavItemList();
      drawingItemList = primaryRepo.apiClient.getDrawersItemList();
      isLoading = false;
      print("check:: $drawingItemList");
    }
  }

  Future<void> getNavBarList()async{
    ResponseModel model = await primaryRepo.getNavBarItem();
    if(model.statusCode == 200){
      NavBarResponseModel navBarResponseModel = NavBarResponseModel.fromJson(jsonDecode(model.responseJson));
      if(navBarResponseModel.data?.navBars != null && navBarResponseModel.data!.navBars!.isNotEmpty){
        navBarList.clear();
        navBarList.addAll(navBarResponseModel.data!.navBars!);
        if(navBarList.isNotEmpty) {
          await primaryRepo.apiClient.setNavBarList(navBarList);
        }
        if(navBarList.isNotEmpty){
          setSelectedIndex(0);
        }
      }
    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }


  Future<void> getFloatingButtonList()async{
    ResponseModel model = await primaryRepo.getFloatingButtonItem();
    if(model.statusCode == 200){
      FloatingButtonResponseModel floatingButtonResponseModel = FloatingButtonResponseModel.fromJson(jsonDecode(model.responseJson));
      if(floatingButtonResponseModel.data?.floatingButtons != null && floatingButtonResponseModel.data!.floatingButtons!.isNotEmpty){
        floatingButtonList.clear();
        floatingButtonList.addAll(floatingButtonResponseModel.data!.floatingButtons!);
          if(floatingButtonList.isNotEmpty){
           await primaryRepo.apiClient.setFabItemList(floatingButtonList);
          }
      }
    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  Future<void> getDrawingItemList()async{

    ResponseModel model = await primaryRepo.getDrawingItem();
    if(model.statusCode == 200){
      DrawingItemResponseModel drawingItemResponseModel = DrawingItemResponseModel.fromJson(jsonDecode(model.responseJson));
      if(drawingItemResponseModel.data?.drawers != null && drawingItemResponseModel.data!.drawers!.isNotEmpty){
        drawingItemList.clear();
        drawingItemList.addAll(drawingItemResponseModel.data!.drawers!);
        if(drawingItemList.isNotEmpty){
          await primaryRepo.apiClient.setDrawersItemList(drawingItemList);
        }
      }
    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  bool isWebViewContainError = false;
  void changeErrorStatus(bool status) {
    isWebViewContainError = status;
    update();
  }

}