import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_view_app/core/route/route.dart';
import 'package:web_view_app/data/controller/primary/primary_screen_controller.dart';
import 'package:web_view_app/view/components/divider/custom_divider.dart';
import 'package:web_view_app/view/components/drawer/widget/drawer_heading_section.dart';
import 'package:web_view_app/view/components/drawer/widget/drawer_item.dart';
import 'package:web_view_app/view/components/drawer/widget/drawer_menu_section.dart';
import 'package:web_view_app/view/components/drawer/widget/drawer_settings_section.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../core/helper/shared_preference_helper.dart';
import '../../../data/controller/common/theme_controller.dart';
import '../../../data/services/api_service.dart';
import '../language/language_dialog.dart';

class CustomDrawer extends StatefulWidget {

  final PrimaryScreenController controller;
  final ThemeController themeController;
  const CustomDrawer({
    super.key,
    required this.controller,
    required this.themeController
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Container(
          width: size.width * .65,
          height: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.space10),bottomRight: Radius.circular(Dimensions.space10)),
            color: MyColor.getDrawerColor(),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DrawerHeadingSection(controller: widget.controller),
                const CustomDivider(dividerHeight: 1),
                DrawerMenuSection(controller: widget.controller),
                // const CustomDivider(dividerHeight: 1),
                Column(
                  children: [
                    widget.controller.isShowQr ? DrawerItem(
                      controller: widget.controller,
                      title: MyStrings.qrCodeScan,
                      leadingIcon: Icons.qr_code,
                      leadingIconWidth: 18,
                      press: (){
                        Get.toNamed(RouteHelper.qrCodeScannerScreen);
                      },
                    ): const SizedBox.shrink(),
                    widget.controller.isShowLanguage? DrawerItem(
                      controller: widget.controller,
                      title: MyStrings.language,
                      svgIconLeading: MyImages.lang,
                      leadingIconWidth: 18,
                      press: (){
                        final apiClient = Get.put(ApiClient(sharedPreferences: Get.find()));
                        SharedPreferences pref = apiClient.sharedPreferences;
                        String language = pref.getString(SharedPreferenceHelper.languageListKey)  ??'';
                        String countryCode = pref.getString(SharedPreferenceHelper.countryCode)   ??'US';
                        String languageCode = pref.getString(SharedPreferenceHelper.languageCode) ??'en';
                        Locale local = Locale(languageCode,countryCode);
                        showLanguageDialog(language, local, context);
                      },
                    ): const SizedBox.shrink(),
                    DrawerItem(
                      controller: widget.controller,
                      title: MyStrings.aboutUs,
                      leadingIcon: Icons.info_outline_rounded,
                      leadingIconWidth: 18,
                      press: (){
                        Get.toNamed(RouteHelper.aboutUs);
                      },
                    ),
                    widget.controller.isShowShareOption ? DrawerItem(
                      controller: widget.controller,
                      title: MyStrings.shareApp,
                      leadingIcon: Icons.share_outlined,
                      leadingIconWidth: 18,
                      press: (){
                        Share.share(widget.controller.primaryRepo.apiClient.getGSData().data?.generalSetting?.link.toString() ?? '');
                      },
                    ):const SizedBox.shrink(),
                  ],
                ),
                const CustomDivider(dividerHeight: 1),
                DrawerSettingsSection(controller: widget.controller, themeController: widget.themeController),
              ],
            ),
          ),
        ),
      );
  }
}




