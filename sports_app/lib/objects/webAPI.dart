import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'league.dart';


class WebAPI
{
  /**
  static getResponse(String url) async {

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    String responseBody = await response.transform(utf8.decoder).join();
    Map jsonResponse = jsonDecode(responseBody) as Map;
    httpClient.close();
    return jsonResponse;
  }
**/
  static String getURL(String query)
  {
    return "https://serpapi.com/search.json?q=" + query + "&location=seattle%2C+washington%2C+united+states&api_key=266ad15c9184a2c77b4053461db3537acbabbc8f018f417e9dc029d403bfd6df";
  }
}