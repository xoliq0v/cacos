import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/data/controller/primary/primary_screen_controller.dart';
import '../../../../core/utils/url_container.dart';
import '../../../../data/controller/adds/adds_controller.dart';
import '../../web_view/my_web_view.dart';
import 'expanded_fav_widget.dart';
class ExpandableFab extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onPressed;
  final PrimaryScreenController controller;
  const ExpandableFab({
    super.key,
    required this.isExpanded,
    required this.onPressed,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isExpanded)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(controller.floatingButtonList.length, (index) => GestureDetector(
              onTap: () {
                Get.find<AddsController>().setAddLoaded(true);
                controller.setNavBarWebViewStatus(false);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyWebViewScreen(redirectUrl: controller.floatingButtonList[index].url.toString())));
              },
              child: ExpandedFavWidget(
                title: controller.floatingButtonList[index].title.toString(),
                imageIcon: "${UrlContainer.domainUrl}/assets/images/floating_button/${controller.floatingButtonList[index].icon}",
                ),
            )
            )
          ),
        FloatingActionButton(
          backgroundColor: MyColor.getPrimaryColor(),
          onPressed: onPressed,
          heroTag: null,
          child: controller.isExpanded? Icon(Icons.close,color: MyColor.getAppbarTextColor()): Icon(Icons.menu,color: MyColor.getAppbarTextColor()),
        ),
      ],
    );
  }
}

