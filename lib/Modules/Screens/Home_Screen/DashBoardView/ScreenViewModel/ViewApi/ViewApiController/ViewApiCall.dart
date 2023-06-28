// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:get/get.dart';

import '../../../Models/ViewModel/ViewModel.dart';
import '../ViewApiService/ApiService.dart';

class ViewDataController extends GetxController implements GetxService {
  var isLoading = true.obs;
  List<bool> wallpaperViewData = [];

  void WallpaperViewData(view , skinId) async {
    isLoading(true);
    try {
      Map<String, dynamic> body = {};
      body["api_auth"] = "WR-34-TG-GF-JK-SD-JH-KJ-KG-QW-ET-32-XC";
      body["skin_id"] = skinId.toString();
      String? jsonString = await WallpaperViewService.SkinViewData(body);
      if (jsonString != null) {
        Map<String, dynamic> nMap = await jsonDecode(jsonString);
        List<dynamic> nList = nMap["data"];
        wallpaperViewData =
            nList.map((e) => ViewModel.fromJson(e)).cast<bool>().toList();
      }
      update(view++);
    } finally {
      isLoading.value = false;
    }
  }
}
