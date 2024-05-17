import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_view_app/core/helper/shared_preference_helper.dart';
import 'package:web_view_app/core/route/route.dart';
import 'package:web_view_app/core/utils/messages.dart';
import 'package:web_view_app/core/utils/my_strings.dart';
import 'package:web_view_app/data/controller/common/theme_controller.dart';
import 'package:web_view_app/data/controller/localization/localization_controller.dart';
import 'package:web_view_app/push_notification_service.dart';
import 'core/di_service/di_services.dart' as di_service;
import 'core/theme/dark.dart';
import 'core/theme/light.dart';
import 'firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';


Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); //r option

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  sharedPreferences.setBool(SharedPreferenceHelper.hasNewNotificationKey, true);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  MobileAds.instance.initialize();

  Map<String, Map<String, String>> languages = await di_service.init();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  await PushNotificationService().setupInteractedMessage();

  HttpOverrides.global = MyHttpOverrides();
  await Permission.camera.request();
  await Permission.microphone.request();
  runApp(MyApp(languages: languages));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({Key? key, required this.languages}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return GetBuilder<ThemeController>(
      builder: (theme) => GetBuilder<LocalizationController>(
        builder: (localizeController) => GetMaterialApp(
          title: MyStrings.appName,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.noTransition,
          transitionDuration: const Duration(milliseconds: 200),
          theme: theme.darkTheme ? dark : light,
          initialRoute: RouteHelper.splashScreen,
          navigatorKey: Get.key,
          getPages: RouteHelper().routes,
          locale: localizeController.locale,
          translations: Messages(languages: widget.languages),
          fallbackLocale: Locale(localizeController.locale.languageCode, localizeController.locale.countryCode),
        ),
      ),
    );
  }
}
