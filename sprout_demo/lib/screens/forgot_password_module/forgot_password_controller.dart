import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_project_setup/constants/app.export.dart';
import 'package:new_project_setup/screens/forgot_pass_otp_module/forgot_pass_otp_view.dart';

class ForgotPasswordController extends GetxController {
  TabController? tabController;

  TextEditingController phoneCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  String countryCodeText = "91";

  getCountryData(Country country) {
    countryCodeText = country.phoneCode;
    update();
  }

  getForgotPasswordFunc({
    required String countryCode,
    required String phone,
    required String email,
    required String role,
    required String type,
    
  
  }) async {
    http.Response response = await http.post(
      Uri.parse("https://uniqual.dev:3322/api/v1/forgot-password"),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "countryCode": countryCode,
        "phone": phone,
        "email": email,
        "role": role,
        "type": type,
      }),
    );
    
    
    try{
      if(response.statusCode == 200)
        {
          Get.off(()=> ForgotOtpView(loginType: type, email: email, role: role, countryCode: countryCodeText,) );
          Utils.showInfoToast("Please check your email inbox. We sent you an email on OTP");
        }
      if(response.statusCode == 404)
        {
          Utils.showInfoToast("User not found");
        }
      else{
        print(response.statusCode);
      }
    }catch(e){
      throw"Error $e";
    }
  }
}
