

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as ads;
import 'package:url_launcher/url_launcher.dart';
import 'package:web_view_app/core/utils/my_images.dart';
import 'package:web_view_app/data/model/adds/adds_response_model.dart';

import '../../../core/utils/my_strings.dart';
import '../../../core/utils/url_container.dart';
import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../../view/screens/bottom_nav_section/home/widget/pop_up_widget/pop_up_widget.dart';
import '../../../view/screens/web_view/my_web_view.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/add_repo/adds_repo.dart';
import '../primary/primary_screen_controller.dart';

class AddsController extends GetxController{

  AddRepo addRepo;
  AddsController({required this.addRepo});

  String popAdsUrl = '';

  Future<void>loadAdId()async{
    await getAllAddsId();
    if(addRepo.apiClient.getGSData().data?.generalSetting?.intAds.toString() == "1"){
      loadInterstitialAdd();
    }
    if(addRepo.apiClient.getGSData().data?.generalSetting?.popAds.toString() == "1"){
      getPopUpAds();
    }
    if(addRepo.apiClient.getGSData().data?.generalSetting?.ba_ads.toString() == "1"){
      loadBannerAdd();
    }
  }


  bool isAddLoaded = false;

  void setAddLoaded(bool status){
    isAddLoaded = status;
    update();
  }

  BannerAd? bannerAd;
  bool isLoaded = false;

  String interstitialUnitId = "";
  String bannerAddsId = "";
  List<PopUpAds> popUpAddsList = [];
  String popUpAddsImage = "";


  void loadInterstitialAdd() async{
    InterstitialAd? interstitialAd;
    final String adUnitId0 = Platform.isAndroid
        ? interstitialUnitId
        : MyStrings.videoDetailsInterstitialIOSAds;



    await Future.delayed(const Duration(seconds: 70));
    InterstitialAd.load(
        adUnitId: adUnitId0,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                },
                onAdClicked: (ad) {});
            interstitialAd = ad;
            interstitialAd?.show();
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }


  bool isShowAds = true;
  void loadBannerAdd(){
    final adUnitId = Platform.isAndroid
        ? bannerAddsId
        : MyStrings.homeIOSBanner;

    bannerAd = ads.BannerAd(
      adUnitId: adUnitId,
      request: const ads.AdRequest(),
      size: ads.AdSize.banner,
      listener: ads.BannerAdListener(
        onAdLoaded: (ad) {
          isLoaded = true;
          update();
        },
        onAdFailedToLoad: (ad, err) {
          isLoaded = false;
          update();
          ad.dispose();
        },

      ),
    )..load().whenComplete(()async{
      await Future.delayed(const Duration(seconds: 60));
      isShowAds = false;
      update();
    });
  }

  Future<void> getAllAddsId()async{
    ResponseModel model = await addRepo.getAdds();
    if(model.statusCode == 200){
      AddsResponseModel addsResponseModel = AddsResponseModel.fromJson(jsonDecode(model.responseJson));

      if(addsResponseModel.data != null){
        interstitialUnitId = addsResponseModel.data!.interstitialId.toString()??'';
        bannerAddsId = addsResponseModel.data!.bannerAds?.toString() ??"";

        if(addRepo.apiClient.getGSData().data?.generalSetting?.popAds.toString() == "1"){
          popUpAddsList.addAll(addsResponseModel.data!.popUpAds!);
        }
      }
    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }



  void getPopUpAds() async {

    if(popUpAddsList.isNotEmpty){

      List<String> addImages = [];

     for (var element in popUpAddsList) {addImages.add("${UrlContainer.imagePath}pop_up/${element.image}");}

      await Future.delayed(const Duration(seconds: 30));
      PopupBanner(
        context: Get.context!,
        useDots: false,
        images: addImages,
        onClick: (index) async{
          // _launchUrl(popUpAddsList[0].url.toString() ?? "https://www.remove.bg/");
          isAddLoaded = true;
          Get.find<PrimaryScreenController>().setNavBarWebViewStatus(false);
          Get.to(MyWebViewScreen(redirectUrl: popUpAddsList[index].url.toString(),isShowAppBar: true,));
        },
      ).show();
    }
  }
}