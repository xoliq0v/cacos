import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_view_app/core/utils/url_container.dart';
import 'package:web_view_app/data/controller/common/theme_controller.dart';
import 'package:web_view_app/data/controller/primary/primary_screen_controller.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import 'widget/nav_component/gbutton.dart';
import 'widget/nav_component/gnav.dart';
class NavigationBarWeView extends StatelessWidget {
  const NavigationBarWeView({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (controller) => GetBuilder<PrimaryScreenController>(builder: (controller){
        return Container(
          padding: Dimensions.navBarPadding,
          decoration: BoxDecoration(
            color: MyColor.getNavBarColor(),
            boxShadow: [
              BoxShadow(
                blurRadius: Dimensions.space20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: GNav(
                selectedIndex: controller.selectedIndex,
                onTabChange: (value) {
                  controller.setSelectedIndex(value);
                },
                rippleColor: MyColor.getNavRippleColor(),
                gap: 8,
                activeColor: MyColor.colorWhite,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space10),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: MyColor.getTabBgColor(),
                color: MyColor.getIconColor().withOpacity(.6),
                tabs: List.generate(controller.navBarList.length, (index) => GButton(
                  imageLink: "${UrlContainer.domainUrl}/assets/images/navbar_item/${controller.navBarList[index].icon}",
                  text: controller.navBarList[index].title.toString(),
                  active: controller.selectedIndex == index,
                  iconActiveColor: Colors.white,
                ))
            ),
          ),
        );
      }),
    );
  }
}
