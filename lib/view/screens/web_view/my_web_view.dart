import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as ads;
import 'package:permission_handler/permission_handler.dart';
import 'package:web_view_app/data/controller/adds/adds_controller.dart';
import 'package:web_view_app/view/components/custom_loader/custom_loader.dart';

import '../../../../core/utils/my_color.dart';
import '../../../data/controller/primary/primary_screen_controller.dart';
import '../../../data/repo/add_repo/adds_repo.dart';
import '../../components/app-bar/custom_appbar.dart';
import 'my_web_view_widget.dart';

class MyWebViewScreen extends StatefulWidget {
  final String redirectUrl;
  final bool isShowAppBar;

  const MyWebViewScreen({
    Key? key,
    required this.redirectUrl,
    this.isShowAppBar = true,
  }) : super(key: key);

  @override
  State<MyWebViewScreen> createState() => _MyWebViewScreenState();
}

class _MyWebViewScreenState extends State<MyWebViewScreen> {
  @override
  void initState() {
    Get.put(AddRepo(apiClient: Get.find()));
    final addsController = Get.put(AddsController(addRepo: Get.find()));
    super.initState();

    permissionServices();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (addsController.isAddLoaded == false) {
        addsController.loadAdId();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddsController>(
      builder: (adds) => GetBuilder<PrimaryScreenController>(

        builder: (controller) => controller.isLoading
            ? CustomLoader(loaderColor: MyColor.getPrimaryTextColor())
            : Scaffold(
                backgroundColor: Colors.black,
                appBar: widget.isShowAppBar ? CustomAppBar(title: controller.siteName.tr, isShowBackBtn: true) : null,
                body: Center(
                  child: Stack(
                    children: [
                      MyWebViewWidget(url: widget.redirectUrl, controllers: controller),
                      if (adds.bannerAd != null && adds.isAddLoaded == false && adds.isShowAds)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SafeArea(
                              child: SizedBox(
                            width: adds.bannerAd!.size.width.toDouble(),
                            height: adds.bannerAd!.size.height.toDouble(),
                            child: ads.AdWidget(ad: adds.bannerAd!),
                          )),
                        )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget favoriteButton() {
    return FloatingActionButton(
      backgroundColor: MyColor.colorRed,
      onPressed: () async {
        Get.back();
      },
      child: const Icon(
        Icons.cancel,
        color: MyColor.colorWhite,
        size: 30,
      ),
    );
  }

  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.microphone,
      Permission.mediaLibrary,
      Permission.camera,
      Permission.storage,
      Permission.location,
    ].request();

    return statuses;
  }
}
