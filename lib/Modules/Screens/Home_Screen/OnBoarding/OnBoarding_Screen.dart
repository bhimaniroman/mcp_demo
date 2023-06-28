// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../AppData/AppData.dart';
import '../../../../AppData/Images.dart';
import '../DashBoard/View/DashBoard.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  void saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  late DateTime tweet_time;

  void tweetTimePicker(BuildContext context) async {
    DateTime initialTime = DateTime.now();
    setState(() {
      saveData('primaryTweetTime', "${initialTime.day}:${initialTime.month}:${initialTime.year}");
      tweet_time = initialTime;
    });
    Get.offAll(const DashBoard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: 300,
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  fontcolor,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0, 0.5],
              ),
            ),
            width: MediaQuery.of(context).size.width,
            child: const Image(
              image: AssetImage(Images.onBoardingimage),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.58),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Welcome',
                        style: GoogleFonts.rubik(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'The Times of India, also known by its abbreviation TOI, is an Indian English language daily newspaper.',
                    style: GoogleFonts.rubik(fontSize: 15, color: textcolor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.09,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              tweetTimePicker(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 50,
                              padding: const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
                              decoration: BoxDecoration(color: Colors.deepPurpleAccent, borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(color: fontcolor, fontSize: 20.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
