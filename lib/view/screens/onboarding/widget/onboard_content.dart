import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_view_app/view/components/custom_loader/custom_loader.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/controller/onboarding/onboard_controller.dart';
class OnboardContent extends StatelessWidget {

  final OnboardController controller;
  final int index;
  final String title;
  final String subTitle;
  final String? image;

  const OnboardContent({
    super.key,
    required this.controller,
    required this.index,
    required this.title,
    required this.subTitle,
    this.image
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: Dimensions.onBoardPadding,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * .03),

              CachedNetworkImage(
                imageUrl: image!,
                width: size.width*.65,
                placeholder: (context, url) => CustomLoader(loaderColor: MyColor.getPrimaryColor()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              SizedBox(height: size.height * .04),
              Text(
                  title.tr,
                  textAlign: TextAlign.center,
                  style: boldOverLarge.copyWith(fontSize: 25,color: MyColor.getPrimaryTextColor())
              ),
              SizedBox(height: size.height * .03),
              Text(
                  subTitle.tr,
                  textAlign: TextAlign.center,
                  style: regularDefaultInter.copyWith(fontSize: 16,color: MyColor.getPrimaryTextColor().withOpacity(.7))
              )
            ],
          ),
        ),
      ),
    );
  }
}