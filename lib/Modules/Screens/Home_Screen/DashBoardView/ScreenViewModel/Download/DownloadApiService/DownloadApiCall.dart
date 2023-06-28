// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'package:http/http.dart' as Http;
import 'package:mcp_demo/Modules/Screens/Constants/AppConstants.dart';

class SkinDownloadService {
  static var client = Http.Client();
  static var Domain = AppConstants.BASE_URL;
  static var skinDownloadData = '$Domain${AppConstants.DOWNLOAD_DATA}';


  static Future<String?> SkinDownloadData(body) async {
    final response = await client.post(Uri.parse(skinDownloadData),body: body);

    if(response.statusCode == 200) {
      var data = response.body;
      return data.toString();
    }
    else if(response.statusCode == 404){
    }
    else{}
    return null;
  }
}