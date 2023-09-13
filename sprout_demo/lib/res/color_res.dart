
import 'dart:ui';

import '../constants/app.export.dart';

class ColorRes {
  static final ColorRes _singleton = ColorRes._internal();

  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color blackColor = const Color(0xFF000000);
  static Color primaryColor = const Color(0xFF1A1A54);
  static Color primaryColorLight = const Color(0xFF7888DB);
  static Color primaryColorLight02 = const Color(0xFF5A5AB2);
  static Color disableTextColor = const Color(0xFF8A8A8D);
  static Color textGreyColor = const Color(0xFFFAAAAAA);
  static Color transparentColor = Colors.transparent;
  static Color redColor = const Color(0xFFDF3B62);
  static Color gradiantPrimaryColor = const Color(0xFFA5B3FE);
  static Color gradiantPrimaryColorLight = const Color(0xFFD0D8FF);
  static Color gradiantPrimaryColorLight02 = const Color(0xFF97A4ED);
  static Color gradiantPrimaryColorLight03 = const Color(0xFF95A5FA);
  static Color gradiantTextColor = const Color(0xFF6666AE);

  factory ColorRes() {
    return _singleton;
  }

  ColorRes._internal();
}

class Palette {
  static MaterialColor primaryMaterialColor = MaterialColor(ColorRes.primaryColor.value, <int, Color>{
    50: ColorRes.primaryColor.withOpacity(0.1), //10%
    100: ColorRes.primaryColor.withOpacity(0.2  ), //20%
    200: ColorRes.primaryColor.withOpacity(0.3), //30%
    300: ColorRes.primaryColor.withOpacity(0.4), //40%
    400: ColorRes.primaryColor.withOpacity(0.5), //50%
    500: ColorRes.primaryColor.withOpacity(0.6), //60%
    600: ColorRes.primaryColor.withOpacity(0.7), //70%
    700: ColorRes.primaryColor.withOpacity(0.8), //80%
    800: ColorRes.primaryColor.withOpacity(0.9), //90%
    900: ColorRes.primaryColor.withOpacity(1.0),//100%
  });
}
