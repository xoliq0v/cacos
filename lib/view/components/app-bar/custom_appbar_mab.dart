import 'package:flutter/material.dart';
import 'package:web_view_app/data/controller/about/about_us_screen_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:web_view_app/core/route/route.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/core/utils/style.dart';
import 'package:web_view_app/data/controller/primary/primary_screen_controller.dart';
import 'package:web_view_app/data/services/api_service.dart';
import 'package:web_view_app/view/components/app-bar/action_button_icon_widget.dart';
import 'package:web_view_app/view/components/dialog/exit_dialog.dart';

import '../../../core/utils/dimensions.dart';


class CustomAppBarWithMAB extends StatefulWidget implements PreferredSizeWidget{

  final PrimaryScreenController? controller;

  final String title;
  final bool isShowBackBtn;
  final Color bgColor;
  final bool isShowActionBtn;
  final bool isTitleCenter;
  final bool fromAuth;
  final bool isProfileCompleted;
  final VoidCallback? actionPress1;
  final VoidCallback? actionPress2;
  final bool isActionIconAlignEnd;
  final String actionText;
  final bool isActionImage;
  final String? leadingImage;
  final String? actionImage1;
  final String? actionImage2;
  final dynamic actionIcon1;
  final dynamic actionIcon2;
  final bool leadingDrawer;
  final double elevation;

  const CustomAppBarWithMAB({Key? key,
    this.isProfileCompleted=false,
    this.fromAuth = false,
    this.isTitleCenter = false,
    this.bgColor = MyColor.primaryColor,
    this.isShowBackBtn=false,
    required this.title,
    this.isShowActionBtn=false,
    this.actionText = '',
    this.actionPress1,
    this.actionPress2,
    this.isActionIconAlignEnd = false,
    this.isActionImage = true,
    this.leadingImage,
    this.actionImage1,
    this.actionImage2,
    this.actionIcon1,
    this.actionIcon2,
    this.controller,
    this.leadingDrawer = false,
    this.elevation = 0,

  }) : super(key: key);

  @override
  State<CustomAppBarWithMAB> createState() => _CustomAppBarWithMABState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}

class _CustomAppBarWithMABState extends State<CustomAppBarWithMAB> {
  bool hasNotification =false;
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isShowBackBtn?AppBar(
      elevation: widget.elevation,
      titleSpacing: 0,
      leading:widget.isShowBackBtn?IconButton(onPressed: (){
        if(widget.leadingDrawer){
          if(Get.find<ApiClient>().getGSData().data?.generalSetting?.dwStatus.toString() == "1"){
            Scaffold.of(context).openDrawer();
          }
        }
        else{
          String previousRoute=Get.previousRoute;
          if(previousRoute=='/splash-screen'){
            Get.offAndToNamed(RouteHelper.bottomNavBar);
          }else{
            Get.back();
          }
        }
      },icon: widget.leadingImage != null? SvgPicture.asset(widget.leadingImage!,colorFilter: ColorFilter.mode(MyColor.getAppbarTextColor(), BlendMode.srcIn),): Icon(Icons.menu,color: MyColor.getAppbarTextColor(), size: 20)):const SizedBox.shrink(),
      backgroundColor: widget.bgColor,
      title: Text(widget.title.tr,style: titleText.copyWith(color: MyColor.getAppbarTextColor(),fontWeight: FontWeight.bold,fontSize: Dimensions.fontMediumLarge)),
      centerTitle: widget.isTitleCenter,
      actions: [
        widget.isShowActionBtn ?
        ActionButtonIconWidget(
          pressed: widget.actionPress1!,
          isImage: widget.isActionImage,
          icon: widget.actionIcon1??Icons.search,  //just for demo purpose we put it here
          imageSrc: widget.actionImage1 ?? "",
          spacing: Dimensions.space12,
          size: Dimensions.space22,
        ) : const SizedBox.shrink(),
        widget.isShowActionBtn ?
        ActionButtonIconWidget(
            pressed: widget.actionPress2!,
            isImage: widget.isActionImage,
            icon: widget.actionIcon2??Icons.favorite,  //just for demo purpose we put it here
            imageSrc: widget.actionImage2 ?? "",
            spacing: Dimensions.space12,
            size: Dimensions.space22
        ):const SizedBox.shrink(),
        const SizedBox(
          width: 5,
        )
      ],
    ):AppBar(
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: widget.bgColor,
      centerTitle: true,
      title:Text(widget.title.tr,style:  titleText.copyWith(color: MyColor.getPrimaryTextColor())),
      actions: [
        widget.isShowActionBtn?InkWell(onTap: (){Get.toNamed(RouteHelper.notificationScreen)?.then((value){
          setState(() {
            hasNotification=false;
          });
        });},child:const SizedBox.shrink()):const SizedBox()
      ],
      automaticallyImplyLeading: false,
    );
  }
}
