// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:get/get.dart';
import '../../../Models/DownloadModel/DownloadModel.dart';
import '../DownloadApiService/DownloadApiCall.dart';

class DownloadDataController extends GetxController implements GetxService {
  var isLoading = true.obs;
  List<bool> skinDownloadData = [];

  void SkinDownloadData(download , id) async {
    isLoading(true);
    try {
      Map<String, dynamic> body = {};
      body["api_auth"] = "WR-34-TG-GF-JK-SD-JH-KJ-KG-QW-ET-32-XC";
      body["skin_id"] = id.toString();
      String? jsonString = await SkinDownloadService.SkinDownloadData(body);
      if (jsonString != null) {
        Map<String, dynamic> nMap = await jsonDecode(jsonString);
        List<dynamic> nList = nMap["data"];
        skinDownloadData =
            nList.map((e) => Download.fromJson(e)).cast<bool>().toList();
      }
      update(download++);
    } finally {
      isLoading.value = false;
    }
  }
}
