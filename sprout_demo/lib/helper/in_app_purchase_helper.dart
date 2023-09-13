// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:basic_setup/common_class/utils.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:in_app_purchase_android/billing_client_wrappers.dart';
// import 'package:in_app_purchase_android/in_app_purchase_android.dart';
//
// class InAppPurchaseHelper extends StatefulWidget {
//   @override
//   InAppPurchaseHelperState createState() => InAppPurchaseHelperState();
// }
//
// class InAppPurchaseHelperState extends State<InAppPurchaseHelper> {
//   final InAppPurchase _inAppPurchase = InAppPurchase.instance;
//   StreamSubscription<List<PurchaseDetails>>? _subscription;
//   List<ProductDetails> _products = [];
//   List<PurchaseDetails> _purchases = [];
//   PurchaseDetails? purchasedProduct;
//   List<String> _notFoundIds = [];
//   bool _isAvailable = false;
//   bool _purchasePending = false;
//   bool _loading = true;
//   String? _queryProductError;
//   var subscriptioModel;
//   // List<SubscriptionPlanModel> allBuyListing = [];
//   List<String> _productLists = [];
//
//   @override
//   void initState() {
//     init();
//     super.initState();
//   }
//
//   /// get products from api
//   Future<void> getProductsApi() async {
//     final bool available = await InAppPurchase.instance.isAvailable();
//     // TODO : Call Fetch Products Api
//     if ((_productLists?.length ?? 0) > 0) {
//       print(_productLists);
//       await initStoreInfo();
//     }
//   }
//
//   void init() async {
//     final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
//     _subscription = purchaseUpdated.listen((purchaseDetailsList) {
//       _listenToPurchaseUpdated(purchaseDetailsList);
//     }, onDone: () {
//       _subscription.cancel();
//     }, onError: (error) {
//       Utils.showErrToast("Something went wrong");
//     });
//     await getProductsApi();
//   }
//
//   Future<void> initStoreInfo() async {
//     final bool isAvailable = await _inAppPurchase.isAvailable();
//     if (!isAvailable) {
//       setState(() {
//         _isAvailable = isAvailable;
//         _products = [];
//         _purchases = [];
//         _notFoundIds = [];
//         _purchasePending = false;
//         _loading = false;
//       });
//       return;
//     }
//
//     ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(_productLists.toSet());
//     if (productDetailResponse.error != null) {
//       setState(() {
//         _queryProductError = productDetailResponse.error.message;
//         _isAvailable = isAvailable;
//         _products = productDetailResponse.productDetails;
//         _purchases = [];
//         _notFoundIds = productDetailResponse.notFoundIDs;
//         // _consumables = [];
//         _purchasePending = false;
//         _loading = false;
//       });
//       return;
//     }
//
//     if (productDetailResponse.productDetails.isEmpty) {
//       setState(() {
//         _queryProductError = null;
//         _isAvailable = isAvailable;
//         _products = productDetailResponse.productDetails;
//         _purchases = [];
//         _notFoundIds = productDetailResponse.notFoundIDs;
//         _purchasePending = false;
//         _loading = false;
//       });
//       return;
//     }
//
//     // List<String> consumables = await ConsumableStore.load();
//     setState(() {
//       _isAvailable = isAvailable;
//       _products = productDetailResponse.productDetails;
//       _notFoundIds = productDetailResponse.notFoundIDs;
//       // _consumables = consumables;
//       _purchasePending = false;
//       _loading = false;
//     });
//   }
//
//   @override
//   void dispose() {
//     if (Platform.isIOS) {
//       var iosPlatformAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseIosPlatformAddition>();
//       iosPlatformAddition.setDelegate(null);
//     }
//     _subscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> stack = [];
//     if (_queryProductError == null) {
//       stack.add(
//         planView(),
//       );
//     } else {
//       stack.add(Center(
//         child: Text(_queryProductError),
//       ));
//     }
//     return Scaffold(
//         backgroundColor: ColorConst.whiteColor,
//         body: Container(
//           child: Text("YOUR WIDGET"),
//         ));
//   }
//
//   //Your plan view to display
//   planView() {
//     var modelForSubscription;
//     if ((modelForSubscription?.length ?? 0) > 0) {
//       if (_loading) {
//         return Card(
//             elevation: 0,
//             child: (ListTile(
//                 leading: CircularProgressIndicator(backgroundColor: ColorConst.blackColor, valueColor: AlwaysStoppedAnimation<Color>(ColorConst.whiteColor)),
//                 title: Text('Fetching products...'))));
//       }
//       return InkResponse(
//         onTap: () {
//           _requestPurchase(modelForSubscription[0]);
//         },
//
//         /// TODO show your plan widget here
//         child: Container(
//           child: Text("YOUR PLAN CHILD"),
//         ),
//       );
//     } else {
//       if (_loading) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: CircularProgressIndicator(
//                 backgroundColor: ColorConst.blackColor,
//                 valueColor: AlwaysStoppedAnimation<Color>(ColorConst.whiteColor),
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Text('Fetching products...'),
//           ],
//         );
//       }
//       return Center(
//           child: BaseText(
//         text: "No Product Found",
//         fontSize: FontConst.font22,
//       ));
//     }
//   }
//
//   void buySubscription(var dataRq) async {
//     /// TODO perform buy product api for our backend
//   }
//
//   void _requestPurchase(String plan) async {
//     print("=======------- PURCHASE DETAIL =======-------- $purchasedProduct");
//     Utils.showCircularProgressLottie(true);
//     Future.delayed(Duration(seconds: 6), () {
//       Utils.showCircularProgressLottie(false);
//     });
//     Map<String, PurchaseDetails> purchases = Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
//       if (purchase.pendingCompletePurchase) {
//         _inAppPurchase.completePurchase(purchase);
//       }
//       return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
//     }));
//     if (purchasedProduct != null) {
//       String? email;
//
//       /// TODO check email associated with account
//       if (email != null) {
//         /// TODO show pop up for email associated with acc
//       } else {
//         if (purchasedProduct != null && purchasedProduct.productID != null) {
//           Map<String, dynamic> rq = {};
//           buySubscription(rq);
//         }
//       }
//     } else {
//       PurchaseParam purchaseParam;
//       if (Platform.isAndroid) {
//         ProductDetails? product;
//         for (int i = 0; i < _products.length; i++) {
//           if (plan.productKey == _products[i].id) {
//             product = _products[i];
//             break;
//           }
//         }
//         PurchaseDetails? previousPurchase = purchases[product!.id];
//         if (product != null) {
//           final oldSubscription = _getOldSubscription(product, purchases, plan.productKey);
//
//           purchaseParam = GooglePlayPurchaseParam(
//               productDetails: product,
//               applicationUserName: null,
//               changeSubscriptionParam: (oldSubscription != null)
//                   ? ChangeSubscriptionParam(
//                       oldPurchaseDetails: oldSubscription,
//                       // prorationMode: ProrationMode
//                       //     .immediateWithTimeProration,
//                     )
//                   : null);
//           bool isPurchase = await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam).then((value) {
//             _inAppPurchase.completePurchase(previousPurchase!);
//             return;
//           });
//           print("=========isPurchse=========$isPurchase");
//         } else {
//           Utils.showErrToast("Product not found.");
//         }
//       } else {
//         ProductDetails? product;
//         for (int i = 0; i < _products.length; i++) {
//           if (plan.productKey == _products[i].id) {
//             product = _products[i];
//             break;
//           }
//         }
//         PurchaseDetails? previousPurchase = purchases[product!.id]!;
//
//         if (product != null) {
//           purchaseParam = PurchaseParam(
//             productDetails: product,
//             applicationUserName: null,
//           );
//
//           bool isPurchase = await _inAppPurchase
//               .buyNonConsumable(
//             purchaseParam: purchaseParam,
//           )
//               .then((value) {
//             _inAppPurchase.completePurchase(previousPurchase);
//             return;
//           });
//           var transactions = await SKPaymentQueueWrapper().transactions();
//           transactions.forEach((skPaymentTransactionWrapper) {
//             SKPaymentQueueWrapper().finishTransaction(skPaymentTransactionWrapper);
//           });
//           print("=========isPurchase=========$isPurchase");
//         } else {
//           Utils.showErrToast("Product not found.");
//         }
//       }
//     }
//   }
//
//   Future<void> consume(String id) async {
//     await ConsumableStore.consume(id);
//     final List<String> consumables = await ConsumableStore.load();
//     setState(() {
//       // _consumables = consumables;
//     });
//   }
//
//   void showPendingUI() {
//     setState(() {
//       _purchasePending = true;
//     });
//   }
//
//   void deliverProduct(PurchaseDetails purchaseDetails) async {
//     // IMPORTANT!! Always verify purchase details before delivering the product.
//     // if (purchaseDetails.productID == _kConsumableId) {
//     //   await ConsumableStore.save(purchaseDetails.purchaseID);
//     //   List<String> consumables = await ConsumableStore.load();
//     //   setState(() {
//     //     _purchasePending = false;
//     //     _consumables = consumables;
//     //   });
//     // } else {
//     setState(() {
//       _purchases.add(purchaseDetails);
//       _purchasePending = false;
//     });
//     // }
//   }
//
//   void handleError(IAPError error) {
//     setState(() {
//       _purchasePending = false;
//     });
//   }
//
//   void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
//     purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
//       if (purchaseDetails.status == PurchaseStatus.pending) {
//         showPendingUI();
//       } else {
//         if (purchaseDetails.status == PurchaseStatus.error) {
//           handleError(purchaseDetails.error!);
//         } else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
//           print("=======------- IN PURCHASED");
//           if (purchaseDetails != null) {
//             checkEmailApi(purchaseDetails);
//           }
//         } else if (purchaseDetails.status == PurchaseStatus.restored) {
//           print("=======------- IN RESTORED");
//           purchasedProduct = purchaseDetails;
//           PurchaseDetails purchasedList;
//           purchasedList = latestPurchasedProduct(purchaseDetailsList);
//           if (Platform.isIOS) {
//             if (purchasedList != null) {
//               checkEmailApi(purchasedList);
//             }
//           } else {
//             verifyReceiptAndBuySubscription(purchasedList);
//           }
//         }
//         if (purchaseDetails.pendingCompletePurchase) {
//           print("=======------- IN COMPLETE PURCHASE");
//           await _inAppPurchase.completePurchase(purchaseDetails);
//         }
//       }
//     });
//   }
//
//   checkEmailApi(PurchaseDetails purchasedList) async {
//     /// TODO check email if no email associated with the purchase then do buy listing for verify purchase
//   }
//
//   verifyReceiptAndBuySubscription(PurchaseDetails purchasedList) async {
//     /// TODO verify purchase by buy listigs
//   }
//
//   PurchaseDetails latestPurchasedProduct(List<PurchaseDetails> details) {
//     PurchaseDetails latestPurchase = details[0];
//     details.forEach((detail) {
//       if (DateTime.fromMicrosecondsSinceEpoch(int.parse(detail.transactionDate! + "000"))
//           .toLocal()
//           .isAfter(DateTime.fromMicrosecondsSinceEpoch(int.parse(latestPurchase.transactionDate! + "000")).toLocal())) {
//         latestPurchase = detail;
//       }
//     });
//     print("====---=-=-====---=---- ${latestPurchase.purchaseID}");
//     return latestPurchase;
//   }
//
//   Future<void> confirmPriceChange(BuildContext context) async {
//     if (Platform.isAndroid) {
//       final InAppPurchaseAndroidPlatformAddition androidAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
//       var priceChangeConfirmationResult = await androidAddition.launchPriceChangeConfirmationFlow(
//         sku: 'purchaseId',
//       );
//       if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Price change accepted'),
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//             priceChangeConfirmationResult.debugMessage ?? "Price change failed with code ${priceChangeConfirmationResult.responseCode}",
//           ),
//         ));
//       }
//     }
//     if (Platform.isIOS) {
//       var iapIosPlatformAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseIosPlatformAddition>();
//       await iapIosPlatformAddition.showPriceConsentIfNeeded();
//     }
//   }
//
//   GooglePlayPurchaseDetails _getOldSubscription(ProductDetails productDetails, Map<String, PurchaseDetails> purchases, String plan) {
//     GooglePlayPurchaseDetails oldSubscription;
//     // if (productDetails.id == plan && purchases[plan] != null) {
//     //   oldSubscription = purchases[plan] as GooglePlayPurchaseDetails;
//     // } else if (productDetails.id == plan && purchases[plan] != null) {
//     //   oldSubscription = purchases[plan] as GooglePlayPurchaseDetails;
//     // }
//     if (purchases[purchasedProduct!.productID] != null && plan != null) {
//       oldSubscription = purchases[purchasedProduct!.productID] as GooglePlayPurchaseDetails;
//     }
//     return oldSubscription;
//   }
// }
//
// // class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
// //   @override
// //   bool shouldContinueTransaction(SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
// //     return true;
// //   }
// //
// //   @override
// //   bool shouldShowPriceConsent() {
// //     return false;
// //   }
// // }
