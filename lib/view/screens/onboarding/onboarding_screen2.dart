import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_view_app/core/route/route.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/core/utils/my_strings.dart';
import 'package:web_view_app/data/controller/onboarding/onboard_controller.dart';
import 'package:web_view_app/view/components/buttons/rounded_button.dart';
import 'package:web_view_app/view/components/custom_loader/custom_loader.dart';
import 'package:web_view_app/view/screens/onboarding/widget/onboard_content.dart';

import '../../../core/utils/url_container.dart';
import '../../../data/repo/onboard_repo/onboard_repo.dart';
import '../../../data/services/api_service.dart';

class OnBoardingScreen2 extends StatefulWidget {
  const OnBoardingScreen2({super.key});

  @override
  State<OnBoardingScreen2> createState() => _OnBoardingScreen2State();
}

class _OnBoardingScreen2State extends State<OnBoardingScreen2> {


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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(controller.onboardContentList.length,
                    (index) => Container(
                  height: 10,
                  width: controller.currentIndex == index ? 25 : 10,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyColor.getPrimaryColor(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: RoundedButton(
                  text: controller.currentIndex == controller.onboardContentList.length - 1? MyStrings.next : MyStrings.continue_,
                  color: MyColor.getPrimaryColor(),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}


