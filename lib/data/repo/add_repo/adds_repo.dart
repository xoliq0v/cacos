
import 'dart:convert';

import '../../../core/utils/method.dart';
import '../../../core/utils/my_strings.dart';
import '../../../core/utils/url_container.dart';
import '../../model/general_setting/general_setting_response_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class AddRepo{

  ApiClient apiClient;
  AddRepo({required this.apiClient});

  Future<ResponseModel> getAdds() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.adsEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getPopUpAdds() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.popUpAddsEndPoint}";
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