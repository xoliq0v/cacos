import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:web_view_app/core/utils/my_strings.dart';
import 'package:web_view_app/view/screens/qr_code/widget/qr_code_dialog_widget.dart';

import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';
import '../../../data/controller/qr_code/qr_code_controller.dart';
import '../../components/app-bar/custom_appbar_mab.dart';

class QrCodeScannerScreen extends StatefulWidget {
  const QrCodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScannerScreen> createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? qrController;

  @override
  void initState() {

    Get.put(QrCodeController());

    super.initState();
  }

  void _onQRViewCreated(QRViewController qrController) {
    setState(() {
      this.qrController = qrController;
    });
    qrController.scannedDataStream.listen((scanData) {

        result = scanData;
        String? myQrCode = result?.code!=null && result!.code.toString().isNotEmpty ?result?.code.toString():'';
        if(myQrCode!=null && myQrCode.isNotEmpty){
          manageQRData(myQrCode);
        }

    });
  }

  void manageQRData(String myQrCode)async{
    final controller =  Get.find<QrCodeController>();

   qrController?.stopCamera();
   await controller.submitQrData(myQrCode);
  }


  _onQrScanAction(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          var size = MediaQuery.of(context).size;
          return const QrCodeDialogWidget();
        },
      );
    });
    return const SizedBox();
  }

  @override
  void reassemble() {
    if (Platform.isAndroid) {
      qrController!.pauseCamera();
    } else if (Platform.isIOS) {
      qrController!.resumeCamera();
    }
    super.reassemble();
  }

  @override
  void dispose() {
    qrController?.dispose();
    qrController?.stopCamera();
    super.dispose();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(MyStrings.noPermission)),
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    if (qrController != null && mounted) {
      qrController!.pauseCamera();
      qrController!.resumeCamera();
    }

    return GetBuilder<QrCodeController>(
      builder: (viewController) => SafeArea(
        child: Scaffold(
          appBar:  CustomAppBarWithMAB(
            elevation: .5,
            title: MyStrings.qrCodeScan,
            actionPress1: (){},
            actionPress2: (){},
            isShowBackBtn: true,
            leadingImage: MyImages.backButton,
            bgColor: MyColor.getPrimaryColor(),
          ),
          body: Column(
            children: [
              Expanded(
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  cameraFacing: CameraFacing.back,
                  overlay: QrScannerOverlayShape(
                      borderColor: MyColor.getPrimaryColor(),
                      borderRadius: 5,
                      borderLength: 30,
                      borderWidth: 10,
                      cutOutSize: (MediaQuery.of(context).size.width < 400 ||
                          MediaQuery.of(context).size.height < 400)
                          ? 250.0
                          : 300.0
                  ),
                  onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
                )
              ),
              viewController.qrCode != null?
                  _onQrScanAction(context) : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}


