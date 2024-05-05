import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:web_view_app/view/components/bottom-nav-bar/bottom_nav_bar.dart';

import 'package:web_view_app/view/screens/about_us/about_us_screen.dart';

import 'package:web_view_app/view/screens/auth/login/login_screen.dart';
import 'package:web_view_app/view/screens/onboarding/onboard_screen4.dart';
import 'package:web_view_app/view/screens/onboarding/onboarding_screen2.dart';
import 'package:web_view_app/view/screens/primary_screen/primary_screen.dart';
import 'package:web_view_app/view/screens/qr_code/qr_code_scanner_screen.dart';
import 'package:web_view_app/view/screens/web_view/my_web_view.dart';

import '../../view/screens/onboarding/on_board_screen3.dart';
import '../../view/screens/onboarding/onboard_screen1.dart';
import '../../view/screens/splash/splash_screen.dart';

class RouteHelper{

static const String splashScreen                = "/splash_screen";
static const String homeScreen                  = "/home_screen";
static const String primaryScreen               = "/google_nav_bar";
static const String onboardScreen1              = "/onboard_screen1";
static const String onboardScreen2              = "/onboard_screen2";
static const String onboardScreen3              = "/onboard_screen3";
static const String onboardScreen4              = "/onboard_screen4";
static const String aboutUs                     = "/about_us";
static const String qrCodeScannerScreen         = "/qr_code_scanner_screen";

static const String loginScreen                 = "/login_screen";
static const String forgotPasswordScreen        = "/forgot_password_screen";
static const String changePasswordScreen        = "/change_password_screen";
static const String registrationScreen          = "/registration_screen";
static const String bottomNavBar                = "/bottom_nav_bar";
static const String myWalletScreen              = "/my_wallet_screen";
static const String addMoneyHistoryScreen       = "/add_money_history_screen";
static const String profileCompleteScreen       = "/profile_complete_screen";
static const String emailVerificationScreen     = "/verify_email_screen" ;
static const String smsVerificationScreen       = "/verify_sms_screen";
static const String verifyPassCodeScreen        = "/verify_pass_code_screen" ;
static const String twoFactorScreen             = "/two-factor-screen";
static const String resetPasswordScreen         = "/reset_pass_screen" ;
static const String transactionHistoryScreen    = "/transaction_history_screen";
static const String notificationScreen          = "/notification_screen";
static const String profileScreen               = "/profile_screen";
static const String editProfileScreen           = "/edit_profile_screen";
static const String kycScreen                   = "/kyc_screen";
static const String privacyScreen               = "/privacy-screen";

static const String withdrawScreen              = "/withdraw-screen";
static const String addWithdrawMethodScreen     = "/withdraw-method";
static const String withdrawConfirmScreenScreen = "/withdraw-preview-screen";


static const String depositsScreen              = "/deposits";
static const String depositsDetailsScreen       = "/deposits_details";
static const String newDepositScreenScreen      = "/deposits_money";
static const String depositWebViewScreen        = '/deposit_webView';


  List<GetPage> routes = [

    GetPage(name: splashScreen        ,         page: () => const SplashScreen()),
    GetPage(name: loginScreen         ,         page: () => const LoginScreen()),
    GetPage(name: onboardScreen1  ,             page: () => const OnBoardingScreen1()),
    GetPage(name: onboardScreen2  ,              page: () => const OnBoardingScreen2()),
    GetPage(name: onboardScreen3  ,             page: () => const OnBoardingScreen3()),
    GetPage(name: onboardScreen4  ,             page: () => const OnBoardingScreen4()),
    GetPage(name: primaryScreen  ,              page: () => const PrimaryScreen()),
    GetPage(name: aboutUs  ,                    page: () => const AboutUsScreen()),
    GetPage(name: qrCodeScannerScreen  ,        page: () => const QrCodeScannerScreen()),

   GetPage(name: bottomNavBar,                 page: () => const BottomNavBar()),



    // GetPage(name: withdrawScreen,               page: () => const WithdrawScreen()),
    // GetPage(name: addWithdrawMethodScreen,      page: () => const AddWithdrawMethod()),
    // GetPage(name: withdrawConfirmScreenScreen,  page: () => const WithdrawConfirmScreen()),
    // GetPage(name: privacyScreen,                page: () => const PrivacyPolicyScreen()),
    // GetPage(name: editProfileScreen,            page: () => const EditProfileScreen()),
    // GetPage(name: transactionHistoryScreen,     page: () => const TransactionsScreen()),
    // GetPage(name: depositWebViewScreen,         page: () => MyWebViewScreen(redirectUrl: Get.arguments)),
    // GetPage(name: depositsScreen,               page: () => const DepositsScreen()),
    // GetPage(name: newDepositScreenScreen,       page: () => const NewDepositScreen()),
    // GetPage(name: changePasswordScreen,         page: () => const ChangePasswordScreen()),
  ];
}