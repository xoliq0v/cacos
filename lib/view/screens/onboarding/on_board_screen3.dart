import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:web_view_app/core/route/route.dart';
import 'package:web_view_app/core/utils/dimensions.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/core/utils/my_images.dart';
import 'package:web_view_app/core/utils/my_strings.dart';
import 'package:web_view_app/core/utils/style.dart';
import 'package:web_view_app/data/controller/common/theme_controller.dart';
import 'package:web_view_app/data/controller/onboarding/onboard_controller.dart';
import 'package:web_view_app/view/components/buttons/rounded_button.dart';
import 'package:web_view_app/view/components/custom_loader/custom_loader.dart';
import 'package:web_view_app/view/screens/onboarding/widget/circular_button_with_indicator.dart';
import 'package:web_view_app/view/screens/onboarding/widget/indicator.dart';
import 'package:web_view_app/view/screens/onboarding/widget/onboard_content.dart';

import '../../../core/utils/url_container.dart';
import '../../../data/repo/onboard_repo/onboard_repo.dart';
import '../../../data/services/api_service.dart';

class OnBoardingScreen3 extends StatefulWidget {
  const OnBoardingScreen3({super.key});

  @override
  State<OnBoardingScreen3> createState() => _OnBoardingScreen3State();
}

class _OnBoardingScreen3State extends State<OnBoardingScreen3> {


  @override
  void initState() {
    // final controller = Get.put(OnboardController());
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(OnboardRepo(apiClient: Get.find()));
    final controller = Get.put(OnboardController(onboardRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getAllData();
    });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return GetBuilder<OnboardController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: MyColor.getBackgroundColor(),
          body: controller.isLoading ? CustomLoader(loaderColor: MyColor.getPrimaryColor()) : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              controller.currentIndex == controller.onboardContentList.length - 1 ? const SizedBox.shrink() :
              SafeArea(
                child: Container(
                  margin: EdgeInsets.only(top: size.height * .02,right: size.width * .06),
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Get.offAndToNamed(RouteHelper.primaryScreen);
                    },
                    child: Text(MyStrings.skip.tr,style: semiBoldLarge.copyWith(color: MyColor.getLightGrayColor())),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller.controller,
                  itemCount: controller.onboardContentList.length,
                  onPageChanged: (int index) {
                    setState(() {
                      controller.currentIndex = index;
                    });
                  },
                  itemBuilder: (_, index) {
                    return OnboardContent(
                      controller: controller,
                      title: controller.onboardContentList[index].heading.toString(),
                      subTitle: controller.onboardContentList[index].description.toString(),
                      index: index,
                      image: "${UrlContainer.imagePath}on_board_screen/${controller.onboardContentList[index].image}",
                    );
                  },
                ),
              ),
              const SizedBox(height: Dimensions.space10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(controller.onboardContentList.length, (index) => Container(
                    height: 10,
                    width: controller.currentIndex == index ? Dimensions.space20 : Dimensions.space10,
                    margin: const EdgeInsets.only(right: Dimensions.space5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: controller.currentIndex == index ? MyColor.getPrimaryColor() : MyColor.getLightGrayColor(),
                    ),
                  ),
                ),
              ),
              CircularButtonWithIndicator(controller: controller)
            ],
          ),
        ),
      ),
    );
  }
}




