
import 'dart:convert';

import '../../../core/utils/method.dart';
import '../../../core/utils/my_strings.dart';
import '../../../core/utils/url_container.dart';
import '../../model/general_setting/general_setting_response_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class PrimaryRepo{

  ApiClient apiClient;
  PrimaryRepo({required this.apiClient});

  Future<ResponseModel> getNavBarItem() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.navBarEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getDrawingItem() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.drawerEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getFloatingButtonItem() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.floatingEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getOnboardContentData() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.obsContentEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getAddsData() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.adsEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }



  Future<dynamic> refreshGeneralSetting() async {

    String url = '${UrlContainer.baseUrl}${UrlContainer.generalSettingEndPoint}';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: false);

    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        apiClient.storeGeneralSetting(model);
      }
    }
  }

}