import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_view_app/core/utils/method.dart';
import 'package:web_view_app/core/utils/my_strings.dart';
import 'package:web_view_app/core/utils/url_container.dart';
import 'package:web_view_app/data/model/global/response_model/response_model.dart';
import 'package:web_view_app/data/services/api_service.dart';


class AboutRepo {
  ApiClient apiClient;
  AboutRepo({required this.apiClient});

  Future<dynamic> getSocialMediaData() async {
    String url='${UrlContainer.baseUrl}${UrlContainer.socialMediaEndPoint}';
    ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: false); //store here -- true, 'Success', 200, response.body
    return response; // return -- true, 'Success', 200, response.body
  }
}
