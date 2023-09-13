



import 'package:get/get.dart';

import '../../constants/injector.dart';
import '../../constants/pref_keys.dart';
import '../intro_module/intro_view.dart';

class HomeController extends GetxController{

  isLogOut()async{
    await Injector.prefs!.remove(PrefKeys.accessToken);
    Get.offAll(() => IntroView());
    update();
  }
}