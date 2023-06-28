// ignore_for_file: avoid_print, unnecessary_string_interpolations, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mcp_demo/Modules/Screens/Home_Screen/InAppPurchase/sharedPref.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Modules/Screens/Home_Screen/InAppPurchase/inAppPurchaseController.dart';

class Utility {
  //! application use
  static bool darkMode = false;
  static String updateDialogShowed = "";
  static bool dataGet = false;
  static int totalAdCount = 0;
  static bool isFirstRewardAd = false;
  static bool isSubscribe = false;
  static bool isLogin = false;

  static String appVersion = "";
  static String deviceID = "";

  //! user reviwed
  static String userID = "";
  static String userReview = "";

  //! app apps
  static String appPackage = "";
  static String appPrivacy = "";
  static String appTerms = "";
  static String appSocial = "";

  //! app version
  static String appAds = "";
  static String splashAds = "";
  static String screenAds = "";
  static String appBanner = "";
  static String appReview = "";
  static String appUpdate = "";
  static String updateTitle = "";
  static String updateDescription = "";
  static String updateButton = "";
  static String updateUrl = "";
  static String appBlogStatus = "";
  static String appBlogUrl = "";
  static int adsCount = 0;
  static int isFirstRewardAdCount = 1;

  //! app ads
  static String adsPriority = "";
  static String isNative = "";
  static String isInterstitial = "";
  static String isRewarded = "";
  static String isOpen = "";
  static String googleNativeOne = "";
  static String googleNativeTwo = "";
  static String googleInterstitialOne = "";
  static String googleInterstitialTwo = "";
  static String googleRewardedOne = "";
  static String googleRewardedTwo = "";
  static String googleOpen = "";
  static String facebookNativeOne = "";
  static String facebookNativeTwo = "";
  static String facebookInterstitialOne = "";
  static String facebookInterstitialTwo = "";
  static String facebookRewardedOne = "";
  static String facebookRewardedTwo = "";

  //! app banner
  static List<BannerList> banner = [];

  // app premium
  static List<PremiumDataList> premium = [];

  static String product_id = "";
  static String product_type = "";
  static String product_mrp = "";
  static String product_price = "";
  static String product_discount = "";
  static String product_sku = "";
  static String product_offer = "";
  static String product_feature_one = "";
  static String product_feature_two = "";
  static String product_feature_three = "";
  static String product_feature_four = "";
  static String product_carousel_title_one = "";
  static String product_carousel_slider_one = "";
  static String product_carousel_title_two = "";
  static String product_carousel_slider_two = "";
  static String product_carousel_title_three = "";
  static String product_carousel_slider_three = "";
  static String product_carousel_title_four = "";
  static String product_carousel_slider_four = "";
  static String product_status = "";




  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static getPackageInfo(BuildContext context) {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
      Utility.appVersion = packageInfo.version;
      Utility.deviceID = (await getDeviceId())!;
      getData(context);
      getPremiumData();
      final sharedPreferences = await SharedPreferences.getInstance();
      Get.lazyPut(() => sharedPreferences);
      Get.lazyPut(
            () => PrimumController(
          sharedPreferences: Get.find(),
        ),
      );
      Get.lazyPut(
            () => ConsumableStore(sharedPreferences: Get.find()),
      );
      Get.find<PrimumController>().verifyPreviousPurchases();
    });
  }

  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  static getData(BuildContext context) async {
    var url = Uri.parse("https://syphnosys.com/rests/apple/blog/json/apps/");
    await http.post(url, body: {
      'app_version': Utility.appVersion,
      'app_code': 'SYS-01'
    }).then((value) {
      Map Json_data = jsonDecode(value.body);

      Map apps = Json_data["apps"];
      Map version = Json_data["version"];
      Map ads = Json_data["ads"];
      List banner_list = Json_data["banner"];

      Utility.appPackage = apps["app_package"];
      Utility.appPrivacy = apps["app_privacy"];
      Utility.appTerms = apps["app_terms"];
      Utility.appSocial = apps["app_social"];

      Utility.appAds = version["app_ads"];
      Utility.splashAds = version["splash_ads"];
      Utility.screenAds = version["screen_ads"];
      Utility.appBanner = version["app_banner"];
      Utility.appReview = version["app_review"];
      Utility.appUpdate = version["app_update"];
      Utility.updateTitle = version["update_title"];
      Utility.updateDescription = version["update_description"];
      Utility.updateButton = version["update_button"];
      Utility.updateUrl = version["update_url"];
      Utility.appBlogStatus = version["app_blog_status"];
      Utility.adsCount = version["ads_count"];

      Utility.adsPriority = ads["ads_priority"];
      Utility.isNative = ads["is_native"];
      Utility.isInterstitial = ads["is_interstitial"];
      Utility.isRewarded = ads["is_rewarded"];
      Utility.isOpen = ads["is_open"];
      Utility.googleNativeOne = ads["google_native_one"];
      Utility.googleNativeTwo = ads["google_native_two"];
      Utility.googleInterstitialOne = ads["google_interstitial_one"];
      Utility.googleInterstitialTwo = ads["google_interstitial_two"];
      Utility.googleRewardedOne = ads["google_rewarded_one"];
      Utility.googleRewardedTwo = ads["google_rewarded_two"];
      Utility.googleOpen = ads["google_open"];
      Utility.facebookNativeOne = ads["facebook_native_one"];
      Utility.facebookNativeTwo = ads["facebook_native_two"];
      Utility.facebookInterstitialOne = ads["facebook_interstitial_one"];
      Utility.facebookInterstitialTwo = ads["facebook_interstitial_two"];
      Utility.facebookRewardedOne = ads["facebook_rewarded_one"];
      Utility.facebookRewardedTwo = ads["facebook_rewarded_two"];

      for (int i = 0; i < banner_list.length; i++) {
        BannerList obj = BannerList(
          banner_list[i]["banner_id"],
          banner_list[i]["banner_title"],
          banner_list[i]["banner_description"],
          banner_list[i]["banner_image"],
          banner_list[i]["banner_url"],
          banner_list[i]["banner_button"],
          banner_list[i]["banner_type"],
          banner_list[i]["banner_status"],
        );
        Utility.banner.add(obj);
      }
      dataGet = true;
    });
  }

  static getPremiumData() async {
    var url =
        Uri.parse("https://syphnosys.com/rests/apple/blog/json/subscription");
    await http.post(url).then((value) {
      Map Json_data = jsonDecode(value.body);

       List subscription = Json_data["subscription"];

      for (int i = 0; i < subscription.length; i++) {
        PremiumDataList obj = PremiumDataList(
          subscription[i]["product_id"],
          subscription[i]["product_type"],
          subscription[i]["product_mrp"],
          subscription[i]["product_price"],
          subscription[i]["product_discount"],
          subscription[i]["product_sku"],
          subscription[i]["product_offer"],
          subscription[i]["product_feature_one"],
          subscription[i]["product_feature_two"],
          subscription[i]["product_feature_three"],
          subscription[i]["product_feature_four"],
          subscription[i]["product_carousel_title_one"],
          subscription[i]["product_carousel_slider_one"],
          subscription[i]["product_carousel_title_two"],
          subscription[i]["product_carousel_slider_two"],
          subscription[i]["product_carousel_title_three"],
          subscription[i]["product_carousel_slider_three"],
          subscription[i]["product_carousel_title_four"],
          subscription[i]["product_carousel_slider_four"],
          subscription[i]["product_status"],
        );
        Utility.premium.add(obj);
      }
      dataGet = true;
    });
  }
}

class BannerList {
  String bannerId;
  String bannerTitle;
  String bannerDescription;
  String bannerImage;
  String bannerUrl;
  String bannerButton;
  String bannerType;
  String bannerStatus;

  BannerList(
      this.bannerId,
      this.bannerTitle,
      this.bannerDescription,
      this.bannerImage,
      this.bannerUrl,
      this.bannerButton,
      this.bannerType,
      this.bannerStatus);
}

class PremiumDataList {
  String product_id;
  String product_type;
  String product_mrp;
  String product_price;
  String product_discount;
  String product_sku;
  String product_offer;
  String product_feature_one;
  String product_feature_two;
  String product_feature_three;
  String product_feature_four;
  String product_carousel_title_one;
  String product_carousel_slider_one;
  String product_carousel_title_two;
  String product_carousel_slider_two;
  String product_carousel_title_three;
  String product_carousel_slider_three;
  String product_carousel_title_four;
  String product_carousel_slider_four;
  String product_status;

  PremiumDataList(
      this.product_id,
      this.product_type,
      this.product_mrp,
      this.product_price,
      this.product_discount,
      this.product_sku,
      this.product_offer,
      this.product_feature_one,
      this.product_feature_two,
      this.product_feature_three,
      this.product_feature_four,
      this.product_carousel_title_one,
      this.product_carousel_slider_one,
      this.product_carousel_title_two,
      this.product_carousel_slider_two,
      this.product_carousel_title_three,
      this.product_carousel_slider_three,
      this.product_carousel_title_four,
      this.product_carousel_slider_four,
      this.product_status);
}
