// ignore_for_file: unnecessary_null_comparison, camel_case_types, non_constant_identifier_names

import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mcp_demo/Modules/Screens/Home_Screen/DashBoardView/ScreenViewModel/UnLike/UnLikeApiController/UnLikeController.dart';
import 'package:mcp_demo/Modules/Screens/Home_Screen/SearchScreen/View/SearchScreen.dart';
import 'package:mcp_demo/Utils/utils.dart';
import '../../../../AppAds/ad_services.dart';
import '../../../../AppAds/utility.dart';
import '../../../../AppData/AppData.dart';
import '../../../../AppData/Images.dart';
import '../DashBoard/Models/Trending_Model.dart';
import '../DashBoardView/ScreenViewModel/Download/DownloadApiController/DownloadController.dart';
import '../DashBoardView/ScreenViewModel/Like/LikeApiController/LikeController.dart';
import '../HowToUse/How_To_use.dart';

class Skin_Details extends StatefulWidget {
  const Skin_Details({Key? key}) : super(key: key);

  @override
  State<Skin_Details> createState() => _Skin_DetailsState();
}

class _Skin_DetailsState extends State<Skin_Details> {

  dynamic arguments = Get.arguments;
  TrendingData? trendingData;
  final progressNotifier = ValueNotifier<double?>(0.0);
  List<String> fileName =[];
  var paths = '';
  
  bool isLiked = false;

  final SkinLikeDataController skinLikeDataController = Get.put(SkinLikeDataController());

  final SkinUnLikeDataController skinUnLikeDataController = Get.put(SkinUnLikeDataController());

  final DownloadDataController downloadDataController = Get.put(DownloadDataController());

  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );

  @override
  void initState() {
    super.initState();
    if(arguments != null){
      trendingData = arguments["trendingData"];
    }
    _showNativeBannerAd();
    AdService.showGoogleNativeAd1();
    AdService.showGoogleNativeAd2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
          Get.back(result: trendingData);
        }, icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          trendingData?.skinName ?? "",
          style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const How_to_use());
              },
              icon: const Icon(
                Icons.lightbulb,
                color: Colors.orangeAccent,
              ))
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                 Image(
                  image: const AssetImage(Images.BackGroundImage),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03),
                      child: Card(
                        child: Stack(
                          children: [
                                SizedBox(
                                height: 300,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(trendingData?.skinThumbnail ?? ""),
                                        fit: BoxFit.cover,
                                      )),
                                )),
                            if(trendingData?.skinType == 'Premium' && Utility.isSubscribe == false)...{
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 9),
                                child: SvgPicture.asset(
                                  Images.premium,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            }
                            else...{}
                              ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              trendingData?.skinName?.toUpperCase() ?? "",
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       Row(
                         children: [
                           Utills.eyeButton(context),
                           SizedBox(
                             width: MediaQuery.of(context).size.width * 0.01,
                           ),
                           Text(trendingData?.skinViews ?? "",style: GoogleFonts.poppins(fontSize: 15,color: textcolor),),
                         ],
                       ),
                       Row(
                         children: [
                           InkWell(
                             onTap: () {
                               var id = trendingData?.skinId;
                               int like = int.parse(trendingData!.skinLikes as String);
                               like++;
                               setState(() {
                                 if(trendingData?.isLike == false){
                                   setState(() {
                                     trendingData?.isLike = true;
                                     trendingData?.skinLikes = "${int.parse(trendingData?.skinLikes ??"0") + 1}";
                                     skinLikeDataController.SkinLikeDataApiCall(like , id);
                                   });
                                 }else if(trendingData?.isLike == true){
                                   setState(() {
                                     like--;
                                     trendingData?.isLike = false;
                                     isLiked = false;
                                     trendingData?.skinLikes = "${int.parse(trendingData?.skinLikes ??"0") - 1}";
                                     skinUnLikeDataController.SkinUnLikeDataApiCall(like, id);
                                   });
                                 }
                               });
                             },
                             child: trendingData?.isLike ?? false ? Utills.likeButton(context) : const Icon(Icons.favorite_border,color: Colors.redAccent,),
                           ),
                           SizedBox(
                             width: MediaQuery.of(context).size.width * 0.01,
                           ),
                           Text(trendingData?.skinLikes ?? "",style: GoogleFonts.poppins(fontSize: 15,color: textcolor),),
                         ],
                       ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  if(trendingData?.skinType == 'Premium' && Utility.isSubscribe == false && Utility.isFirstRewardAd == false){
                                    Utills().watchVideoDialogue(
                                      context,
                                      onTap: () {
                                        Get.back();
                                        if (Utility.appAds == "true" &&
                                            Utility.isRewarded == "true" &&
                                            Utility.isSubscribe == false
                                        ) {
                                          AdService.loadGoogleRewardedAd(
                                            context: context,
                                          );
                                        }
                                        setState(() {
                                          Future.delayed(const Duration(seconds: 5), () {
                                            download();
                                          });
                                        });
                                      },
                                    );
                                  }
                                  else{
                                    setState(() {
                                      Utills.lodaingDailog(context);
                                      Future.delayed(const Duration(seconds: 3), () {
                                        download();
                                        Get.back();
                                      });
                                    });
                                  }
                                  var id = trendingData?.skinId;
                                  int Download = int.parse(trendingData?.skinDownloads as String);
                                  setState(() {
                                    Download++;
                                    downloadDataController.SkinDownloadData(Download , id);
                                  });
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height: 60,
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 6.0, 10.0, 6.0),
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [
                                        Colors.purple,
                                        Colors.blueAccent
                                      ]),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Center(
                                    child: Text(
                                      'Download',
                                      style: TextStyle(
                                          color: fontcolor, fontSize: 25.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () {
                                Get.to(const How_to_use());
                              },
                              child: Text('How To Apply?',style: GoogleFonts.poppins(fontSize: 15),)),
                          if (Utility.appAds == "true" &&
                              Utility.isNative == "true" &&
                              Utility.isSubscribe == false) ...{
                            if (Utility.adsPriority == 'Google') ...{
                              AdService.nativeScreenAd2 == null
                                  ? const SizedBox()
                                  : Container(
                                height: Platform.isAndroid
                                    ? MediaQuery.of(context).size.height *
                                    (15 / 100)
                                    : MediaQuery.of(context).size.height *
                                    (40 / 100),
                                alignment: Alignment.center,
                                child:  AdWidget(ad: AdService.nativeScreenAd1!),
                              ),
                            } else ...{
                              SizedBox(
                                height: 300,
                                child: currentAd,
                              ),
                            },
                          },
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  download() async {
    if (trendingData?.skinType == 'Premium') {
      try {
        String path = '${trendingData?.skinBundle}';
        GallerySaver.saveImage(path.toLowerCase()).then((value) {
          setState(() {

            final snackBar = SnackBar(
              backgroundColor: textcolor,
              content: Text('Image Download Successfully',
                  style: GoogleFonts.poppins(fontSize: 15, color: fontcolor)),
              action: SnackBarAction(
                label: 'Cancel',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Utills.rateUsDialog(context);
          });
        });
        if (path == null) {
          return;
        }
      } on PlatformException catch (error) {
        return error;
      }
    } else {
      Utills.lodaingDailog(context);
      try {
        String path = '${trendingData?.skinBundle}';
        GallerySaver.saveImage(path.toLowerCase()).then((value) {
          setState(() {
            Get.back();
            final snackBar = SnackBar(
              backgroundColor: textcolor,
              content: Text('Image Download Successfully',
                  style: GoogleFonts.poppins(fontSize: 15, color: fontcolor)),
              action: SnackBarAction(
                label: 'Cancel',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Utills.rateUsDialog(context);
          });
        });
        if (path == null) {
          return;
        }
      } on PlatformException catch (error) {
        return error;
      }
    }
  }

  _showNativeBannerAd() {
    setState(() {
      currentAd = AdService().showFBnativeAd();
    });
  }
}
