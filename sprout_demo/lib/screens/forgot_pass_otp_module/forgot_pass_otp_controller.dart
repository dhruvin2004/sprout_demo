


import 'package:get/get.dart';

import '../../constants/app.export.dart';
import 'package:http/http.dart' as http;

import '../create_new_password_module/create_new_password_view.dart';

class ForgotPassOtpController extends GetxController{

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


  getOtp({required String countryCode,required String verificationCode,required String email, required String type,required String role}) async {
    http.Response response = await http.post(
      Uri.parse(
          "https://uniqual.dev:3322/api/v1/forgot-password/verify-otp"),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer ${Injector.getOtpAccessToken()}',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "email": email,
        "role": role,
        "type": type,
        "otp": verificationCode}),
    );

    try {
      if (response.statusCode == 200) {
        Get.off(() => CreateNewPasswordView(
          type: type,
          countryCode: "+${countryCode}",
          emailOrPassword: email,
          role: role,
        ));
        Utils.showSuccessToast("LogIn Successfully");
       // Injector.setAccessToken(Injector.getOtpAccessToken());
      } else if (response.statusCode == 404) {
        Utils.showInfoToast("Invalid Otp");
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      throw "Error $e";
    }
  }

  getResend() async {
    http.Response response = await http.get(
      Uri.parse("https://uniqual.dev:3322/api/v1/email/verification/resend"),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer ${Injector.getOtpAccessToken()}',
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