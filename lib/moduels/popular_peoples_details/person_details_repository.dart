import '../../network/api_data.dart';
import '../../network/http_client.dart';

class PopularPeopleDetailsRepository{
  HttpClientService httpClientService = HttpClientService();


  Future<dynamic> getImages(int personId) {
    String url = "${ApiData.personPath}$personId${ApiData.imagesPath}?api_key=${ApiData.apiKey}";
    var response = httpClientService.get(url);
    return response;
  }
}