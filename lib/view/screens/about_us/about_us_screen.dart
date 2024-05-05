import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_view_app/core/utils/my_images.dart';
import 'package:web_view_app/core/utils/url_container.dart';
import 'package:web_view_app/data/controller/about/about_us_screen_controller.dart';
import 'package:web_view_app/data/services/api_service.dart';
import 'package:web_view_app/view/components/custom_loader/custom_loader.dart';
import 'package:web_view_app/view/screens/web_view/my_web_view.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/repo/about/about_repo.dart';
import '../../components/app-bar/custom_appbar_mab.dart';
class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  @override
  void initState() {
    Get.put(AboutRepo(apiClient: Get.find()));
    final controller = Get.put(AboutUsScreenController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });

  }

  @override
  Widget build(BuildContext context) {

    var gsData = Get.find<ApiClient>().getGSData().data?.generalSetting;


    return GetBuilder<AboutUsScreenController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.getBackgroundColor(),
          appBar: CustomAppBarWithMAB(
            elevation: .5,
            title: MyStrings.aboutUs,
            actionPress1: (){},
            actionPress2: (){},
            isShowBackBtn: true,
            leadingImage: MyImages.backButton,
            bgColor: MyColor.getPrimaryColor(),
        ),
        body:  controller.isLoading ? CustomLoader(loaderColor: MyColor.getPrimaryColor(),size: 20,) : Stack(
          children: [
            Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      CachedNetworkImage(
                        width: 150,
                        color: MyColor.getPrimaryTextColor(),
                        imageUrl: controller.repo.apiClient.getAppLogo(),
                        placeholder: (context, url) => Image.asset(MyImages.appLogoCircle,height: 100,width: 100,),
                        errorWidget: (context, url, error) => Image.asset(MyImages.appLogoCircle,height: 100,width: 100,),
                      ),
                      const SizedBox(height: Dimensions.space30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
                        child: Text( gsData?.aboutDescription.toString()??'',textAlign: TextAlign.justify,style: regularDefault.copyWith(color: MyColor.getPrimaryTextColor(),fontSize: 14)),
                      ),
                      // const Spacer(),

                      const SizedBox(height: Dimensions.space10),
                    ],
                  ),
                )
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: Dimensions.space10),
              Text(MyStrings.followUs,style: semiBoldLarge.copyWith(color: MyColor.getPrimaryTextColor(),fontSize: 16)),
              const SizedBox(height: Dimensions.space10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(controller.socialMediaList.length,(index) {
                    return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            String url = controller.socialMediaList[index].url.toString();
                            if(url.isNotEmpty){
                              launchUrl(Uri.parse(url),mode: LaunchMode.externalNonBrowserApplication);
                            }
                          },
                          child:  CachedNetworkImage(
                            imageUrl: "${UrlContainer.domainUrl}/assets/images/social_icon/${controller.socialMediaList[index].icon.toString()}",
                            width: 25,
                            placeholder: (context, url) => const CustomLoader(size: 20),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ));
                  }
                  )),
              const SizedBox(height: Dimensions.space10),
            ],
          )
        )
      ),
    );
  }
}
