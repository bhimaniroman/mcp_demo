// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:get/get.dart';
import 'package:mcp_demo/Modules/Screens/Home_Screen/DashBoardView/ScreenViewModel/UnLike/UnLikeApiService/UnLikeApiCall.dart';

import '../../../../DashBoard/Models/Trending_Model.dart';

class SkinUnLikeDataController extends GetxController implements GetxService{
  var isLoading = true.obs;
  List<Trending> skinLikeData = [];


  void SkinUnLikeDataApiCall(like , id) async {
    isLoading(true);
    try {
      Map<String, dynamic> body = {};
      body["api_auth"] = "WR-34-TG-GF-JK-SD-JH-KJ-KG-QW-ET-32-XC";
      body["skin_id"] = id.toString();
      body["skin_likes"] = 'Unlike';
      String? jsonString = await SkinUnLikeService.SkinUnLikeData(body);
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
