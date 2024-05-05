import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/data/controller/about/about_us_screen_controller.dart';
import 'package:web_view_app/data/controller/common/theme_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as ads;
import 'package:web_view_app/data/repo/about/about_repo.dart';

import '../../../../core/utils/my_strings.dart';
import '../../../../data/controller/adds/adds_controller.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  ads.BannerAd? _bannerAd;

  InterstitialAd? _interstitialAd;
  final String _adUnitId = Platform.isAndroid
      ? MyStrings.videoDetailsInterstitialAndroidAds
      : MyStrings.videoDetailsInterstitialIOSAds;

  final adUnitId = Platform.isAndroid
      ? MyStrings.homeAndroidBanner
      : MyStrings.homeIOSBanner;

  void _loadAd() {
    InterstitialAd.load(
        adUnitId: _adUnitId,
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
            _interstitialAd = ad;
            _interstitialAd?.show();
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));

      _bannerAd = ads.BannerAd(
        adUnitId: adUnitId,
        request: const ads.AdRequest(),
        size: ads.AdSize.banner,
        listener: ads.BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {});
          },
          onAdFailedToLoad: (ad, err) {
            ad.dispose();
          },
        ),
      )..load();
  }

  @override
  void initState() {
    Get.put(AddsController(addRepo: Get.find()));
    Get.put(AboutRepo(apiClient: Get.find()));
    Get.put(AboutUsScreenController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _loadAd();
        Get.find<AddsController>().loadAdId();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.getBackgroundColor().withOpacity(.8),
        body: Center(
          child: Stack(
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("First Page")),
                ],
              ),
              if (_bannerAd != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: ads.AdWidget(ad: _bannerAd!),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
