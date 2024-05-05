import 'package:flutter/material.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/controller/common/theme_controller.dart';
import '../../../../data/controller/primary/primary_screen_controller.dart';
import 'drawer_item.dart';
class DrawerSettingsSection extends StatelessWidget {
  const DrawerSettingsSection({
    super.key,
    required this.controller,
    required this.themeController,
  });

  final PrimaryScreenController controller;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Dimensions.drawerMenuPadding,
          child: Text(MyStrings.settings,style: semiBoldDefault.copyWith(fontSize: 13,color: MyColor.getLightGrayColor())),
        ),
        DrawerItem(
            controller: controller,
            leadingIcon: Icons.dark_mode_outlined,
            trillingWidget: Switch(
              value: themeController.darkTheme,
              onChanged: (value) => themeController.toggleTheme(),
              inactiveTrackColor: MyColor.getIconColor(),
            ),
            title: MyStrings.darkLight,
            press: (){}
        ),
      ],
    );
  }
}