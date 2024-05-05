import 'package:flutter/material.dart';
import 'package:web_view_app/data/controller/onboarding/onboard_controller.dart';
import 'package:web_view_app/view/components/buttons/custom_rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:web_view_app/core/route/route.dart';
import 'package:web_view_app/core/utils/dimensions.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/core/utils/my_images.dart';
import 'package:web_view_app/core/utils/my_strings.dart';
import 'package:web_view_app/core/utils/style.dart';
import 'package:web_view_app/data/repo/auth/general_setting_repo.dart';
import 'package:web_view_app/data/repo/auth/signup_repo.dart';
import 'package:web_view_app/data/services/api_service.dart';
import 'package:web_view_app/view/components/app-bar/custom_appbar.dart';
import 'package:web_view_app/view/components/custom_loader/custom_loader.dart';
import 'package:web_view_app/view/components/custom_no_data_found_class.dart';
import 'package:web_view_app/view/components/will_pop_widget.dart';
import 'package:web_view_app/view/screens/auth/login/widget/login_text_field.dart';

import '../../../../data/controller/auth/login_controller.dart';
import '../../../../data/controller/common/theme_controller.dart';
import '../../../../data/repo/auth/login_repo.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/buttons/rounded_loading_button.dart';
import '../../../components/text-form-field/custom_text_field.dart';
import '../../../components/text/default_text.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {


    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LoginController>().remember = false;
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return GetBuilder<ThemeController>(
      builder: (controller) => GetBuilder<LoginController>(
        builder: (controller) => WillPopWidget(
          nextRoute: "",
          child: SafeArea(
            child: Scaffold(
              backgroundColor: MyColor.getLoginBgColor(),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimensions.space50,),
                    Text(MyStrings.letsGetYouIn.tr,style: semiBoldDefault.copyWith(color: MyColor.getPrimaryTextColor(),fontSize: 25)),
                    const SizedBox(height: Dimensions.space10),
                    Text(MyStrings.loginToYourAccount.tr,style: semiBoldDefault.copyWith(color: MyColor.getLightGrayColor() ,fontSize: 14)),
                    const SizedBox(height: Dimensions.space50),
                    LoginTextField(
                      controller: controller.emailController,
                      labelText: MyStrings.usernameOrEmail,
                      focusNode: controller.emailFocusNode,
                      nextFocus: controller.passwordFocusNode,
                      fillColor: MyColor.getTextFieldColor(),
                      onChanged: (value){},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return MyStrings.enterYourUsername.tr;
                        } else if(value.length<6){
                          return MyStrings.kShortUserNameError.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: Dimensions.space15),
                    LoginTextField(
                      controller: controller.passwordController,
                      labelText: MyStrings.password,
                      focusNode: controller.passwordFocusNode,
                      fillColor: MyColor.getTextFieldColor(),
                      onChanged: (value){},
                      validator:  (value) {
                        if (value!.isEmpty) {
                          return MyStrings.enterYourPassword_.tr;
                        } else if(value.length<6){
                          return MyStrings.kShortUserNameError.tr;
                        } else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: Dimensions.space20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Checkbox(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                                  activeColor: MyColor.primaryColor,
                                  checkColor: MyColor.colorWhite,
                                  value: controller.remember,
                                  side: MaterialStateBorderSide.resolveWith(
                                        (states) => BorderSide(
                                        width: 1.0,
                                        color: controller.remember ? MyColor.getTextFieldEnableBorder() : MyColor.getTextFieldDisableBorder()
                                    ),
                                  ),
                                  onChanged: (value){
                                    controller.changeRememberMe();
                                  }
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(MyStrings.rememberMe.tr,style: semiBoldDefault.copyWith(color: MyColor.getLightGrayColor(),fontSize: 13)),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            controller.clearTextField();
                            Get.toNamed(RouteHelper.forgotPasswordScreen);
                          },
                          child: Text(MyStrings.forgetPassword.tr,style: semiBoldDefault.copyWith(color: MyColor.getLightGrayColor(),fontSize: 13)),
                        )
                      ],
                    ),
                    const SizedBox(height: Dimensions.space50),
                    controller.isSubmitLoading ? const RoundedLoadingBtn() : CustomRoundedButton(
                      labelName: MyStrings.signIn.tr,
                      verticalPadding: Dimensions.space20,
                      buttonColor: MyColor.colorBlue,
                      press: (){
                        // if(formKey.currentState!.validate()){
                        //   controller.loginUser();
                        // }
                        Get.offAllNamed(RouteHelper.primaryScreen);
                      }
                    ),
                    const SizedBox(height: Dimensions.space12),
                    CustomRoundedButton(
                        labelName: MyStrings.loginWithGoogle.tr,
                        buttonColor: Get.find<ThemeController>().darkTheme ? MyColor.colorWhite : MyColor.textFieldColor.withOpacity(.4),
                        buttonTextColor: MyColor.colorBlack,
                        svgImage: MyImages.google,
                        press: (){
                          if(formKey.currentState!.validate()){
                            controller.loginUser();
                          }
                        }
                    ),
                    const SizedBox(height: Dimensions.space14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(MyStrings.doNotHaveAccount.tr, overflow:TextOverflow.ellipsis,style: semiBoldDefault.copyWith(color: MyColor.getPrimaryTextColor().withOpacity(.95),fontSize: 13,letterSpacing: 1)),
                        const SizedBox(width: Dimensions.space5),
                        TextButton(
                          onPressed: (){
                            Get.offAndToNamed(RouteHelper.registrationScreen);
                          },
                          child: Text(MyStrings.signUp.tr, maxLines: 2, overflow:TextOverflow.ellipsis,style: semiBoldDefault.copyWith(color: MyColor.colorBlue,fontSize: 13)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
