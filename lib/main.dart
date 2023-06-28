import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mcp_demo/Modules/Screens/Home_Screen/DashBoard/View/DashBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppAds/utility.dart';
import 'Modules/Screens/Home_Screen/OnBoarding/OnBoarding_Screen.dart';
import 'Utils/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

final getData = GetStorage();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    setState(() {});
    Utility.check().then((value) {
      if (value == false) {
        Utills.dialogConnection(1, context);
      } else {
        Utility.getPackageInfo(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mcp Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyApp1(),
    );
  }
}

class MyApp1 extends StatefulWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  @override
  void initState() {
    super.initState();
    getTime();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  void getTime() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('primaryTweetTime');

    if(value !=null){
      Get.offAll(const DashBoard());
    }else if(value == null){
      Get.to(const Onboarding());
    }
  }
}


