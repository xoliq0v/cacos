import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/view/components/indicator/indicator.dart';

import '../../../data/model/general_setting/general_setting_response_model.dart';
import '../../../data/repo/auth/general_setting_repo.dart';
import '../../../data/services/api_service.dart';

class CustomLoader extends StatefulWidget {

  final bool isFullScreen;
  final bool isPagination;
  final double strokeWidth;
  final Color loaderColor;
  final double size;

  const CustomLoader({
    Key? key,
    this.isFullScreen = false,
    this.isPagination = false,
    this.strokeWidth = 1,
    this.loaderColor = Colors.white,
    this.size = 35
  }) : super(key: key);

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {

  GeneralSettingResponseModel? gsModel;

  @override
  void initState() {
    final apiClient = Get.put(ApiClient(sharedPreferences: Get.find()));
    gsModel = apiClient.getGSData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   var activeLoader = gsModel?.data?.generalSetting?.activeLoader;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(activeLoader == "rotatingplain")
          SpinKitRotatingPlain(
            color: widget.loaderColor,
            size: widget.size,
          )
        else if(activeLoader == "doublebounce")
          SpinKitDoubleBounce(
            color: widget.loaderColor,
            size: widget.size,
          )
        else if(activeLoader == "wave")
            SpinKitWave(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "wanderingcubes")
            SpinKitWanderingCubes(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "fadingfour")
            SpinKitFadingFour(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "fadingcube")
            SpinKitFadingCube(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "pulse")
            SpinKitPulse(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "chasingdots")
            SpinKitChasingDots(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "circle")
            SpinKitCircle(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "cubegrid")
            SpinKitCubeGrid(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "fadingcircle")
            SpinKitFadingCircle(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "rotatingcircle")
            SpinKitRotatingCircle(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "foldingcube")
            SpinKitFoldingCube(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "pumpingheart")
            SpinKitPumpingHeart(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "pouringhourglassrefined")
            SpinKitPouringHourGlassRefined(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "fadinggrid")
            SpinKitFadingGrid(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "ring")
            SpinKitRing(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "ripple")
            SpinKitRipple(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "spinningcircle")
            SpinKitSpinningCircle(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "spinninglines")
            SpinKitSpinningLines(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "squarecircle")
            SpinKitSquareCircle(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "dualring")
            SpinKitDualRing(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "pianowave")
            SpinKitPianoWave(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "dancingsquare")
            SpinKitDancingSquare(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "threeinout")
            SpinKitThreeInOut(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "wavespinner")
            SpinKitWaveSpinner(
              color: widget.loaderColor,
              size: widget.size,
            )
        else if(activeLoader == "pulsinggrid")
            SpinKitPulsingGrid(
              color: widget.loaderColor,
              size: widget.size,
            )
        else
          SpinKitThreeBounce(
            color: widget.loaderColor,
            size: widget.size,
          )
      ],
    );
    }
}
