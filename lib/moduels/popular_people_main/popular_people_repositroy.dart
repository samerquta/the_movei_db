import 'package:the_movie_db_task/network/api_data.dart';
import 'package:the_movie_db_task/network/http_client.dart';

class PopularPeopleRepository {
  HttpClientService httpClientService = HttpClientService();

  Future<dynamic> getPopularPeopleList(int page) {
    String url =
        "${ApiData.personPath}${ApiData.popularPath}?api_key=${ApiData.apiKey}&page=$page";
    var response = httpClientService.get(url);
    return response;
  }
}
