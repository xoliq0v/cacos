import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_view_app/data/controller/primary/primary_screen_controller.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
class DrawerHeadingSection extends StatelessWidget {

  final PrimaryScreenController controller;

  const DrawerHeadingSection({
    super.key,
    required this.controller

  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrimaryScreenController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.only(left: Dimensions.space20,top: Dimensions.space30),
        child: Row(
          children: [
            CircleAvatar(
              radius: Dimensions.space18,
              backgroundColor: MyColor.getPrimaryColor(),
              child: Text(controller.siteName[0].tr,style: boldLarge.copyWith(color: MyColor.getAppbarTextColor(),fontSize: 18)),
            ),
            const SizedBox(width: Dimensions.space12),
            Text(controller.siteName.tr,style: boldLarge.copyWith(color: MyColor.getIconColor()),)
          ],
        ),
      ),
    );
  }
}