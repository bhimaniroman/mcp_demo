// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:mcp_demo/AppAds/utility.dart';
import 'package:mcp_demo/Modules/Screens/Home_Screen/InAppPurchase/sharedPref.dart';
import '../../../../AppData/AppData.dart';
import '../../../../AppData/Images.dart';
import '../../../../Utils/utils.dart';
import 'custom_button.dart';
import 'inAppPurchaseController.dart';

List<ProductDetails>? _items;
List<PurchaseDetails> _purchases = [];
final List<String> _productLists = Platform.isAndroid
    ? [
  'monthly_subscription',
  'yearly_subscription',
]
    : ['iam_monthly', 'iam_annual'];

class SubScription extends StatefulWidget {
  const SubScription({super.key});

  @override
  State<SubScription> createState() => _SubScriptionState();
}

class _SubScriptionState extends State<SubScription> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  PrimumController primumController = Get.find();
  final bool _kAutoConsume = Platform.isIOS || true;
  String _kConsumableId = 'consumable';
  bool _isAvailable = false;
  List<String> _consumables = <String>[];
  bool _purchasePending = false;
  String? _queryProductError;
  int currentIndex = -1;
  bool isSelected = true;
  bool isSelected1 = false;
  bool secondrayColor = false;

  ProductDetails? productdetails;

  var ls = [
    (Utility.premium[0].product_feature_one),
    (Utility.premium[0].product_feature_two),
    (Utility.premium[0].product_feature_three),
    (Utility.premium[0].product_feature_four),
  ];

  var ls1 = [
    '\$1.99 Monthly',
    '\$9.99 Annually',
  ];

  @override
  void initState() {
    super.initState();
    Get.find<PrimumController>().changeScreen();
    initStoreData();
  }

  Future<void> initStoreData() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _items = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];

        _consumables = <String>[];
        _purchasePending = false;
        // _loading = false;
      });
      return;
    }
    final ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(_productLists.toSet());

    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _items = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];

        _consumables = <String>[];
        _purchasePending = false;
        // _loading = false;
      });
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _items = productDetailResponse.productDetails;
      if(Platform.isAndroid){
        productdetails = _items?[1];
        isSelected1 = true;
      }
      _consumables = consumables;
      _purchasePending = false;
      // _loading = false;
    });

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _items = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];

        _consumables = <String>[];
        _purchasePending = false;
        // _loading = false;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, PurchaseDetails> purchases = Map<String, PurchaseDetails>.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: GetBuilder<PrimumController>(builder: (subscriptionController) {
            return Stack(
              children: [
                Container(
                  height: 250,
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        textcolor,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: textcolor,
                      size: 30,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 190),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(Images.DiamondImage),
                        height: 100,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 290.0, horizontal: 36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Unlock Everything',
                            style: GoogleFonts.poppins(fontSize: 30, color: textcolor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 320, left: 15),
                  child: ListView.builder(
                    shrinkWrap: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ls.length,
                    itemExtent: 45,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(
                          Icons.file_download_done,
                        ),
                        title: Text(
                          ls[index].toString(),
                          style: GoogleFonts.poppins(fontSize: 15, color: textcolor),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 350),
                  child: ListTile(
                    title: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (Platform.isAndroid) ...{
                            if (productdetails?.id == null) ...[
                              Text(
                                '${_items?[1].price ?? "----"} Annually',
                                style: GoogleFonts.poppins(fontSize: 13, color: textcolor, fontWeight: FontWeight.bold),
                              ),
                            ] else ...[
                              if (productdetails?.id == 'yearly_subscription') ...[
                                Text(
                                  "${productdetails?.price.toString()} Annually",
                                  style: GoogleFonts.poppins(fontSize: 13, color: textcolor, fontWeight: FontWeight.bold),
                                ),
                              ] else ...[
                                Text(
                                  "${productdetails?.price.toString()} Monthly",
                                  style: GoogleFonts.poppins(fontSize: 13, color: textcolor, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ],
                          } else ...{
                            if (productdetails?.id == null) ...[
                              Text(
                                '${_items?[0].price ?? "----"} Annually',
                                style: GoogleFonts.poppins(fontSize: 13, color: textcolor, fontWeight: FontWeight.bold),
                              ),
                            ] else ...[
                              if (productdetails?.id == 'iam_annual') ...[
                                Text(
                                  "${productdetails?.price.toString()} Annually",
                                  style: GoogleFonts.poppins(fontSize: 13, color: textcolor, fontWeight: FontWeight.bold),
                                ),
                              ] else ...[
                                Text(
                                  "${productdetails?.price.toString()} Monthly",
                                  style: GoogleFonts.poppins(fontSize: 13, color: textcolor, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ],
                          }
                        ],
                      ),
                    ),
                  ),
                ),
                if (productdetails?.id == null) ...{
                  Padding(
                    padding: const EdgeInsets.only(top: 400),
                    child: ListTile(
                      subtitle: Center(
                        child: Text(
                          Utility.premium[1].product_offer,
                          style: GoogleFonts.poppins(fontSize: 10, color: textcolor),
                        ),
                      ),
                    ),
                  ),
                } else if (productdetails?.id == 'iam_annual' || productdetails?.id == 'yearly_subscription') ...{
                  Padding(
                    padding: const EdgeInsets.only(top: 400),
                    child: ListTile(
                      subtitle: Center(
                        child: Text(
                          Utility.premium[1].product_offer,
                          style: GoogleFonts.poppins(fontSize: 10, color: textcolor),
                        ),
                      ),
                    ),
                  ),
                } else ...{
                  Padding(
                    padding: const EdgeInsets.only(top: 400),
                    child: ListTile(
                      subtitle: Center(
                        child: Text(
                          Utility.premium[0].product_offer,
                          style: GoogleFonts.poppins(fontSize: 10, color: textcolor),
                        ),
                      ),
                    ),
                  ),
                },
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.7),
                  child: CustomButton(
                      onPressed: () {
                        late PurchaseParam purchaseParam;
                        if (Platform.isAndroid) {
                          primumController.changeIndex(currentIndex);
                          final GooglePlayPurchaseDetails? oldSubscription = primumController.getOldSubscription(
                              isSelected1
                                  ? productdetails!
                                  : ProductDetails(
                                id: _items?[1].id ?? "",
                                title: _items?[1].title ?? "",
                                description: _items?[1].description ?? "",
                                price: _items?[1].price ?? "",
                                rawPrice: _items?[1].rawPrice ?? 00,
                                currencyCode: _items?[1].currencyCode ?? "",
                              ),
                              purchases);

                          purchaseParam = GooglePlayPurchaseParam(
                              productDetails: isSelected1
                                  ? productdetails!
                                  : ProductDetails(
                                id: _items?[1].id ?? "",
                                title: _items?[1].title ?? "",
                                description: _items?[1].description ?? "",
                                price: _items?[1].price ?? "",
                                rawPrice: _items?[1].rawPrice ?? 00,
                                currencyCode: _items?[1].currencyCode ?? "",
                              ),
                              changeSubscriptionParam: (oldSubscription != null)
                                  ? ChangeSubscriptionParam(
                                oldPurchaseDetails: oldSubscription,
                                prorationMode: ProrationMode.immediateWithTimeProration,
                              )
                                  : null);
                        } else {
                          Utills.lodaingDailog(context);
                          purchaseParam = PurchaseParam(
                            productDetails: isSelected1
                                ? productdetails!
                                : ProductDetails(
                                id: Utility.premium[1].product_sku,
                                title: Utility.premium[1].product_offer,
                                description: Utility.premium[1].product_feature_two,
                                price: Utility.premium[1].product_price,
                                rawPrice: 999.00,
                                currencyCode: Utility.premium[1].product_offer),
                          );
                        }

                        if (Utility.premium[1].product_sku == _kConsumableId) {
                          _inAppPurchase.buyConsumable(purchaseParam: purchaseParam, autoConsume: _kAutoConsume);
                        } else {
                          _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
                        }
                      },
                      buttonText: "Start Trial"),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Restore',
                              style: TextStyle(color: textcolor),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Terms of Use',
                              style: TextStyle(color: textcolor),
                            )),
                        TextButton(
                            onPressed: () {
                              Get.bottomSheet(
                                Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(35), topLeft: Radius.circular(35)),
                                      color: Colors.black,
                                    ),
                                    height: MediaQuery.of(context).size.height,
                                    child: Column(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20),
                                              child: Center(
                                                  child: Text(
                                                    'Select a Plan',
                                                    style: TextStyle(color: fontcolor, fontSize: 20),
                                                  )),
                                            ),
                                            Visibility(
                                              visible: _items?.isNotEmpty ?? false,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: _items?.length,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets.only(top: 20.0),
                                                    child: Container(
                                                      height: 100,
                                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                                      width: Get.size.width,
                                                      decoration: BoxDecoration(
                                                        color: Get.theme.highlightColor,
                                                        gradient: currentIndex == index ? gradient : null,
                                                        borderRadius: BorderRadius.circular(16),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(2),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            productdetails = _items?[index];
                                                            isSelected1 = true;
                                                            if (_items?[index].id == 'monthly_subscription' || _items?[index].id == 'iam_monthly') {
                                                              secondrayColor = true;
                                                            } else {
                                                              secondrayColor = false;
                                                            }
                                                            currentIndex = index;
                                                            setState(() {});
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                            height: 80,
                                                            decoration: BoxDecoration(color: Get.theme.backgroundColor, borderRadius: BorderRadius.circular(16)),
                                                            child: Container(
                                                              height: 80,
                                                              width: Get.size.width,
                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                              decoration: BoxDecoration(
                                                                gradient: LinearGradient(colors: [
                                                                  if (_items?[index].id == 'yearly_subscription' || _items?[index].id == 'iam_annual') ...[
                                                                    if (isSelected == true && secondrayColor == false) ...{
                                                                      Colors.purple, Colors.blueAccent,
                                                                    } else ...{
                                                                      Colors.black,
                                                                      Colors.black87
                                                                    }
                                                                  ] else ...[
                                                                    if (isSelected == true && secondrayColor == true) ...{
                                                                      Colors.purple, Colors.blueAccent,
                                                                    } else ...{
                                                                      Colors.black,
                                                                      Colors.black87
                                                                    }
                                                                  ]
                                                                ]),
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(top: 8.0),
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        if (_items?[index].id == 'monthly_subscription' || _items?[index].id == 'iam_monthly') ...{
                                                                          SizedBox(
                                                                            width: Get.width * 0.45,
                                                                            child: Text(
                                                                              _items?[index].title ?? "",
                                                                              maxLines: 1,
                                                                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: fontcolor),
                                                                            ),
                                                                          ),
                                                                        } else ...{
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                                'Annually',
                                                                                style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.bold, color: fontcolor),
                                                                              ),
                                                                              SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.25,
                                                                              ),
                                                                              Text(
                                                                                'Great Deal',
                                                                                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: fontcolor),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        },
                                                                        Text(
                                                                          _items?[index].price ?? "",
                                                                          style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
                                                                        ),
                                                                        if (Platform.isAndroid) ...{
                                                                          if (_items?[index].id == 'monthly_subscription') ...{
                                                                            Text(
                                                                              Utility.premium[0].product_offer,
                                                                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
                                                                            )
                                                                          } else ...{
                                                                            Text(
                                                                              Utility.premium[1].product_offer,
                                                                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
                                                                            )
                                                                          }
                                                                        } else ...{
                                                                          if (_items?[index].id == 'iam_monthly') ...{
                                                                            Text(
                                                                              Utility.premium[0].product_offer,
                                                                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
                                                                            )
                                                                          } else ...{
                                                                            Text(
                                                                              Utility.premium[1].product_offer,
                                                                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
                                                                            )
                                                                          }
                                                                        },
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Visibility(
                                              visible: _items?.isEmpty ?? false,
                                              child: const Center(
                                                child: CupertinoActivityIndicator(),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                                barrierColor: Colors.black38,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35), side: const BorderSide(width: 5, color: Colors.black)),
                                enableDrag: true,
                              );
                            },
                            child: Text(
                              'Other Options',
                              style: TextStyle(color: textcolor),
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class SubscriptionDetails {
  Color color;
  String image;
  String title;
  String subTitle;
  String prise;

  SubscriptionDetails({required this.color, required this.image, required this.title, required this.subTitle, required this.prise});
}
