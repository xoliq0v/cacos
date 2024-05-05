import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_view_app/core/route/route.dart';
import 'package:web_view_app/core/utils/dimensions.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/core/utils/my_strings.dart';
import 'package:web_view_app/core/utils/style.dart';
import 'package:web_view_app/core/utils/url_container.dart';
import 'package:web_view_app/data/controller/onboarding/onboard_controller.dart';
import 'package:web_view_app/data/repo/onboard_repo/onboard_repo.dart';
import 'package:web_view_app/view/components/buttons/custom_rounded_button.dart';
import 'package:web_view_app/view/components/custom_loader/custom_loader.dart';
import 'package:web_view_app/view/screens/onboarding/widget/onboard_content.dart';

import '../../../data/services/api_service.dart';

class OnBoardingScreen1 extends StatefulWidget {
  const OnBoardingScreen1({super.key});

  @override
  State<OnBoardingScreen1> createState() => _OnBoardingScreen1State();
}

class _OnBoardingScreen1State extends State<OnBoardingScreen1> {


  @override
  void initState() {
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

    return GetBuilder<OnboardController>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyColor.getBackgroundColor(),
        body: controller.isLoading ? CustomLoader(loaderColor: MyColor.getPrimaryColor()) : Column(
          children: [
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
            Padding(
              padding: const EdgeInsets.all(Dimensions.space50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: () {
                      Get.offAndToNamed(RouteHelper.primaryScreen);
                  }, child:controller.onboardContentList.length - 1  == controller.currentIndex? const SizedBox.shrink() : Text(MyStrings.skip.tr,style: semiBoldLarge.copyWith(color: MyColor.getLightGrayColor()),)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(controller.onboardContentList.length, (index) => Container(
                        height: controller.currentIndex == index ? 12 : 10,
                        width: controller.currentIndex == index ? 12 : 10,
                        margin: const EdgeInsets.only(right: Dimensions.space5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: MyColor.primaryColor,width: 1.5),
                          color: controller.currentIndex == index ? MyColor.primaryColor : null,
                        ),
                      ),
                    ),
                  ),
                  CustomRoundedButton(
                    labelName:controller.onboardContentList.length - 1 == controller.currentIndex ? MyStrings.finish : MyStrings.next.tr,
                    buttonColor: MyColor.getPrimaryColor(),
                    press: (){
                      if (controller.currentIndex < controller.onboardContentList.length - 1) {
                        controller.controller?.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                      else{
                        Get.offAndToNamed(RouteHelper.primaryScreen);
                      }
                    }
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


