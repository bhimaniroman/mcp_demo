// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'package:http/http.dart' as Http;

import '../../../../../Constants/AppConstants.dart';

class WallpaperViewService {
  static var client = Http.Client();
  static var Domain = AppConstants.BASE_URL;
  static var skinViewData = '$Domain${AppConstants.VIEW_DATA}';


  static Future<String?> SkinViewData(body) async {
    final response = await client.post(Uri.parse(skinViewData),body: body);
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