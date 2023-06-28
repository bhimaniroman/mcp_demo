// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:get/get.dart';

import '../../../../DashBoard/Models/Trending_Model.dart';
import '../LIkeApiService/LikeApiCall.dart';

class SkinLikeDataController extends GetxController implements GetxService{
  var isLoading = true.obs;
  List<Trending> skinLikeData = [];


  void SkinLikeDataApiCall(like , id) async {
    isLoading(true);
    try {
      Map<String, dynamic> body = {};
      body["api_auth"] = "WR-34-TG-GF-JK-SD-JH-KJ-KG-QW-ET-32-XC";
      body["skin_id"] = id.toString();
      body["skin_likes"] = 'Like';
      String? jsonString = await SkinLikeService.SkinLikeData(body);
      if (jsonString != null) {
        Map<String, dynamic> nMap = jsonDecode(jsonString);
        List<dynamic> nList = nMap["data"];
        skinLikeData =
            nList.map((e) => Trending.fromJson(e)).toList();
      }
      update(like);
    } finally {
      isLoading.value = false;
    }
  }
}
