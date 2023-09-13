import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../constants/app.export.dart';
import '../constants/injector.dart';
import '../constants/pref_keys.dart';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

class PushNotificationHelper {
  String? token;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String? deviceId;

  PushNotificationHelper();

  final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

  final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print('Handling a background message ${message.notification}');
    print('Handling a background data ${message.data}');
  }

  Future initPush({bool isOnlyForFCMToken = false}) async {
    if (isOnlyForFCMToken) {
      token = (await Injector.firebaseMessaging?.getToken().catchError((e) {
        if (kDebugMode) {
          print(e);
        }
      }));
      if (kDebugMode) {
        print("======----- TOKEN FOR DEVICE $token");
      }

      if (token != null) {
        try {
          if (Platform.isAndroid) {
            await deviceInfoPlugin.androidInfo.then((value) => deviceId = value.id);
          } else if (Platform.isIOS) {
            await deviceInfoPlugin.iosInfo.then((value) => deviceId = value.identifierForVendor);
          }
          await Injector.setDeviceId(deviceId!);
        } on PlatformException {}
        if (Injector.prefs?.getString(PrefKeys.accessToken) != null) {
          callRegisterForPush(token!, deviceId!);
        }
      }
    } else {
      if (!Platform.isAndroid) await _requestPermissions();
      token = (await Injector.firebaseMessaging?.getToken().catchError((e) {
        if (kDebugMode) {
          print(e);
        }
      }));
      if (kDebugMode) {
        print("======----- TOKEN FOR DEVICE $token");
      }

      if (token != null) {
        try {
          if (Platform.isAndroid) {
            await deviceInfoPlugin.androidInfo.then((value) => deviceId = value.id);
          } else if (Platform.isIOS) {
            await deviceInfoPlugin.iosInfo.then((value) => deviceId = value.identifierForVendor);
          }
          await Injector.setDeviceId(deviceId!);
        } on PlatformException {}
        if (Injector.prefs?.getString(PrefKeys.accessToken) != null) {
          callRegisterForPush(token!, deviceId!);
        }
      }

      _configureSelectNotificationSubject();

      await _configureLocalTimeZone();
      await firebaseCloudMessagingListeners();

      final NotificationAppLaunchDetails? notificationAppLaunchDetails = await Injector.flutterLocalNotificationsPlugin!.getNotificationAppLaunchDetails();

      const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

      /// Note: permissions aren't requested here just to demonstrate that can be
      /// done later
      final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
            didReceiveLocalNotificationSubject.add(ReceivedNotification(id: id, title: title!, body: body!, payload: payload!));
          });
      const DarwinInitializationSettings initializationSettingsMacOS =
      DarwinInitializationSettings(requestAlertPermission: false, requestBadgePermission: false, requestSoundPermission: false);
      final InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: initializationSettingsMacOS);
      await Injector.flutterLocalNotificationsPlugin!.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        final String? payload = notificationResponse.payload;
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        selectNotificationSubject.add(payload!);
      }).then((value) => print("value====${value.toString()}"));
    }
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    if (kDebugMode) {
      print(tz.getLocation('Asia/Kolkata'));
    }
  }

  _requestPermissions() async {
    await Injector.firebaseMessaging?.requestPermission();

    Injector.flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    Injector.flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((payload) async {
      if (kDebugMode) {
        print("_configureSelectNotificationSubject====Push notification helper===");
        print(payload);
      }

      ///TODO : Notification redirection
    });
  }

  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      if (kDebugMode) {
        print("myBackgroundMessageHandler data => " + data);
      }
    }

    if (message.containsKey('notificationId')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      if (kDebugMode) {
        print("myBackgroundMessageHandler notification => " + notification);
      }
    }

    // Or do other work.
  }

  firebaseCloudMessagingListeners() async {
    Injector.firebaseMessaging?.getInitialMessage().then((RemoteMessage? message) async {
      if (kDebugMode) {
        print("======-----firebaseCloudMessagingListeners-----======");
        print(message);
      }

      ///TODO : Notification redirection for terminated app
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("======-----FirebaseMessaging.onMessage.listen-----======");

        print(message);
      }
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      if (kDebugMode) {
        print(notification.title);
        print(notification.body);

        print(message.data.toString());
        print(message.data["type"]);
        print(message.data["notificationId"]);
      }

      if (notification != null) {
        showNotification(notification, jsonEncode({"type": message.data["type"], "notificationId": message.data["notificationId"], "referenceId": message.data["referenceId"]}));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("======-----FirebaseMessaging.onMessageOpenedApp.listen-----======");
      RemoteNotification notification = message.notification!;
      print(message.data.toString());
      // print(message.data["type"]);
      // print(message.data["notificationId"]);
      showNotification(notification, jsonEncode({"type": message.data["type"], "notificationId": message.data["notificationId"], "referenceId": message.data["referenceId"]}));

      ///TODO : Notification redirection if app is in background
    });
  }

  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
  }

  // doNotificationRead(int notificationId) async {
  //   CommonResponse commonResponse = await DataSource.instance.readNotificationId(notificationId);
  //   if (commonResponse != null) {}
  // }

  void callRegisterForPush(String token, String deviceId) async {
    await Injector.firebaseMessaging?.getToken().then((token) async {
      // CommonResponse? commonResponse = await DataSource.instance.registerForPush({"device_id": deviceId, "device_type": Platform.isAndroid ? "Android" : "Ios", "token": token});
      // if (commonResponse != null) {
      //   print("---response------------- :::::::::::::::: ----------- token ---------$commonResponse------");
      // }
      if (kDebugMode) {
        print("============= FCM TOKEN =============== $token");
      }
    });
  }

  Future<void> showNotification(RemoteNotification notification, String payLoad) async {
    Injector.notificationID++;
    if (Platform.isAndroid) {
      showLocalNotification(Injector.notificationID, notification.title!, notification.body!, payLoad);
    }
  }

  showLocalNotification(int id, String title, String body, String payLoad) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: "@mipmap/ic_launcher",
    );

    //TODO keep in MIND , add config in AppDelegate.swift to get push in foreground
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails(badgeNumber: 1, presentAlert: true);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await Injector.flutterLocalNotificationsPlugin!.show(id, title, body, platformChannelSpecifics, payload: payLoad).catchError((e) {
      if (kDebugMode) {
        print("===flutterLocalNotificationsPlugin==error==$e");
      }
    }).then((value) {
      if (kDebugMode) {
        print("===flutterLocalNotificationsPlugin==then=}");
      }
    });
  }
}
