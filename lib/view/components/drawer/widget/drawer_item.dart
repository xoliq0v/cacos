import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:web_view_app/data/controller/primary/primary_screen_controller.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/style.dart';
import '../../custom_loader/custom_loader.dart';
class DrawerItem extends StatelessWidget {

  final PrimaryScreenController controller;
  final String? svgIconLeading;
  final String? leadingImage;
  final IconData? leadingIcon;
  final String title;
  final VoidCallback press;
  final Widget? trillingWidget;
  final double leadingIconWidth;

  const DrawerItem({
    super.key,
    required this.controller,
    required this.title,
    this.svgIconLeading,
    this.leadingImage,
    this.leadingIcon,
    required this.press,
    this.trillingWidget,
    this.leadingIconWidth = 17
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          minLeadingWidth: 20,
          leading: svgIconLeading != null ?
            SvgPicture.asset(svgIconLeading!,width: leadingIconWidth,colorFilter: ColorFilter.mode(MyColor.getIconColor(), BlendMode.srcIn)) :
            leadingImage != null? CachedNetworkImage(
                  imageUrl: leadingImage!,
                  width: Dimensions.space20,
                  color: MyColor.getPrimaryTextColor(),
                  placeholder: (context, url) => CustomLoader(loaderColor: MyColor.getPrimaryColor(),size: 20),
                  errorWidget: (context, url, error) => Icon(Icons.error,color: MyColor.getPrimaryTextColor()),
            )
            : leadingIcon != null ? Icon(leadingIcon,weight: 14,color: MyColor.getIconColor(),):const SizedBox.shrink(),
          title: Text(title.tr,style: semiBoldLargeInter.copyWith(fontWeight: FontWeight.w500,color: MyColor.getPrimaryTextColor().withOpacity(.9))),
          trailing: trillingWidget ?? const SizedBox.shrink()
        ),
        // const SizedBox(height: Dimensions.space20)
      ],
    );
  }
}