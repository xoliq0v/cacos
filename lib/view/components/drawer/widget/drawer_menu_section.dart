import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:web_view_app/core/utils/url_container.dart';
import 'package:web_view_app/data/controller/adds/adds_controller.dart';
import 'package:web_view_app/view/screens/web_view/my_web_view.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/controller/primary/primary_screen_controller.dart';
import 'drawer_item.dart';
class DrawerMenuSection extends StatelessWidget {
  const DrawerMenuSection({
    super.key,
    required this.controller,
  });

  final PrimaryScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Dimensions.drawerMenuPadding,
          child: Text(MyStrings.menu,style: semiBoldDefault.copyWith(fontSize: 13,color: MyColor.getLightGrayColor())),
        ),
        Column(
            children: List.generate(controller.drawingItemList.length, (index) => DrawerItem(
              controller: controller,
              title: controller.drawingItemList[index].name.toString(),
              leadingImage: "${UrlContainer.domainUrl}/assets/images/drawer_item/${controller.drawingItemList[index].icon}",
              press: (){
                Get.find<AddsController>().setAddLoaded(true);
                controller.setNavBarWebViewStatus(false);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyWebViewScreen(redirectUrl: controller.drawingItemList[index].url.toString())));
              },
            )
          )
        ),
      ],
    );
  }
}
