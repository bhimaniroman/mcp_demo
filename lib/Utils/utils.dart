// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcp_demo/Modules/Screens/Home_Screen/InAppPurchase/InAppPurchase.dart';
import 'package:mcp_demo/Modules/Screens/Home_Screen/OnBoarding/OnBoarding_Screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../AppAds/utility.dart';
import '../AppData/AppData.dart';
import '../AppData/AppWidget.dart';
import '../AppData/Images.dart';
import '../Modules/Screens/Home_Screen/DashBoard/View/DashBoard.dart';
import '../main.dart';

class Utills {

  watchVideoDialogue(BuildContext context, {Function()? onTap}) {
    showDialog(
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.55),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.black
                      ),
                      child: const Center(
                        child: Icon(Icons.close,color: Colors.white,size: 20,),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(
                    child: Icon(Icons.play_arrow_rounded,color: Colors.white,size: 50,),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Unlock Premium',style: GoogleFonts.rubik(fontWeight: FontWeight.bold,fontSize: 25),)
              ],
            ),
            content: appText(
                title: "Watch Video ad to Download for Free",
                color: Colors.black,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
                fontSize: 13),
            actionsPadding: const EdgeInsets.all(8.0),
            contentPadding: const EdgeInsets.only(top: 15, right: 8, left: 8),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          appText(
                              title: "Watch Video",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: fontcolor),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.width * 0.03),
                  InkWell(
                    onTap: () {
                      Get.to(const SubScription());
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LinearGradientMask(child: SvgPicture.asset(
                            Images.premium,
                            width: 20,
                            height: 30,
                            color: Colors.yellow,
                            fit: BoxFit.scaleDown,
                          ),),
                          appText(
                              title: "Unlocked All",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: fontcolor),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                ],
              ),
            ],
          );
        },
        context: context);
  }

  static adsFaile(BuildContext? context,) {
    showDialog(
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: bgcolor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: Get.height / 4.4,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height * 0.02),
                      appText(
                          title: "Video Loading Failed!",
                          color: textcolor,
                          fontSize: 22,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          fontWeight: FontWeight.w700),
                      SizedBox(height: Get.height * 0.02),
                      appText(
                        title: 'Please Try Again...!',
                        color: textcolor,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                      SizedBox(height: Get.height * 0.03),
                      SizedBox(
                        width: 140,
                        height: 45,
                        child: appButton(
                          title: "Reload",
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        context: context!);
  }

  static dialogConnection(int i, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Get.defaultDialog(
        barrierDismissible: false,
        backgroundColor: textcolor,
        title: 'No Connection ',
        content: Column(
          children: [
            SizedBox(height: Get.height * 0.02),
            Image.asset(Images.Internet,
                height: Get.height * 0.15, color: buttoncolor),
            SizedBox(height: Get.height * 0.02),
            const Text("Lost Connection Please again later ",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
                maxLines: 1,
                textAlign: TextAlign.center),
          ],
        ),
        confirm: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 4),
          child: SizedBox(
            width: 140,
            height: 45,
            child: appButton(
              title: "RETRY",
              onTap: () {
                Utility.check().then(
                  (value) {
                    if (value == false) {
                    } else {
                      Get.back();
                      Utility.getPackageInfo(context);
                      Get.to(const Onboarding());
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  static lodaingDailog(BuildContext context) {
    appTheme();
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black12,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          backgroundColor: textcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          child: Container(
            // width: Get.width,
            height: Get.height * 0.2,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: textcolor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  getData.read('appcolor') == true
                      ? 'assets/images/whiteLoader.gif'
                      : Images.BlackLoader,
                  height: 80,
                ),
                SizedBox(height: Get.height * 0.01),
                appText(
                    title: "Loading ...",
                    fontSize: 20,
                    textAlign: TextAlign.center,
                    letterSpacing: 0.2,
                    color: fontcolor,
                    fontWeight: FontWeight.bold),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static rateUsDialog(context) {
     return showDialog(
       context: context,
       builder: (context) {
         return Dialog(
           backgroundColor: textcolor,
           shape:
           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
           child: Padding(
             padding: const EdgeInsets.all(12.0),
             child: SizedBox(
               height: Get.height / 2.3,
               child: Column(
                 children: [
                   SizedBox(height: Get.height * 0.015),
                   Expanded(child: Image.asset(Images.RateUsGif, height: 100)),
                   SizedBox(
                     height: Get.height * 0.015,
                   ),
                   appText(
                       title: "Rate Us",
                       color: fontcolor,
                       fontSize: 16,
                       fontWeight: FontWeight.w600,
                       textAlign: TextAlign.center),
                   SizedBox(
                     height: Get.height * 0.006,
                   ),
                   appText(
                     title: "If you enjoy using our app, Please rate us",
                     textAlign: TextAlign.center,
                     color: fontcolor,
                     fontSize: 14,
                     fontWeight: FontWeight.w500,
                   ),
                   SizedBox(
                     height: Get.height * 0.02,
                   ),
                   InkWell(
                     onTap: () async {
                       bool dataSend = false;
                       Get.back();
                       var url = Uri.parse(
                           "http://syphnosys.com/rest/apple/blog/json/reviewed/");
                       await http.post(url, body: {
                         'user_device': Utility.deviceID,
                         'user_review': 'reviewed'
                       }).then((value) {
                         dataSend = true;
                       });
                       if (dataSend == true) {
                         await launch(
                           Utility.appPackage,
                           forceSafariVC: true,
                           forceWebView: false,
                           universalLinksOnly: true,
                           headers: <String, String>{
                             'my_header_key': 'my_header_value'
                           },
                         );
                       }
                       Utility.userReview = "false";
                     },
                     child: Container(
                       height: 40,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: buttoncolor,
                       ),
                       child: Center(
                         child: appText(
                             title: "Yes",
                             fontSize: 20,
                             fontWeight: FontWeight.w600,
                             color: fontcolor),
                       ),
                     ),
                   ),
                   SizedBox(height: Get.height * 0.015),
                   InkWell(
                     onTap: () => Get.back(),
                     highlightColor: Colors.transparent,
                     splashColor: Colors.transparent,
                     child: SizedBox(
                       height: 40,
                       child: Center(
                         child: appText(
                             title: "Not Now",
                             color: alertcolor,
                             fontSize: 14,
                             fontWeight: FontWeight.w500),
                       ),
                     ),
                   ),
                   SizedBox(height: Get.height * 0.015),
                 ],
               ),
             ),
           ),
         );
       },
     );
   }

  static viewButton(context) {
      return Container(
        height: 30,
        width: 80,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Colors.redAccent, Colors.purple]),
            borderRadius: BorderRadius.circular(10.0)),
        child: const Center(
          child: Text('View All'),
        ),
      );
  }

  static likeButton(context) {
    return const Center(
      child: Icon(Icons.favorite,size: 25,color: Colors.redAccent,),
    );
  }

  static eyeButton(context) {
    return const Center(
      child: Icon(Icons.remove_red_eye_outlined,size: 25,color: Colors.redAccent,),
    );
  }

  static downloadButton(context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.redAccent, Colors.purple]),
          borderRadius: BorderRadius.circular(10.0)),
      child: const Center(
        child: Icon(Icons.file_download_outlined,size: 35,),
      ),
    );
  }

  static shareButton(context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.redAccent, Colors.purple]),
          borderRadius: BorderRadius.circular(10.0)),
      child: const Center(
        child: Icon(Icons.ios_share,size: 30,),
      ),
    );
  }

  static settingArrow(context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(35.0)),
      child: const Center(
        child: Icon(Icons.arrow_forward_ios,size: 15,color: Colors.white,),
      ),
    );
  }
}
