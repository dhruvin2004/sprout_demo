import 'dart:io';
import 'dart:ui';

import 'package:image_picker/image_picker.dart';
import 'package:new_project_setup/base_class/base_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import 'app.export.dart';

class Utils {
  static DateTime selectedDate = DateTime.now();
  static DateTime? startDate;
  static DateTime? endDate;
  static final ImagePicker _picker = ImagePicker();


  static double getScreenWidth(BuildContext context) {
    return Get.width;
  }

  static double getScreenHeight(BuildContext context) {
    return Get.height;
  }

  static getAssetsImg(String name) {
    return "assets/images/" + name + ".png";
  }
  static getAssetsIcon(String name) {
    return "assets/icons/" + name + ".png";
  }

  static getAssetsSVGImg(String name) {
    return "assets/images/" + name + ".svg";
  }

  static getLogoImage(BuildContext context) {
    return Image.asset(
      getAssetsImg("ic_logo"),
      height: getScreenHeight(context) * 0.3,
      width: getScreenWidth(context),
    );
  }

  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static dynamic getSize(double px) {
    if (Utils.key.currentState != null) {
      return px * (MathUtilities.screenWidth(Utils.key.currentState!.overlay!.context) / 414);
    } else {
      return px;
    }
  }

  static dynamic getFontSize(double px) {
    if (Utils.key.currentState != null) {
      return px * (MathUtilities.screenWidth(Utils.key.currentState!.overlay!.context) / 414) + 2;
    } else {
      return px;
    }
  }

  static dynamic getPercentageWidth(double percentage) {
    if (Utils.key.currentState != null) {
      return MathUtilities.screenWidth(Utils.key.currentState!.overlay!.context) * percentage / 100;
    } else {
      return percentage;
    }
  }

  static Future<bool> isInternetConnected() async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (kDebugMode) {
          print("Internet Connected");
        }
        isConnected = true;
      }
    } on SocketException catch (_) {
      if (kDebugMode) {
        print("Internet Not Connected");
      }
      isConnected = false;
    }
    return isConnected;
  }

  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static showToast(String? message) {
    if (message != null && message != "") {
      Fluttertoast.showToast(
          msg: message, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 3, gravity: ToastGravity.BOTTOM, backgroundColor: ColorRes.blackColor, textColor: Colors.white);
    }
  }

  static showInfoToast(String? message) {
    if (message != null && message != "") {
      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 3, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.blue, textColor: Colors.white);
    }
  }

  static showErrToast(String? message) {
    if (message != null && message != "") {
      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 3, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.redAccent, textColor: Colors.white);
    }
  }

  static showSuccessToast(String? message) {
    if (message != null && message != "") {
      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 3, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.green, textColor: Colors.white);
    }
  }

  static showNormalToast(String? message) {
    if (message != null && message != "") {
      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 3, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.green, textColor: Colors.white);
    }
  }

  static bool validatePassword(String value) {
    String pattern = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,30}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool validateName(String value) {
    //Alphanumeric characters
    String pattern = r'^[A-Za-z][A-Za-z0-9]*$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static String? validateEmail(String value) {
    //Alphanumeric characters
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value) ? null : "Enter valid email.";
    // return regExp.hasMatch(value);
  }

  static String? validateMobileNumber(String value) {
    // String pattern = r'^[0-9]{10}$';
    // RegExp regExp = new RegExp(pattern);
    // return regExp.hasMatch(value) ? null : "Enter valid mobile number.";

    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }

  static showCircularProgressLottie(bool isLoading) {
    AlertDialog dialog = AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      elevation: 0.0,
      content: Container(
          height: 60.0,
          color: Colors.transparent,
          child: Center(
            child: Lottie.asset('assets/lottie/loader.json'),
          )),
    );
    if (!isLoading) {
      Get.back();
    } else {
      Get.dialog(dialog, barrierDismissible: true);
    }
  }

  // static String getDob(DateTime dateTime) {
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  //   return formattedDate;
  // }
  //
  // static String getDobFromString(String date) {
  //   String formattedDate = DateFormat("dd-MM-yyyy").format(DateTime.parse(date));
  //   return formattedDate;
  // }

  static Widget applyShadow({double? left, double? right, Widget? child}) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: left ?? 30, right: right ?? 30, bottom: 13),
      child: Material(
          shadowColor: ColorRes.blackColor,
          // added
          color: ColorRes.blackColor,
          type: MaterialType.card,
          elevation: 5,
          borderRadius: BorderRadius.circular(50.0),
          child: child),
    );
  }

  static detailDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        builder: (_) => Center(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: Utils.getSize(17)),
              width: Get.width,
              height: Utils.getSize(260),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Utils.getSize(20), vertical: Utils.getSize(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: Utils.getSize(22),
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                      SizedBox(height: Utils.getSize(10)),
                      Text(text,
                          style: TextStyle(
                            fontSize: Utils.getSize(15),
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          )),
                      SizedBox(height: Utils.getSize(30)),
                      // SizedBox(
                      //     width: Get.width,
                      //     child: raisedButton("Got it !", () {})),
                    ],
                  ),
                ),
              ),
            )));
  }

  static getCacheNetworkImage({required String imageUrl, Widget? placeholderWidget, double? height, BoxFit? fit, double? width}) {
    if ((imageUrl.length) > 0) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
              color: ColorRes.whiteColor,
            )),
        errorWidget: (context, url, error) => placeholderWidget!,
      );
    } else {
      return placeholderWidget!;
    }
  }

  static showConfirmDialog({Function? success, Function? failure, String? positiveTitle, String? negativeTitle, String? title, String? desc}) {
    Get.dialog(
        Center(
          // Aligns the container to center
            child: SizedBox(
              // A simplified version of dialog.
              width: Get.width * 0.9,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: ColorRes.whiteColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: BaseText(
                        text: title ?? "",
                        color: ColorRes.blackColor,
                        textAlign: TextAlign.start,
                        fontSize: Utils.getFontSize(22),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 20),
                      child: BaseText(
                        text: desc ?? "areYouSure",
                        color: ColorRes.blackColor,
                        textAlign: TextAlign.start,
                        fontSize: Utils.getFontSize(17),
                      ),
                    ),
                    Divider(thickness: 0.5, color: ColorRes.textGreyColor, height: 1),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          BaseRaisedButton(
                              textColor: ColorRes.whiteColor,
                              onPressed: () async {
                                if (success != null) {
                                  success();
                                }
                                Get.back();
                              },
                              buttonText : positiveTitle ?? "Yes",
                          ),
                          BaseRaisedButton(
                              onPressed: () {
                                if (failure != null) {
                                  failure();
                                }
                                Get.back();
                              },
                              buttonText: negativeTitle ?? "Cancel",
                              textColor: ColorRes.blackColor,
                             buttonColor: MaterialStateProperty.all(ColorRes.whiteColor),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  static performLogout() async {
    String deviceId = await Injector.getDeviceId();
    // CommonResponse? commonResponse = await DataSource.instance.logout({"device_id": deviceId});
    Injector.prefs?.clear();
    // Get.offAll(const ());
  }

  // static performRefreshToken() async {
  //   String? refreshToken = Injector.prefs!.getString(PrefKeys.refreshToken);
  //   if (refreshToken != null && refreshToken != "") {
  //     CommonResponse? commonResponse = await DataSource.instance.refreshYourToken(
  //       // {
  //       //   "refresh_token":
  //       //       "def50200a2149e208a86d7cd490bdfa1ed0058001d36ee26381a028de37aa45ecbc5ac55a65f2c973abe750c037130d1c91043a1af24a9e323f6cf6f45e2e4aa6b16eb7664337b9b17ad69ee2b9e3032ac3a327c2d8c053f3bc5bdef508229221930b1121416e1a2583941c78063a8c0043108f44223f570cf3965e44b3170d1b70a61653c15c08e47350d699e319e2884c963417e3936e37eac5d81fe11ed97d511cc924a93efc5d14225bd4a71237c88bde8d7ac80086214f8e2fd88bd2c37b9e36518ea3778b4b3bd4d26b501b71aff1e73316ead81c8fa95a8717cb6d97d2489ee097b634edc44c171a83f8f0546fcf6bac9772862315d67035842ff8bd4384a26f652aade77242ae27db381a3295bbd5b543421cbf59c50b9eef1daf8a5df9f5f518cfb3376ad83110e84561a7fdc3e1f1fb50246b5d2083c3d4e33d635bf7554c12d2a77b7f6268ebfb40a553fce3b7d288fd9ded376e19a791174b5d14e4ac4cf9b"
  //       // },
  //       {"refresh_token": refreshToken},
  //     );
  //     if (commonResponse != null && commonResponse.data != null) {
  //       RefreshToken tokens = RefreshToken.fromJson(commonResponse.data);
  //       // print("========= USER ACCESS TOKEN AFTER REFRESH TOKEN API ========== ${tokens.accessToken}");
  //       // print("========= USER REFRESH TOKEN AFTER REFRESH TOKEN API ========== ${tokens.refreshToken}");
  //       await Injector.prefs!.setString(PrefKeys.token, tokens.accessToken!);
  //       await Injector.prefs!.setString(PrefKeys.refreshToken, tokens.refreshToken!);
  //     } else {
  //       // Injector.prefs?.clear();
  //       // Get.offAll(const LoginPage());
  //     }
  //   }
  // }

  static formatDate(DateTime selectedDate) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    return formattedDate;
  }

  static transitionWithTo(dynamic page, {dynamic argument}) {
    if (kDebugMode) {
      print("IN TO FUNCTION UTILS");
    }
    Get.to(page,
        transition: Transition.fadeIn, // choose your page transition accordingly
        duration: const Duration(milliseconds: 300),
        arguments: argument);
  }

  static getImageSelectionBottomSheet(Function successCallBack) {
    Get.bottomSheet(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: ColorRes.transparentColor,
          margin: EdgeInsets.symmetric(horizontal: Utils.getSize(28), vertical: Utils.getSize(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x28000000),
                      blurRadius: 18,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: ColorRes.whiteColor,
                ),
                child: Column(
                  children: [
                    InkResponse(
                      onTap: () {
                        selectImageFromGallery(successCallBack);
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Utils.getSize(20), bottom: Utils.getSize(15)),
                        child: Center(
                          child: BaseText(
                            text: "Gallery",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: ColorRes.blackColor,
                          ),
                        ),
                      ),
                    ),
                    Divider(color: ColorRes.textGreyColor,),
                    InkResponse(
                      onTap: () {
                        selectImageFromCamera(successCallBack);
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Utils.getSize(15), bottom: Utils.getSize(20)),
                        child: Center(
                          child: BaseText(
                            text: "Camera",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: ColorRes.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Utils.getSize(20)),
              InkResponse(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x28000000),
                        blurRadius: 18,
                        offset: Offset(0, 4),
                      ),
                    ],
                    color: ColorRes.whiteColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: Utils.getSize(20)),
                      BaseText(
                        text: "Cancel",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: ColorRes.redColor,
                      ),
                      SizedBox(height: Utils.getSize(20)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  static selectImageFromGallery(Function successCallBack) async {
    XFile? temp;
    temp = await _picker.pickImage(source: ImageSource.gallery);
    if (temp != null && temp.path.isNotEmpty) {
      if(successCallBack != null) {
        successCallBack(temp);
      }
    }
    // print(image!.path);
  }

  static selectImageFromCamera(Function successCallBack) async {
    XFile? temp;
    temp = await _picker.pickImage(source: ImageSource.camera);
    if (temp != null && temp.path.isNotEmpty) {
      if(successCallBack != null) {
        successCallBack(temp);
      }
    }
  }

  static transitionWithOffAll(dynamic page, {dynamic argument}) {
    if (kDebugMode) {
      print("IN OFF ALL FUNCTION UTILS");
    }
    Get.offAll(
      page, transition: Transition.fadeIn, // choose your page transition accordingly
      duration: const Duration(milliseconds: 300),
      arguments: argument,
    );
  }
}

class MathUtilities {
  static screenWidth(BuildContext context) => Get.width;

  static screenHeight(BuildContext context) => Get.height;

  static safeAreaTopHeight(BuildContext context) => MediaQuery.of(context).padding.top;

  static safeAreaBottomHeight(BuildContext context) => MediaQuery.of(context).padding.bottom;
}
