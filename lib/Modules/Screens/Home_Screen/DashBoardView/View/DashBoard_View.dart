// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_demo/AppData/AppData.dart';
import 'package:mcp_demo/Utils/utils.dart';
import '../../../../../AppAds/ad_services.dart';
import '../../../../../AppAds/utility.dart';
import '../../../../../AppData/Images.dart';
import '../../DashBoard/Models/Trending_Model.dart';
import '../../DashBoard/screen_view_model/HomeScreenApi.dart';
import '../../SearchScreen/View/SearchScreen.dart';
import '../../SkinScreen/Skin_Screen.dart';

class DashBoard_View extends StatefulWidget {
  const DashBoard_View({Key? key}) : super(key: key);

  @override
  State<DashBoard_View> createState() => _DashBoard_ViewState();
}

class _DashBoard_ViewState extends State<DashBoard_View> {
  dynamic arguments = Get.arguments;
  int? index;
  String? CategoryName;
  Trending? trending;
  List<TrendingData> trendingList = [];
  List<TrendingData> tempTrendingList = [];

  ScrollController scrollController = ScrollController();

  int paginationIndex = 0;

  bool isLoader = false;

  @override
  void initState() {
    super.initState();
    if (arguments != null) {
      index = arguments["index"];
      CategoryName = arguments["categoryName"];
      getCategoryScreenData();
    }
    Get.put(DashBoardViewModel());
    // Get.put(CategoryController(apiClient: Get.find())).getCategoryWiseData();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent){
        getCategoryScreenData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          CategoryName.toString(),
          style: GoogleFonts.poppins(
              fontSize: 25, fontWeight: FontWeight.bold, color: textcolor),
        ),
        actions: [
          IconButton(onPressed: (){
            Get.to(const SearchScreen());
          }, icon: const Icon(Icons.search_rounded))
        ],
        centerTitle: true,
      ),
      body: tempTrendingList.isNotEmpty ? Stack(
        children: [
           Image(
            image: const AssetImage(Images.BackGroundImage),
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
          ),
          GridView.builder(
            itemCount: tempTrendingList.length,
            controller: scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: MediaQuery.of(context).size.height * 0.35,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              var trendingData = tempTrendingList[index];
              return InkWell(
                onTap: () async {
                  if (Utility.appAds == "true" &&
                      Utility.screenAds == "true" &&
                      Utility.isInterstitial == "true" &&
                      Utility.isSubscribe == false) {
                    if (Utility.adsCount == Utility.totalAdCount) {
                      Utility.totalAdCount = 0;
                      if (Utility.adsPriority == "Google") {
                        Future.delayed(const Duration(milliseconds: 40),() {
                          AdService.loadGoogleScreenInterstitialAd(
                              context: context,
                              back: Get.to(const Skin_Screen(),),
                          );
                        },);
                        Utility.isFirstRewardAd = false;
                        TrendingData? result = await Get.to(const Skin_Screen(),
                            arguments: ({
                              "trendingList": trendingList,
                              "trendingData": trendingData,
                              "index": index
                            }));
                        if(result != null){
                          setState(() {
                            tempTrendingList.where((element) => element.skinId == result.skinId).map((e) {
                              e.skinLikes = result.skinLikes;
                              e.skinViews = result.skinViews;
                            });
                          });
                        }
                      }
                    } else {
                      TrendingData? result = await Get.to(const Skin_Screen(),
                          arguments: ({
                            "trendingList": trendingList,
                            "trendingData": trendingData,
                            "index": index
                          }));
                      if(result != null){
                        setState(() {
                          tempTrendingList.where((element) => element.skinId == result.skinId).map((e) {
                            e.skinLikes = result.skinLikes;
                            e.skinViews = result.skinViews;
                          });
                        });
                      }
                      Utility.totalAdCount++;
                      Utility.isFirstRewardAd = false;
                    }
                  } else {
                    TrendingData? result = await Get.to(const Skin_Screen(),
                        arguments: ({
                          "trendingList": trendingList,
                          "trendingData": trendingData,
                          "index": index
                        }));
                    if(result != null){
                      setState(() {
                        tempTrendingList.where((element) => element.skinId == result.skinId).map((e) {
                          e.skinLikes = result.skinLikes;
                          e.skinViews = result.skinViews;
                        });
                      });
                    }
                    Utility.isFirstRewardAd = false;
                  }
                },
                child: Stack(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.23,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            trendingData.skinThumbnail ?? ""),
                                        fit: BoxFit.fill,
                                      )),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    // trendingList.isNotEmpty
                                    //     ? trendingList[index].dataName.length < 10
                                    //     ? trendingList[index].dataName
                                    //     : "${trendingList[index].dataName.substring(0, 10)}..."
                                    //     : '',
                                    "${trendingData.skinName!.length < 10 ? trendingData.skinName : "${trendingData.skinName!.substring(0, 10)}..."}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: textcolor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Utills.eyeButton(context),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.01,
                                ),
                                Text(
                                  trendingData.skinViews ?? "",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: textcolor),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.01,
                                ),
                                Utills.likeButton(context),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.01,
                                ),
                                Text(
                                  trendingData.skinLikes ?? "",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: textcolor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    if(trendingData.skinType == 'Premium' && Utility.isSubscribe == false)...{
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
              );
            },
          ),
          Visibility(
              visible: isLoader,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(child: CupertinoActivityIndicator(),),
                ],
              )),
        ],
      ) : const Center(
        child: CupertinoActivityIndicator(),
      )
    );
  }

  void getCategoryScreenData() async {
    setState(() {
      isLoader = true;
    });
    var data = await DashBoardViewModel.CategoryScreenData(index: index ?? 0, paginationIndex: paginationIndex);
    if (data != null) {
     if(data['data'] != 'No data found'){
       List<dynamic> treandingData = data['data'];
       List<TrendingData>? tempTrendingData = [];
       setState(() {
         tempTrendingData =  treandingData.map((e) => TrendingData.fromJson(e)).toList();
         trendingList = tempTrendingData ?? [];
         isLoader = false;
         tempTrendingList.addAll(tempTrendingData ?? []);
         trendingList.clear();
         trendingList.addAll(tempTrendingList);
       });
       paginationIndex += 10;
     }
     else  if(data['data'] == 'No data found'){
       setState(() {
         isLoader = false;
       });
     }
    }
  }
}
