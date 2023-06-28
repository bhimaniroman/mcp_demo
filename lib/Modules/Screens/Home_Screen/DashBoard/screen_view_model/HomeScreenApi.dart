// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as Http;

class DashBoardViewModel {

  static int? index1;

  static var Domain = "https://marvelsgaming.com/apis/mcfl-api/r1/json/";

  static Future<dynamic> CategoryScreenData({required int index, required int paginationIndex}) async {
    index1 = index;
    String? lastUrl;
    if(index == 0){
      lastUrl = 'trending-girls-data';
    }
    else if(index == 1){
      lastUrl = 'popular-girls-data';
    }
    else if(index == 2){
      lastUrl = 'girls-shirts-data';
    }
    else if(index == 3){
      lastUrl = 'girls-pants-data';
    }
    else if(index == 4){
      lastUrl = 'free-skins-data';
    }
    else if(index == 5){
      lastUrl = 'premium-skins-data';
    }

    String uri = "$Domain$lastUrl/$paginationIndex";
      var map = <String, String>{};
      map["api_auth"] = "WR-34-TG-GF-JK-SD-JH-KJ-KG-QW-ET-32-XC";

    Http.MultipartRequest request = Http.MultipartRequest('POST', Uri.parse(uri));

    request.fields.addAll(map);
    Http.Response response = await Http.Response.fromStream(await request.send());
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
    else if(response.statusCode == 404){
    }
  }
}