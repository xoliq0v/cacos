import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:web_view_app/core/utils/dimensions.dart';
import 'package:web_view_app/core/utils/my_images.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
class SplashContent extends StatelessWidget {

  final String? icon;
  final String? appName;

  const SplashContent({
    super.key,
    this.icon,
    this.appName
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: icon!,
          width: Dimensions.appLogoSize,
          placeholder: (context, url) => Image.asset(MyImages.appLogoCircle,width: Dimensions.appLogoSize),
          errorWidget: (context, url, error) => Image.asset(MyImages.appLogoCircle,width: Dimensions.appLogoSize)
        ),
      ],
    );
  }
}