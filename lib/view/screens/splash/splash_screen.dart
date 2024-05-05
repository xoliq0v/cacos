import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/core/utils/my_images.dart';
import 'package:web_view_app/core/utils/util.dart';
import 'package:web_view_app/data/controller/localization/localization_controller.dart';
import 'package:web_view_app/data/controller/splash/splash_controller.dart';
import 'package:web_view_app/data/repo/auth/general_setting_repo.dart';
import 'package:web_view_app/data/services/api_service.dart';
import 'package:web_view_app/view/components/custom_loader/custom_loader.dart';
import 'package:web_view_app/view/screens/splash/widget/splash_content.dart';

import '../../../core/utils/dimensions.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    MyUtils.splashScreen();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(sharedPreferences: Get.find(),apiClient: Get.find()));
    final controller = Get.put(SplashController(repo: Get.find(),localizationController: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      controller.gotoNextPage();

    });
  }

  @override
  void dispose() {
    MyUtils.allScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SplashController>(
        builder: (controller) => Scaffold(
          backgroundColor: controller.noInternet ? MyColor.colorWhite : MyColor.getBackgroundColor(),
          body: Container(
            color: MyColor.getPrimaryColor(),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Image.asset(MyImages.appLogoCircle,width: Dimensions.appLogoSize,height: Dimensions.appLogoSize))
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


