import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/data/controller/primary/primary_screen_controller.dart';
import 'package:web_view_app/view/components/custom_loader/custom_loader.dart';
import 'package:web_view_app/view/components/dialog/exit_dialog.dart';
import 'package:web_view_app/view/screens/web_view/widget/error_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/my_strings.dart';

class MyWebViewWidget extends StatefulWidget {
  const MyWebViewWidget({Key? key, required this.url, required this.controllers}) : super(key: key);

  final String url;
  final PrimaryScreenController controllers;

  @override
  State<MyWebViewWidget> createState() => _MyWebViewWidgetState();
}

class _MyWebViewWidgetState extends State<MyWebViewWidget> {
  final ReceivePort _port = ReceivePort();

  late PullToRefreshController pullToRefreshController;

  String url = "";
  double progress = 0;

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  void initState() {
    final controller = Get.put(PrimaryScreenController(primaryRepo: Get.find()));
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if (status == DownloadTaskStatus.complete) {}
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);

    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
        pullToRefreshController.reactive();
      },
    );
  }

  @override
  void didUpdateWidget(covariant MyWebViewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.url != widget.url) {
      if (webViewController != null) {
        webViewController!.clearCache();
        webViewController!.loadUrl(urlRequest: URLRequest(url: Uri.parse(widget.url)));
        setState(() {
          enableErrorWidget = false;
        });
      }
    }
  }

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  bool isLoading = true;
  bool enableErrorWidget = false;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    if (Platform.isAndroid) {
      AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    return GetBuilder<PrimaryScreenController>(
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          if (await webViewController!.canGoBack()) {
            webViewController!.goBack();
            return Future.value(false);
          } else {



            if (controller.navBarWebView) {
              if (context.mounted) {
                showExitDialog(context);
              }
            } else {
              Get.back();
              controller.setNavBarWebViewStatus(true);
            }
          }
          return false;
        },
        child: Stack(
          children: [
            if (enableErrorWidget == false)
              InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                initialOptions: options,
                onLoadStart: (controller, url) {
                  setState(() {
                    isLoading = true;
                    this.url = url.toString();
                  });
                },
                androidOnPermissionRequest: (controller, origin, resources) async {
                  return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var uri = navigationAction.request.url;
                    print(uri.toString());
                  if (!uri.toString().contains('https://cacos.uz')) {
                    _launchURL(uri.toString());
                    return NavigationActionPolicy.CANCEL;
                  }
                  return NavigationActionPolicy.ALLOW;
                },
                onLoadStop: (controller, url) async {
                  pullToRefreshController.endRefreshing();
                  setState(() {
                    isLoading = false;
                  });
                },
                onLoadError: (controller, url, code, message) {
                  pullToRefreshController.endRefreshing();
                  setState(() {
                    enableErrorWidget = true;
                  });
                },
                onProgressChanged: (controller, progress) {
                  pullToRefreshController.endRefreshing();
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  setState(() {
                    this.url = url.toString();
                  });
                },
                androidOnGeolocationPermissionsShowPrompt: (controller, origin) async {
                  return GeolocationPermissionShowPromptResponse(origin: origin, allow: true, retain: true);
                },
                onConsoleMessage: (controller, consoleMessage) {},
                onDownloadStartRequest: (controller, url) async {
                  Directory? tempDir = await getExternalStorageDirectory();
                  setState(() {});
                  await FlutterDownloader.enqueue(
                    url: url.url.toString(),
                    fileName: url.suggestedFilename,
                    savedDir: tempDir!.path,
                    showNotification: true,
                    requiresStorageNotLow: false,
                    openFileFromNotification: true,
                    saveInPublicStorage: true,
                  );
                },
                implementation: WebViewImplementation.NATIVE,
              )
            else
              WebViewErrorWidget(webViewController: webViewController, url: widget.url),
            if (isLoading) Center(child: CustomLoader(loaderColor: MyColor.getPrimaryColor())),
          ],
        ),
      ),
    );
  }

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      javaScriptEnabled: true,
      cacheEnabled: true,
      useOnDownloadStart: true,
      useOnLoadResource: true,
      useShouldOverrideUrlLoading: true,
      clearCache: false,
      useShouldInterceptAjaxRequest: true,
      useShouldInterceptFetchRequest: true,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping(MyStrings.downloaderSenPort);
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName(MyStrings.downloaderSenPort);
    send?.send([id, status, progress]);
  }

  bool shouldOpenExternally(String url) {
    // Add logic to determine if the URL should be opened externally
    // For example, you could check if the URL contains certain keywords
    return url.contains("https://cacos.uz");
  }
}
