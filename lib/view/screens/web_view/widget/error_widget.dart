import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:web_view_app/core/route/route.dart';
import 'package:web_view_app/core/utils/dimensions.dart';
import 'package:web_view_app/data/controller/primary/primary_screen_controller.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../components/buttons/custom_rounded_button.dart';
import '../../../components/dialog/exit_dialog.dart';
import '../my_web_view.dart';
import '../my_web_view_widget.dart';
class WebViewErrorWidget extends StatefulWidget {

  InAppWebViewController? webViewController;
  String url;

  WebViewErrorWidget({
    super.key,
    this.webViewController,
    this.url = ""
  });

  @override
  State<WebViewErrorWidget> createState() => _WebViewErrorWidgetState();
}

class _WebViewErrorWidgetState extends State<WebViewErrorWidget> {

  PrimaryScreenController primaryScreenController = Get.find<PrimaryScreenController>();

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void initState() {
    initConnectivity();

    Connectivity().onConnectivityChanged.listen((result) {
      _updateConnectionStatus(result);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<PrimaryScreenController>(
      builder: (controller) =>  Container(
        color: MyColor.getBackgroundColor(),
        width: double.maxFinite,
        height: double.maxFinite,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(MyImages.errorImage,scale: 1.3,),
                SizedBox(height: size.height*.05),
                Text(MyStrings.opps.tr,style: boldOverLarge.copyWith(color: MyColor.getPrimaryTextColor())),
                SizedBox(height: size.height*.02),
                Text( _connectionStatus == ConnectivityResult.none? MyStrings.noInternet : MyStrings.errorMessage.tr,textAlign: TextAlign.center, style: mediumDefault.copyWith(color: MyColor.getPrimaryTextColor(),fontSize: 14,height: 1.5)),
                SizedBox(height: size.height*.02),
                SizedBox(
                    width:Dimensions.space150,
                    child: _connectionStatus == ConnectivityResult.none?Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomRoundedButton(
                            labelName: MyStrings.refresh.tr,
                            buttonColor: MyColor.getPrimaryColor(),
                            press: () async {
                              await widget.webViewController?.loadUrl(urlRequest: URLRequest(url: Uri.parse(widget.url)));
                            }
                        ),
                        const SizedBox(height: Dimensions.space10,),
                        CustomRoundedButton(
                            labelName: MyStrings.exit.tr,
                            buttonColor: MyColor.getPrimaryColor(),
                            press: () async {
                              showExitDialog(context);
                            }
                        ),
                      ],
                    ): CustomRoundedButton(
                        labelName: MyStrings.goBack.tr,
                        buttonColor: MyColor.getPrimaryColor(),
                        press: ()async{
                          if(controller.navBarWebView == false){ //means its not in nav bar screen
                            Get.back();
                            controller.setNavBarWebViewStatus(true);
                          }
                          else{
                            if(primaryScreenController.selectedIndex == 0){
                              primaryScreenController.setSelectedIndex(1);
                            }else{
                              primaryScreenController.setSelectedIndex(0);
                            }
                          }
                        }
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}