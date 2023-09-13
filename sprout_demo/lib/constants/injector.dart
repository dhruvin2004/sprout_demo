import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_project_setup/constants/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.export.dart';


class Injector {
  static Injector? _instance;
  static String? email;
  static bool isDarkMode = false;
  static FirebaseMessaging? firebaseMessaging;
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static DeviceInfoPlugin? deviceInfo = DeviceInfoPlugin();
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();


  // static FacebookAuth facebookAuth = FacebookAuth.instance;

  //OBJECTS
  static SharedPreferences? prefs;
  static int? userId;

  // static UserModel? userData;
  static int notificationID = 0;

  factory Injector() {
    return _instance ?? Injector._internal();
  }

  Injector._internal() {
    _instance = this;
  }

  static Injector get shared => Injector();

  static getInstance() async {
    prefs = await SharedPreferences.getInstance();
    flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
    await Firebase.initializeApp();
    firebaseMessaging = FirebaseMessaging.instance;

    // if (prefs.getString(PrefKeys.userData) != null) {
    //   userData = UserModel.fromJson(jsonDecode(prefs.getString(PrefKeys.userData)));
    //   userId = userData.id;
    // }
  }

  // static GoogleSignIn googleSignIn = GoogleSignIn(
  //   scopes: <String>[
  //     'email',
  //     'profile',
  //   ],
  // );

  // static setUserData(UserModel userModel,{bool isFromEditProfile = false}) async {
  //   // update profile ma userdata ma token same j rese but login ma change thay jase e condition add karvani che
  //   if(userData != null && userData?.authentication != null && isFromEditProfile) {
  //     Authentication? auth = userData?.authentication;
  //     userModel.authentication = auth;
  //   }
  //   prefs!.setString(PrefKeys.userData, jsonEncode(userModel.toJson()));
  //   userData = userModel;
  //   userId = userData?.id;
  // }

  // static getUserData() {
  //   return UserModel.fromJson(jsonDecode(prefs.getString(PrefKeys.userData)));
  // }

  static setDeviceId(String id) async {
    prefs!.setString(PrefKeys.deviceId, id);
  }

  static getDeviceId() async {
    return prefs!.getString(PrefKeys.deviceId);
  }

  static setAccessToken(String id) async {
    prefs!.setString(PrefKeys.accessToken, id);
  }

  static setProviderType(String providerType) async {
    prefs!.setString(PrefKeys.providerType, providerType);
  }

  static getProviderType() async {
    return prefs!.getString(PrefKeys.providerType);
  }

  static getAccessToken()  {
    return prefs!.getString(PrefKeys.accessToken);
  }

  static setRefreshToken(String id) async {
    prefs!.setString(PrefKeys.deviceId, id);
  }

  static getRefreshToken() async {
    return prefs!.getString(PrefKeys.deviceId);
  }

  static setOtpAccessToken(String id) async {
    prefs!.setString(PrefKeys.otpAccessToken, id);
  }

  static getOtpAccessToken()  {
    return prefs!.getString(PrefKeys.otpAccessToken);
  }


  static setUpToken(String id) async {
    prefs!.setString(PrefKeys.setUpToken, id);
  }

  static getSetUpToken()  {
    return prefs!.getString(PrefKeys.setUpToken);
  }


}
