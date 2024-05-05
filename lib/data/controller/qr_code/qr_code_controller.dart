import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeController extends GetxController{

  String? qrCode;

  Future<bool> submitQrData(String myQrCode) async {

    final urlPattern = RegExp(r'^(http(s)?://)?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(:[0-9]+)?(/?)(.*)$');

    if(urlPattern.hasMatch(myQrCode)){
      _launchUrl(myQrCode);
    }
    else{
      qrCode = myQrCode;
    }
    update();
    return false;
  }

  void setQrCodeNull(){
    qrCode = null;
    update();
  }



  Future<void> _launchUrl(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }


}