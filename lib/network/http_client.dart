import 'dart:developer';

import 'api_data.dart';
import 'package:http/http.dart' as http;

class HttpClientService{

  Future<dynamic> get(
      String apiUrl,
      ) async {
    String url = ApiData.baseUrl + apiUrl;

    log("Url >>>> $url");
    try {
      final response = await http.get(Uri.parse(url));
      return response.body;
    } catch (e) {
      throw Exception('error');
    }
  }

}