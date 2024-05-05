import 'dart:convert';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_view_app/data/model/social/social_media_response_model.dart';
import 'package:web_view_app/data/model/social/social_media_response_model.dart';
import 'package:web_view_app/data/repo/about/about_repo.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class AboutUsScreenController extends GetxController{

  AboutRepo repo;

  AboutUsScreenController({required this.repo});

  List<SocialsMedia> socialMediaList = [];

  void loadData(){
    if(repo.apiClient.getInitAboutUsScreenStatus()){
      socialMediaList = repo.apiClient.getSocialMediaData();
      isLoading = false;
      update();
    }
    getSocialMediaList();
    isLoading = false;
    update();

  }

 bool isLoading = true;

  void urlLauncher(String url){
    _launchUrl(url);
  }

  Future<void> _launchUrl(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }


  Future<void> getSocialMediaList()async{
    ResponseModel model = await repo.getSocialMediaData();
    if(model.statusCode == 200){
      SocialMediaResponseModel socialMediaResponseModel = SocialMediaResponseModel.fromJson(jsonDecode(model.responseJson));
      if(socialMediaResponseModel.data?.socialsMedia != null && socialMediaResponseModel.data!.socialsMedia!.isNotEmpty){
        socialMediaList.clear();
        socialMediaList.addAll(socialMediaResponseModel.data!.socialsMedia!);
        if(socialMediaList.isNotEmpty){
          repo.apiClient.setSocialMediaData(socialMediaList);
        }
        isLoading = false;
        update();
        repo.apiClient.setInitAboutUsScreenStatus(true);
      }
    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }



  int checkValue = 0;
  void setCheckValue(int value){
    checkValue = value;
    update();
  }

}