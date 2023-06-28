import 'package:google_mobile_ads/google_mobile_ads.dart';


import 'ad_services.dart';

class AppLifecycleReactor {
  final AdService appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => onAppStateChanged(state));
  }

  void onAppStateChanged(AppState appState) {
    if (appState == AppState.foreground) {
      AdService().showAppOpenGoogleShowAd();
    }
  }
}
