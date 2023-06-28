// ignore_for_file: avoid_print, file_names

import 'package:facebook_audience_network/ad/ad_interstitial.dart';
import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:facebook_audience_network/ad/ad_rewarded.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcp_demo/AppAds/utility.dart';
import '../Utils/utils.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static InterstitialAd? interstitialSplashAd;
  static InterstitialAd? interstitialScreenAd;

  static NativeAd? nativeScreenAd1;
  static NativeAd? nativeScreenAd2;
  static NativeAd? nativeScreenAd3;

  static bool isGoogleRewardedAdLoaded = false;

  static bool isFBInterstitialAdLoaded = false;
  static bool isFBRewardedAdLoaded = false;
  static RewardedAd? rewardedAd;
  static int rewardedFaile = 0;

  // open ads
  AppOpenAd? appOpenAd;
  bool isShowingAd = false;
  bool isLoading = false;
  DateTime? appOpenLoadTime;
  final Duration maxCacheDuration = Duration(hours: 4);

  bool get isAdAvailable {
    return appOpenAd != null;
  }

  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  void loadAppOpenGoogleAd({back}) {
    AppOpenAd.load(
      adUnitId: Utility.googleOpen,
      orientation: AppOpenAd.orientationPortrait,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          appOpenLoadTime = DateTime.now();
          appOpenAd = ad;
          showAppOpenGoogleShowAd();
        },
        onAdFailedToLoad: (error) {
          loadSecondFacebookAd(back);
        },
      ),
    );
  }

  void showAppOpenGoogleShowAd({back}) {
    if (!isAdAvailable) {
      loadAppOpenGoogleAd();
      return;
    }
    if (isShowingAd) {
      return;
    }
    if (DateTime.now().subtract(maxCacheDuration).isAfter(appOpenLoadTime!)) {
      appOpenAd!.dispose();
      appOpenAd = null;
      // loadAd();
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        isShowingAd = true;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        isShowingAd = false;
        ad.dispose();
        appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        isShowingAd = false;
        ad.dispose();
        appOpenAd = null;

        // loadAd();
      },
    );
    appOpenAd!.show();
  }

  static  showGoogleNativeAd1() {
    //MobileAds.instance.updateRequestConfiguration(RequestConfiguration(testDeviceIds: ["b7856347161150ab7f8461a10caaaa63"]));
    NativeAd(
      adUnitId: Utility.googleNativeOne,
      factoryId: 'listTile',
      // nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.medium),
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          nativeScreenAd1 = ad as NativeAd;
        },
        onAdFailedToLoad: (ad, error) {
          loadSecondFacebookNativeAd();
          debugPrint(
              'Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  static void showGoogleNativeAd2() {
   // MobileAds.instance.updateRequestConfiguration(RequestConfiguration(testDeviceIds: ["b7856347161150ab7f8461a10caaaa63"]));
    NativeAd(
      adUnitId: Utility.googleNativeOne,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          nativeScreenAd2 = ad as NativeAd;
        },
        onAdFailedToLoad: (ad, error) {
          loadSecondFacebookNativeAd();
          debugPrint(
              'Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  static void showGoogleNativeAd3() {
    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(testDeviceIds: ["b7856347161150ab7f8461a10caaaa63"]));
    NativeAd(
      adUnitId: Utility.googleNativeOne,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          nativeScreenAd3 = ad as NativeAd;
        },
        onAdFailedToLoad: (ad, error) {
          loadSecondFacebookNativeAd();
          debugPrint(
              'Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  static void loadGoogleScreenInterstitialAd({context, back}) {
    Utills.lodaingDailog(context);
    InterstitialAd.load(
        adUnitId: Utility.googleInterstitialTwo,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            Get.back();
            interstitialScreenAd = ad;
            showGoogleScreenInterstitialAd(back: back);
          },
          onAdFailedToLoad: (LoadAdError error) {
            loadSecondFacebookAd(back);
          },
        ));
  }

  static void showGoogleScreenInterstitialAd({back}) {
    if (interstitialScreenAd == null) {
      return;
    }
    interstitialScreenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad){},
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        back;
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      },
    );
    interstitialScreenAd!.show();
    interstitialScreenAd = null;
  }

  static void loadGoogleRewardedAd({String ? showData,snack, context}) {
    if(Utility.isFirstRewardAd == false){
      Utills.lodaingDailog(context);
    }
    else{
      return;
    }
    isGoogleRewardedAdLoaded = true;
    RewardedAd.load(
      adUnitId: Utility.googleRewardedOne,
      request: request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
          isGoogleRewardedAdLoaded = false;
          showGoogleRewardedAd(context: context, showData: showData, snack : snack);
          Get.back();
        },
        onAdFailedToLoad: (LoadAdError error) {
          isGoogleRewardedAdLoaded = false;
          rewardedFaile++;
          if (rewardedFaile == 2) {
            Get.back();
            rewardedFaile = 0;
            isGoogleRewardedAdLoaded = false;
          } else {
            Get.back();
            Utills.adsFaile(context);
            isGoogleRewardedAdLoaded = false;
          }
          rewardedAd == null;
        },
      ),
    );
  }

  static void showGoogleRewardedAd({String? showData, context,  snack}) {
    isGoogleRewardedAdLoaded = true;
    if (rewardedAd == null) {
      // isGoogleRewardedAdLoaded = false;
      // loadGoogleRewardedAd();
      isGoogleRewardedAdLoaded = false;
      Get.back();

      return;
    }
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) => {},
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          ad.dispose();
          isGoogleRewardedAdLoaded = false;
          Utility.isFirstRewardAd = true;
          // showData;
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          rewardedFaile++;

          if (rewardedFaile == 2) {
            rewardedFaile = 0;
            isGoogleRewardedAdLoaded = false;
            Get.back();
          } else {
            Utills.adsFaile(context);
            isGoogleRewardedAdLoaded = false;
            Get.back();
          }
          ad.dispose();
          isGoogleRewardedAdLoaded = false;
        },
        onAdImpression: (ad) {
          isGoogleRewardedAdLoaded = false;
        });
    rewardedAd!.setImmersiveMode(true);

    rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      isGoogleRewardedAdLoaded = false;
    });

    rewardedAd = null;
  }

  ////Facebook Ads/////
  Widget showFBnativeAd({height}) {
    return FacebookNativeAd(
      placementId: Utility.facebookNativeOne,
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {},
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }

  static int req = 0;

  static void loadFBScreenInterstitialAd(context, {back}) {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: Utility.facebookInterstitialOne,
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED) {
          // Get.back();
          isFBInterstitialAdLoaded = true;
          showFBScreenInterstitialAd(context: context);
        }

        if (result == InterstitialAdResult.ERROR) {
          loadSecondGoogleAd(back);
          Get.back();
        }
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          Get.back();
          isFBInterstitialAdLoaded = false;
          back;
        }
      },
    );
  }

  static void showFBScreenInterstitialAd({context, back}) {
    if (isFBInterstitialAdLoaded == true) {
      FacebookInterstitialAd.showInterstitialAd();
      isFBInterstitialAdLoaded = false;
      back;
    } else {
    }
  }

  static void loadFBRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: Utility.facebookRewardedOne,
      listener: (result, value) {
        if (result == RewardedVideoAdResult.LOADED) {
          isFBRewardedAdLoaded = true;
        }
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
          isFBRewardedAdLoaded = true;
        }
        if (result == RewardedVideoAdResult.ERROR) {
          loadSecondGoogleRewardedVideoAd();
        }

        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            (value == true || value["invalidated"] == true)) {
          isFBRewardedAdLoaded = false;
          loadFBRewardedVideoAd();
        }
      },
    );
  }

  static void showFBRewardedAd() {
    if (isFBRewardedAdLoaded == true) {
      FacebookRewardedVideoAd.showRewardedVideoAd();
      isFBRewardedAdLoaded == false;
    } else {
    }
  }

  // second ads //

  static void loadSecondFacebookAd(context, {back}) {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: Utility.facebookInterstitialOne,
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED) {
          // Get.back();
          isFBInterstitialAdLoaded = true;
          showFBScreenInterstitialAd(context: context);
        }

        if (result == InterstitialAdResult.ERROR) {
          Get.back();
        }
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          Get.back();
          isFBInterstitialAdLoaded = false;
          Get.back();
        }
      },
    );
  }

  static void loadSecondGoogleAd(context, {back}) {
    InterstitialAd.load(
        adUnitId: Utility.googleInterstitialTwo,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            Get.back();
            interstitialScreenAd = ad;
            showGoogleScreenInterstitialAd(back: back);
          },
          onAdFailedToLoad: (LoadAdError error) {
            back;
          },
        ));
  }


  static void loadSecondGoogleRewardedVideoAd({String? showData, snack, context}) {
    isGoogleRewardedAdLoaded = true;
    RewardedAd.load(
      adUnitId: Utility.googleRewardedOne,
      request: request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
          isGoogleRewardedAdLoaded = false;
          showGoogleRewardedAd(context: context, showData: showData, snack: snack);
          Get.back();
        },
        onAdFailedToLoad: (LoadAdError error) {
          isGoogleRewardedAdLoaded = false;
          rewardedFaile++;
          rewardedAd == null;
        },
      ),
    );
  }

  static void loadSecondFacebookNativeAd({height}) {
       FacebookNativeAd(
        placementId: Utility.facebookNativeOne,
        adType: NativeAdType.NATIVE_AD_VERTICAL,
        width: double.infinity,
        height: 300,
        backgroundColor: Colors.blue,
        titleColor: Colors.white,
        descriptionColor: Colors.white,
        buttonColor: Colors.deepPurple,
        buttonTitleColor: Colors.white,
        buttonBorderColor: Colors.white,
        listener: (result, value) {},
        keepExpandedWhileLoading: true,
        expandAnimationDuraion: 1000,
      );
  }
}
