



import 'dart:async';

import 'package:get/get.dart';
import 'package:new_project_setup/constants/pref_keys.dart';
import 'package:new_project_setup/screens/home_module/home_view.dart';
import 'package:new_project_setup/screens/set_up_module/set_up_view.dart';

import '../../constants/injector.dart';
import '../intro_module/intro_view.dart';
import '../login/login_view.dart';

class SplashController extends GetxController{





  @override
  void onInit() {
    // TODO: implement onInit

    Timer(Duration(seconds: 5), () {
      if (Injector.getAccessToken() != null) {
        if(Injector.getSetUpToken() != null)
          {
            Get.off(() => SetUpView());
          }
        else
        {
          Get.off(() => HomeView());
        }
      } else {
        Get.off(() => IntroView());
        Injector.prefs?.remove(PrefKeys.otpAccessToken);
      }
    });
    super.onInit();
  }


}