import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/core/utils/my_strings.dart';
import 'package:web_view_app/core/utils/style.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../data/controller/qr_code/qr_code_controller.dart';
class QrCodeDialogWidget extends StatefulWidget {
  const QrCodeDialogWidget({
    super.key,
  });

  @override
  State<QrCodeDialogWidget> createState() => _QrCodeDialogWidgetState();
}

class _QrCodeDialogWidgetState extends State<QrCodeDialogWidget> {
  Future<void> shareQrData(String qrData) async {

    final box = Get.context!.findRenderObject() as RenderBox?;

    await Share.share(
      qrData,
      subject: MyStrings.share.tr,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
  String copy = "Copy";

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return GetBuilder<QrCodeController>(
      builder: (controller) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: MyColor.getBackgroundColor(),
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          height: Dimensions.qrCodeAlertDialogHeight,
          width: size.width * .9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Text(MyStrings.qrCodeDetected, style: boldLarge.copyWith(color: MyColor.getPrimaryTextColor()))
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            controller.setQrCodeNull();
                            Get.back();
                          },
                          child: Icon(Icons.cancel, color: Colors.grey.withOpacity(.7), size: 25,)
                        )
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimensions.space14),
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
                    width: double.maxFinite,
                    height: size.height * .2,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.3),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(Get.find<QrCodeController>().qrCode ?? "",style: regularDefault.copyWith(fontSize: 14,color: MyColor.getPrimaryTextColor()),textAlign: TextAlign.center),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: controller.qrCode!));
                                  copy = "Copied";
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.copy),
                                    const SizedBox(width: 4),
                                    Text(copy.tr.toString())
                                  ],
                                )
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  shareQrData(controller.qrCode!);
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.ios_share),
                                    SizedBox(width: 4,),
                                    Text(MyStrings.share)
                                  ],
                                )
                            )
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}