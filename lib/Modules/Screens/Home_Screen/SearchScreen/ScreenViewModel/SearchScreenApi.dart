// ignore_for_file: library_prefixes, non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as Http;

import '../../../Constants/AppConstants.dart';

class SearchService{

  static var Domain = AppConstants.BASE_URL;

  static int? index1;

  static Future<dynamic> CategorySearchData({required int index, required int paginationIndex,required String value}) async {

    String uri = "$Domain${AppConstants.SEARCH_DATA}/$paginationIndex";
    var map = <String, String>{};
    map["api_auth"] = "WR-34-TG-GF-JK-SD-JH-KJ-KG-QW-ET-32-XC";
    map["search_name"] = value.toString();

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