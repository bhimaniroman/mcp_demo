// ignore_for_file: prefer_interpolation_to_compose_strings, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:mcp_demo/AppAds/utility.dart';
import 'package:mcp_demo/Modules/Screens/Home_Screen/DashBoard/View/DashBoard.dart';
import 'package:mcp_demo/Modules/Screens/Home_Screen/InAppPurchase/sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<PurchaseDetails> purchases = [];
List<ProductDetails> products = [];
const bool kAutoConsume = true;
const String kConsumableId = 'iam_monthly';
const String kUpgradeId = 'iam_yearly';
const String kSilverSubscriptionId = 'monthly_subscription';
const String kGoldSubscriptionId = 'yearly_subscription';
const List<String> _kProductIds = <String>[
  kConsumableId,
  kUpgradeId,
  kSilverSubscriptionId,
  kGoldSubscriptionId,
];

class PrimumController extends GetxController implements GetxService {
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> subscription;
  List<String> notFoundIds = [];
  List<String> consumables = [];
  bool isAvailable = false;
  bool purchasePending = false;
  bool loading = true;
  String? queryProductError;
  bool isPrimumScreen = false;
  int select = 0;
  SharedPreferences sharedPreferences;
  bool isUserPremium = false;
  PrimumController({required this.sharedPreferences}) {
    initInApp();
  }

  Future<void> initInApp() async {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        inAppPurchase.purchaseStream;
    subscription = purchaseUpdated.listen((purchaseDetailsList) {
      listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    await initStoreInfo();
    await verifyPreviousPurchases();
  }

  Future<void> inAppStream() async {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        inAppPurchase.purchaseStream;
    subscription = purchaseUpdated.listen((purchaseDetailsList) {}, onDone: () {
      subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
  }

  Future<void> verifyPreviousPurchases() async {
    await inAppPurchase.restorePurchases();

    await sharedPreferences.setString('userType', "Free");
    await Future.delayed(const Duration(milliseconds: 100), () async {
      for (var pur in purchases) {

        if(pur.status == PurchaseStatus.restored){
          removeAds = true;
        }


        if (pur.productID.contains('iam_monthly')) {
          await sharedPreferences.setString("userType", "Premium");
          removeAds = true;
        }
        if (pur.productID.contains('iam_annual')) {
          await sharedPreferences.setString("userType", "Premium");
          removeAds = true;
        }
        if (pur.productID.contains('monthly_subscription')) {
          await sharedPreferences.setString("userType", "Premium");

          removeAds = true;
          silverSubscription = true;
        }

        if (pur.productID.contains('yearly_subscription')) {
          removeAds = true;
          await sharedPreferences.setString("userType", "Premium");
          goldSubscription = true;
        }
      }

      if (purchases != null && isPrimumScreen) {
        isPrimumScreen = false;
        update();
      }

      finishedLoad = true;
    });

    update();
  }

  bool _removeAds = false;
  bool get removeAds => _removeAds;
  set removeAds(bool value) {
    _removeAds = value;
    update();
  }

  bool _silverSubscription = false;
  bool get silverSubscription => _silverSubscription;
  set silverSubscription(bool value) {
    _silverSubscription = value;
    update();
  }

  bool _goldSubscription = false;
  bool get goldSubscription => _goldSubscription;
  set goldSubscription(bool value) {
    _goldSubscription = value;
    update();
  }

  bool _finishedLoad = false;
  bool get finishedLoad => _finishedLoad;
  set finishedLoad(bool value) {
    _finishedLoad = value;
    update();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailableStore = await inAppPurchase.isAvailable();
    if (!isAvailableStore) {
      isAvailable = isAvailableStore;
      products = [];
      purchases = [];
      notFoundIds = [];
      consumables = [];
      purchasePending = false;
      loading = false;
      return;
    }

    ProductDetailsResponse productDetailResponse =
    await inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      queryProductError = productDetailResponse.error!.message;
      isAvailable = isAvailableStore;
      products = productDetailResponse.productDetails;
      purchases = [];
      notFoundIds = productDetailResponse.notFoundIDs;
      consumables = [];
      purchasePending = false;
      loading = false;
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      queryProductError = null;
      isAvailable = isAvailableStore;
      products = productDetailResponse.productDetails;
      purchases = [];
      notFoundIds = productDetailResponse.notFoundIDs;
      consumables = [];
      purchasePending = false;
      loading = false;
      return;
    }

    List<String> consumableProd = await ConsumableStore.load();
    isAvailable = isAvailableStore;
    products = productDetailResponse.productDetails;
    notFoundIds = productDetailResponse.notFoundIDs;
    consumables = consumableProd;
    purchasePending = false;
    loading = false;
    update();
  }

  Future<void> consume(String id) async {
    await ConsumableStore(sharedPreferences: sharedPreferences).consume(id);
    final List<String> consumableProd = await ConsumableStore.load();
    consumables = consumableProd;
    update();
  }

  void showPendingUI() {
    purchasePending = true;
    update();
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == kConsumableId) {
      await ConsumableStore(sharedPreferences: sharedPreferences)
          .save(purchaseDetails.purchaseID!);
      List<String> consumableProd = await ConsumableStore.load();
      purchasePending = false;
      consumables = consumableProd;
    } else {
      purchases.add(purchaseDetails);
      purchasePending = false;
    }
    update();
  }

  void handleError(IAPError error) {
    purchasePending = false;
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  void listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
            print("In Listen purchess ====  = = = = ${purchaseDetails.status}");
            // if(isPrimumScreen){
            //   removeAds= true;   Get.offAll(HomeScreen());
            // }
              Utility.isSubscribe = true;
            if(purchaseDetails.status == PurchaseStatus.purchased){
              Utility.isSubscribe = true;
              removeAds= true;   Get.offAll(const DashBoard());
            }
            if(purchaseDetails.status == PurchaseStatus.restored){
              Utility.isSubscribe = true;
              removeAds= true;
            }
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!kAutoConsume && purchaseDetails.productID == kConsumableId) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
            inAppPurchase.getPlatformAddition<
                InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          if(purchaseDetails.status == PurchaseStatus.canceled){
            Get.back();
          }
          await inAppPurchase.completePurchase(purchaseDetails);
          print("Purchess sucsessfuly");


          // if (purchaseDetails.productID == 'consumable_product') {
          //   print('================================You got coins');
          // }

          // verifyPreviousPurchases();
        }
      }
    });
  }

  // Future<void> confirmPriceChange(BuildContext context) async {
  //   if (Platform.isAndroid) {
  //     final InAppPurchaseAndroidPlatformAddition androidAddition = inAppPurchase
  //         .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
  //     var priceChangeConfirmationResult =
  //     await androidAddition.launchPriceChangeConfirmationFlow(
  //       sku: 'purchaseId',
  //     );
  //     if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
  //       Get.showSnackbar(const GetSnackBar(
  //         titleText: Text('Price change accepted'),
  //       ));
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text(
  //           priceChangeConfirmationResult.debugMessage ??
  //               "Price change failed with code ${priceChangeConfirmationResult.responseCode}",
  //         ),
  //       ));
  //     }
  //   }
  // }

  GooglePlayPurchaseDetails? getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    GooglePlayPurchaseDetails? oldSubscription;
    if (productDetails.id == kSilverSubscriptionId &&
        purchases[kGoldSubscriptionId] != null) {
      oldSubscription =
      purchases[kGoldSubscriptionId] as GooglePlayPurchaseDetails;
    } else if (productDetails.id == kGoldSubscriptionId &&
        purchases[kSilverSubscriptionId] != null) {
      oldSubscription =
      purchases[kSilverSubscriptionId] as GooglePlayPurchaseDetails;
    }
    return oldSubscription;
  }

  void changeScreen() {
    isPrimumScreen = true;

  }

  void changeIndex(int index) {
    select = index;
  }
}
