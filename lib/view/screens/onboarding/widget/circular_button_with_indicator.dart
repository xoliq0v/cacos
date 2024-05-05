import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../data/controller/onboarding/onboard_controller.dart';
import 'indicator.dart';
class CircularButtonWithIndicator extends StatelessWidget {

  final OnboardController controller;

  const CircularButtonWithIndicator({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * .06),
      child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedIndicator(
              duration: const Duration(seconds: 10),
              size: Dimensions.indicatorSize,
              callback: (){},
              indicatorValue: 100/controller.onboardContentList.length * (controller.currentIndex.toDouble() + 1),
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.bottomCenter,
                height: Dimensions.space60,
                width: Dimensions.space60,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(99), color: MyColor.getPrimaryColor()),
                child: Center(
                  child: Icon(controller.currentIndex == controller.onboardContentList.length - 1 ? Icons.check : Icons.arrow_forward_ios_rounded,color: MyColor.colorWhite,),
                ),
              ),
              onTap: (){
                if (controller.currentIndex < controller.onboardContentList.length - 1) {
                  controller.controller?.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
                else{
                  Get.offAndToNamed(RouteHelper.primaryScreen);
                }
              },
            )
          ]),
    );
  }
}