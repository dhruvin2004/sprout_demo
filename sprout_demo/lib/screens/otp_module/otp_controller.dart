import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:new_project_setup/screens/home_module/home_view.dart';

import '../../constants/app.export.dart';
import '../set_up_module/set_up_view.dart';

class OtpController extends GetxController {


  String? otp;
  TextEditingController otpController = TextEditingController();

  bool isTrue = false;

  buttonUpdate(String value) {
    otp = value;
    update();
  }

  Otp({required String code}) {
    otp = code;
    update();
  }




  getOtp({required bool isTrue,required String verificationCode, required String type,required String token}) async {
    http.Response response = await http.post(
      Uri.parse(
          "https://uniqual.dev:3322/api/v1/email/verification/verify-otp"),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({"verificationCode": verificationCode, "type": type}),
    );

    try {
      if (response.statusCode == 200) {
        if(isTrue){
            Get.off(() => HomeView());
          Utils.showSuccessToast("LogIn Successfully");
          Injector.setAccessToken(token);
        }
        else{
          Get.off(() => SetUpView(),);
          Injector.setAccessToken(token);
          Injector.setUpToken(token);
        }
      } else if (response.statusCode == 404) {
        Utils.showInfoToast("Invalid Otp");
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      throw "Error $e";
    }
  }

  getResend({required String token}) async {
    http.Response response = await http.get(
      Uri.parse("https://uniqual.dev:3322/api/v1/email/verification/resend"),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    try {
      if (response.statusCode == 200) {
        otp = "";
        otpController.clear();
        Utils.showInfoToast(
            "Please check verification code that has just been sent to your email account to verify your email");
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      throw "Error $e";
    }
  }
}
