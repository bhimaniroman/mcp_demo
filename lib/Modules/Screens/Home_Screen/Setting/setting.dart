// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../AppAds/utility.dart';
import '../../../../AppData/AppData.dart';
import '../../../../AppData/Images.dart';
import '../HowToUse/How_To_use.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text('Settings',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold,color: textcolor),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()
                ),
                child:  InkWell(
                  onTap: (){
                    LaunchReview.launch(iOSAppId: '6443813370',writeReview: false);
                  },
                  child:  ListTile(
                    leading: LinearGradientMask(child: SvgPicture.asset(Images.rateus,color: Colors.white,)),
                    title: Text('Rate Us',style: GoogleFonts.poppins()),
                    trailing: const DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        gradient: RadialGradient(
                          center: Alignment.topLeft,
                          radius: 1,
                          colors: [Colors.purple,
                            Colors.blueAccent],
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                      ),
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                ),
                child:  InkWell(
                  onTap: () {
                    Get.to(const How_to_use());
                  },
                  child: ListTile(
                    leading: LinearGradientMask(child: SvgPicture.asset(Images.howToUse,color: Colors.white,)),
                    title: Text('How To Use',style: GoogleFonts.poppins()),
                    trailing: const DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        gradient: RadialGradient(
                          center: Alignment.topLeft,
                          radius: 1,
                          colors: [Colors.purple,
                            Colors.blueAccent],
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                      ),
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                ),
                child: InkWell(
                  onTap: (){
                    Share.share('https://apps.apple.com/us/app/candy-crush-saga/id553834731');
                  },
                  child:  ListTile(
                    leading: LinearGradientMask(child: SvgPicture.asset(Images.share,color: Colors.white,)),
                    title: Text('Share',style: GoogleFonts.poppins()),
                    trailing: const DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        gradient: RadialGradient(
                          center: Alignment.topLeft,
                          radius: 1,
                          colors: [Colors.purple,
                            Colors.blueAccent],
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                      ),
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                ),
                child:  InkWell(
                  onTap: () {
                    launchUrlString(Utility.appPrivacy);
                  },
                  child: ListTile(
                    leading: LinearGradientMask(child: SvgPicture.asset(Images.privacypolicy,color: Colors.white,)),
                    title: Text('Privacy Policy',style: GoogleFonts.poppins()),
                    trailing: const DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        gradient: RadialGradient(
                          center: Alignment.topLeft,
                          radius: 1,
                          colors: [Colors.purple,
                            Colors.blueAccent],
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                      ),
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                ),
                child:  InkWell(
                  onTap: () {
                    launchUrlString(Utility.appTerms);
                  },
                  child: ListTile(
                    leading: LinearGradientMask(child: SvgPicture.asset(Images.terms,color: Colors.white,)),
                    title: Text('Terms',style: GoogleFonts.poppins()),
                    trailing: const DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        gradient: RadialGradient(
                          center: Alignment.topLeft,
                          radius: 1,
                          colors: [Colors.purple,
                            Colors.blueAccent],
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                      ),
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                ),
                child:  InkWell(
                  onTap: () async {
                    String email = Uri.encodeComponent(Utility.appSocial);
                    String subject = Uri.encodeComponent("Hello Flutter");
                    String body = Uri.encodeComponent("Hi! I'm Flutter Developer");
                    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                    if (await launchUrl(mail)) {
                    }else{
                    }
                  },
                  child: ListTile(
                    leading: LinearGradientMask(child: SvgPicture.asset(Images.feedback,color: Colors.white,)),
                    title: Text('Feedback',style: GoogleFonts.poppins()),
                    trailing: const DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        gradient: RadialGradient(
                          center: Alignment.topLeft,
                          radius: 1,
                          colors: [Colors.purple,
                            Colors.blueAccent],
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                      ),
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
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
          colors: [Colors.purple,
            Colors.blueAccent],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}


