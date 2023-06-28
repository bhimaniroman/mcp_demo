import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../AppAds/ad_services.dart';
import '../../../../../AppAds/utility.dart';
import '../../../../../AppData/AppData.dart';
import '../../../../../Utils/utils.dart';
import '../../DashBoard/Models/Trending_Model.dart';
import '../../SkinScreen/Skin_Screen.dart';
import '../ScreenViewModel/SearchScreenApi.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

TextEditingController searchcontroller = TextEditingController();

ScrollController scrollController = ScrollController();

int paginationIndex = 0;

bool isLoader = false;

int? index;

Trending? trending;
List<TrendingData> trendingList = [];
List<TrendingData> tempTrendingList = [];

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getCategorySearchData(value: value!);
      }
    });
  }

  String? value;

  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
              searchcontroller.clear();
              tempTrendingList.clear();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: TextField(
              onSubmitted: (value) {
                isSubmitted = true;
                getCategorySearchData(value: this.value = value);
              },
              controller: searchcontroller,
              style: TextStyle(
                color: textcolor,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                hintText: "Search...",
                hintStyle: GoogleFonts.poppins(color: textcolor),
              ),
            ),
          ),
          tempTrendingList.isNotEmpty
              ? Expanded(
                  child: Stack(
                    children: [
                      GridView.builder(
                        itemCount: tempTrendingList.length,
                        controller: scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent:
                                MediaQuery.of(context).size.height * 0.35,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          var trendingData = tempTrendingList[index];
                          return Stack(
                            children: [
                              InkWell(
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
                                              back: Get.to(const Skin_Screen(),));
                                        },);
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
                                  }
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.23,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    trendingData.skinThumbnail ??
                                                        ""),
                                                fit: BoxFit.fill,
                                              )),
                                        ),
                                      )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${trendingData.skinName?.substring(0, 5)}...",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    color: textcolor,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height *
                                            0.01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            Utills.eyeButton(context),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01,
                                            ),
                                            Text(
                                              trendingData.skinViews ?? "",
                                              // trendingData!.skinViews?.length > 1000 ? "${int.parse(trendingData.skinViews.length/1000 ?? ""))} K" : trendingData.skinViews ?? "",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15, color: textcolor),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                            ),
                                            Utills.likeButton(context),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01,
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
                              ),
                            ],
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
                  ),
                )
              : isSubmitted ? const Center(child: CupertinoActivityIndicator()) : const Center(
            child: Text('No Data Found'),
          ),
        ],
      ),
    );
  }

  void getCategorySearchData({required String value}) async {
    setState(() {
      isLoader = true;
    });
    var data = await SearchService.CategorySearchData(
        value: value, index: index ?? 0, paginationIndex: paginationIndex);
    if (data != null) {
      if (data['data'] != 'No data found') {
        List<dynamic> treandingData = data['data'];
        List<TrendingData>? tempTrendingData = [];
        setState(() {
          tempTrendingData =
              treandingData.map((e) => TrendingData.fromJson(e)).toList();
          trendingList = tempTrendingData ?? [];
          isLoader = false;
          tempTrendingList.addAll(tempTrendingData ?? []);
          trendingList.clear();
          trendingList.addAll(tempTrendingList);
        });
        paginationIndex += 10;
      } else if (data['data'] == 'No data found') {
        setState(() {
          isLoader = false;
        });
      }
    }
  }
}
