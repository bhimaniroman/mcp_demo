// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../../AppAds/ad_services.dart';
import '../../../../AppAds/utility.dart';
import '../../../../AppData/AppData.dart';
import '../../../../AppData/Images.dart';
import '../../../../Utils/utils.dart';
import '../DashBoard/Models/Trending_Model.dart';
import '../DashBoardView/ScreenViewModel/ViewApi/ViewApiController/ViewApiCall.dart';
import '../SkinDetails/Skin_Details.dart';

class Skin_Screen extends StatefulWidget {
  const Skin_Screen({Key? key}) : super(key: key);

  @override
  State<Skin_Screen> createState() => _Skin_ScreenState();
}

class _Skin_ScreenState extends State<Skin_Screen> {

  dynamic arguments = Get.arguments;
  int index = 0;
  List<TrendingData>? trendingList;
  List<TrendingData> tempTrendingList = [];
  TrendingData? trendingData;

  final ViewDataController viewDataController = Get.put(ViewDataController());

  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );

  @override
  void initState() {
    super.initState();
    if(arguments != null){
      index = arguments["index"];
      trendingData = arguments["trendingData"];
      trendingList = arguments["trendingList"];

      tempTrendingList.addAll(trendingList ?? []);
      tempTrendingList.removeAt(index);
    }
    var skinId = trendingData?.skinId ?? "";
    int view = int.parse(trendingData?.skinViews.toString() ?? "0");
    setState(() {
      view++;
      viewDataController.WallpaperViewData(view , skinId);
      trendingData?.skinViews = "${int.parse(trendingData?.skinViews ??"0") + 1}";
    });
    _showNativeBannerAd();
    AdService.showGoogleNativeAd1();
    AdService.showGoogleNativeAd2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trendingData?.skinName ?? "",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 25),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
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
                                image:  DecorationImage(image:
                                NetworkImage(trendingData?.skinThumbnail ?? ""),
                                  fit: BoxFit.cover,
                                )
                              ),
                            ),
                        ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          trendingData?.skinName ?? "",
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(const Skin_Details(),arguments: ({
                                "trendingData" : trendingData,
                                "index" : index
                              }));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 60,
                              padding: const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [Colors.purple, Colors.blueAccent]),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(color: fontcolor, fontSize: 25.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                     const SizedBox(
                        height: 20,
                      ),
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
                            child: AdWidget(ad: AdService.nativeScreenAd2!),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    children: [
                      Text('Related Skins',style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),)
                    ],
                  ),
                ),
                Visibility(
                  visible: tempTrendingList.isNotEmpty,
                  child: SizedBox(
                    height: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                        itemCount: tempTrendingList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: MediaQuery.of(context).size.height * 0.35,
                            crossAxisCount: 2),
                        itemBuilder: (context, i) {
                          return Stack(
                            children: [
                              InkWell(
                               onTap: ()  => setState(() {
                                 Get.to(const Skin_Details(),arguments: ({
                                   "trendingData" : tempTrendingList[i],
                                   "index" : index
                                 }));
                               }),
                                child: Card(
                                  child: Column(
                                    children: [
                                      Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: MediaQuery.of(context).size.height * 0.23,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  image:  DecorationImage(image:
                                                  NetworkImage(tempTrendingList[i].skinThumbnail ?? ""),
                                                    fit: BoxFit.fill,)
                                              ),
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                          // ${trendingData.skinName!.length < 10 ? trendingData.skinName : "${trendingData.skinName!.substring(0, 10)}..."}
                                            "${tempTrendingList[i].skinName!.length < 10 ? tempTrendingList[i].skinName : '${tempTrendingList[i].skinName!.substring(0, 10)}...'}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15, color: textcolor,fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                          children: [
                                            Utills.eyeButton(context),
                                            SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                            Text(tempTrendingList[i].skinViews ?? "",style: GoogleFonts.poppins(fontSize: 15,color: textcolor),),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.007,
                                            ),
                                            Utills.likeButton(context),
                                            SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                            Text(tempTrendingList[i].skinLikes ?? "",style: GoogleFonts.poppins(fontSize: 15,color: textcolor),),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showNativeBannerAd() {
    setState(() {
      currentAd = AdService().showFBnativeAd();
    });
  }
}
