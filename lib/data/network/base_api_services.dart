abstract class BaseApiServices {
  Future<dynamic> getApiResponse(String endpoint);
  Future<dynamic> postApiResponse(url, dynamic data);
}
