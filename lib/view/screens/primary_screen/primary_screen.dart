import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/data/controller/common/theme_controller.dart';
import 'package:web_view_app/data/controller/primary/primary_screen_controller.dart';
import 'package:web_view_app/data/repo/primary_repo/primary_repo.dart';
import 'package:web_view_app/view/components/app-bar/custom_appbar_mab.dart';
import 'package:web_view_app/view/components/bottom-nav-bar/google_nav_bar.dart';
import 'package:web_view_app/view/components/custom_loader/custom_loader.dart';
import 'package:web_view_app/view/components/drawer/custom_drawer.dart';
import 'package:web_view_app/view/screens/primary_screen/widget/expanded_fab.dart';

import '../../../data/services/api_service.dart';
import '../web_view/my_web_view.dart';
class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PrimaryRepo(apiClient: Get.find()));
    final controller =  Get.put(PrimaryScreenController(primaryRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (theme) => GetBuilder<PrimaryScreenController>(
        builder: (controller) => Scaffold(
          backgroundColor: MyColor.getBackgroundColor(),
          key: controller.scaffoldKey,
          drawer: CustomDrawer(controller: controller,themeController: theme),
          appBar: CustomAppBarWithMAB(
            controller: controller,
            title: Get.find<ApiClient>().getGSData().data!.generalSetting!.siteName.toString(),
            actionPress1: (){},
            actionPress2: (){},
            isShowBackBtn: Get.find<ApiClient>().getGSData().data?.generalSetting?.dwStatus.toString() == "1"? true : false,
            bgColor: MyColor.getPrimaryColor(),
            leadingDrawer: true,
            isTitleCenter: true,
          ),
          body: controller.isLoading ? CustomLoader(loaderColor: MyColor.getPrimaryColor()) :
            Get.find<ApiClient>().getGSData().data?.generalSetting?.navStatus.toString() == "1" ?
              MyWebViewScreen(redirectUrl: controller.selectedUrl.value,isShowAppBar: false):
              MyWebViewScreen(redirectUrl: controller.primaryRepo.apiClient.getGSData().data?.generalSetting?.webUrl?.toString() ??"",isShowAppBar: false),
          bottomNavigationBar: controller.primaryRepo.apiClient.getGSData().data?.generalSetting?.navStatus.toString() == "1" ? const NavigationBarWeView() : const SizedBox.shrink(),
          floatingActionButton: controller.floatingButtonList.isNotEmpty ?Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: ExpandableFab(
              isExpanded: controller.isExpanded,
              onPressed: controller.toggleExpand,
              controller: controller,
            ),
          ):const SizedBox.shrink(),
        ),
      ),
    );
  }
}
