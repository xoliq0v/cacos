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
import 'package:web_view_app/view/components/custom_loader/custom_loader.dart';
import 'package:web_view_app/view/screens/onboarding/widget/onboard_content.dart';

import '../../../data/services/api_service.dart';

class OnBoardingScreen4 extends StatefulWidget {
  const OnBoardingScreen4({super.key});

  @override
  State<OnBoardingScreen4> createState() => _OnBoardingScreen4State();
}

class _OnBoardingScreen4State extends State<OnBoardingScreen4> {


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

    Size size = MediaQuery.of(context).size;

    return GetBuilder<OnboardController>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyColor.getBackgroundColor(),
        body: controller.isLoading ? CustomLoader(loaderColor: MyColor.getPrimaryColor()) : Stack(
          children: [
            Column(
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
                  padding: const EdgeInsets.all(Dimensions.space20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(controller.onboardContentList.length, (index) => Container(
                          height: controller.currentIndex == index ? 12 : 10,
                          width: controller.currentIndex == index ? 12 : 10,
                          margin: const EdgeInsets.only(right: Dimensions.space5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: MyColor.getPrimaryColor(),width: 1.5),
                            color: controller.currentIndex == index ? MyColor.getPrimaryColor() : null,
                          ),
                        ),),
                      ),
                      GestureDetector(
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
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MyColor.getPrimaryColor(),
                          ),
                          child: controller.currentIndex == controller.onboardContentList.length -1? const Icon(Icons.check,color: MyColor.colorWhite,) : const Icon(Icons.arrow_forward_ios_rounded,color: MyColor.colorWhite),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 10,
              child: SafeArea(
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
            ),

            Positioned(
              left: 10,
              child: SafeArea(
                child: InkWell(
                  onTap: () {
                    controller.controller?.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 7),
                    margin: EdgeInsets.only(top: size.height * .02,left: size.width * .06),
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColor.getLightGrayColor(),
                    ),
                    child: const Icon(Icons.arrow_back_ios,size: 16,color: MyColor.colorBlackSolid,),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


