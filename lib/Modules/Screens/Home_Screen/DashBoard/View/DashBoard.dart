import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_demo/AppData/AppData.dart';
import 'package:mcp_demo/Modules/Screens/Home_Screen/InAppPurchase/InAppPurchase.dart';
import 'package:mcp_demo/Modules/Screens/Home_Screen/InAppPurchase/inAppPurchaseController.dart';
import 'package:mcp_demo/Modules/Screens/Home_Screen/Setting/setting.dart';
import '../../../../../AppAds/ad_services.dart';
import '../../../../../AppAds/utility.dart';
import '../../../../../AppData/Images.dart';
import '../../DashBoardView/View/DashBoard_View.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

List<String> categoryNameList = [
  'Trending Girls',
  'Popular Girls',
  'Girls Shirts',
  'Girls Pants',
  'Free Skins',
  'Premium Skins',
];

class _DashBoardState extends State<DashBoard> {

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print(Utility.isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold,color: textcolor),),
        centerTitle: true,
        leading: Visibility(
            visible: Utility.isSubscribe == false,
            child: InkWell(
              onTap: () {
                Get.to(const SubScription());
              },
              child: LinearGradientMask(
                child: SvgPicture.asset(
                  Images.premium,
                  width: 20,
                  height: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
            )),
        actions: [
          IconButton(onPressed: (){
            Get.to(const Setting());
          }, icon: Icon(Icons.settings,color: buttoncolor,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: 6,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              mainAxisExtent: MediaQuery.of(context).size.height * 0.27,
              crossAxisCount: 2), itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              Utility.isFirstRewardAd = false;
              if (Utility.appAds == "true" &&
                  Utility.screenAds == "true" &&
                  Utility.isInterstitial == "true" &&
                  Utility.isSubscribe == false) {
                if (Utility.adsCount == Utility.totalAdCount) {
                  Utility.totalAdCount = 0;
                  if (Utility.adsPriority == "Google") {
                    Get.to(const DashBoard_View(),arguments: ({
                      "index" : index,
                      "categoryName" : categoryNameList[index],
                    }));
                   Future.delayed(const Duration(milliseconds: 40),() {
                     AdService.loadGoogleScreenInterstitialAd(
                         context: context,
                         back: Get.to(const DashBoard_View(),arguments: ({
                           "index" : index,
                           "categoryName" : categoryNameList[index],
                         })));
                   },);
                  }
                } else {
                  Get.to(const DashBoard_View(),arguments: ({
                    "index" : index,
                    "categoryName" : categoryNameList[index],
                  }));
                  Utility.totalAdCount++;
                }
              } else {
                Get.to(const DashBoard_View(),arguments: ({
                  "index" : index,
                  "categoryName" : categoryNameList[index],
                }));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(Images.backgroundImage[index]),fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20)
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Center(
                    child: Image(image: AssetImage(Images.DashBoardIcon),height: 100,)
                  ),
                  Text(categoryNameList[index].toString(),style: GoogleFonts.poppins(fontSize: 20,color: textcolor),textAlign: TextAlign.center,)
                ],
              ),
            ),
          );
        },),
      ),
    );
  }
}

class LinearGradientMask extends StatelessWidget {
  const LinearGradientMask({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const RadialGradient(
          center: Alignment.topLeft,
          radius: 1,
          colors: [Colors.orangeAccent,
            Colors.orange],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
