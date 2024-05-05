import '../../../core/utils/method.dart';
import '../../../core/utils/url_container.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class OnboardRepo{

  ApiClient apiClient;
  OnboardRepo({required this.apiClient});

  Future<ResponseModel> getOnboardContent() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.obsContentEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

}