
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_setup/constants/app.export.dart';
import 'package:http/http.dart' as http;
import 'package:new_project_setup/screens/login/model.dart';

import '../../res/color_res.dart';
import '../home_module/home_view.dart';
import '../otp_module/otp_view.dart';


class LoginController extends GetxController {

  TabController? tabController;


  LoginData? loginData;



  TextEditingController selectCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController phonePasswordCon = TextEditingController();


  TextEditingController emailCon = TextEditingController();
  TextEditingController emailPasswordCon = TextEditingController();




  bool isSecuredPhone = true;
  bool isSecuredEmail = true;

  isTruePhone(){
    isSecuredPhone = !isSecuredPhone;
    update();
  }

  String countryCodeText = "91";
  getCountryData(Country country){
    countryCodeText= country.phoneCode;
    update();
  }

  isTrueEmail(){
    isSecuredEmail = !isSecuredEmail;
    update();
  }


  




  getLogin({required String type,
    required String emailOrPhone,
    required String countryCode,
    required String password,
    required String role,
  })async {
    http.Response response = await http.post(
      Uri.parse("https://uniqual.dev:3322/api/v1/auth/login"),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "type": type,
        "emailOrPhone": emailOrPhone,
        "countryCode": countryCode,
        "password": password,
        "role": role,
      }),
    );
       try{
        if (response.statusCode == 200) {
          loginData = LoginData.fromJson(json.decode(response.body)['data']);
          if(loginData?.isVerified == true){
            Get.off(()=> HomeView() );
            Utils.showSuccessToast("Login Successfully");
            Injector.setAccessToken(loginData!.authentication!.accessToken!);
          }
          else{
            Get.to(() => OtpView(loginType: type,token: loginData!.authentication!.accessToken!, isTrue: true,));
            getResend(token: "${loginData!.authentication!.accessToken}");
            Utils.showInfoToast("otp send on your register number or email");
          }

        }
        if (response.statusCode == 409)
        {
          Utils.showInfoToast("An account already exists");
        }if (response.statusCode == 401)
        {
          Utils.showInfoToast("Invalid email or password");
        }
        else {
          print(response.statusCode);
        }
      }
      catch(error){
        throw "Unable to retrieve posts.$error";
      }

  }


  getResend({required String token}) async {
    http.Response response = await http.get(
      Uri.parse("https://uniqual.dev:3322/api/v1/email/verification/resend"),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token}',
      },
    );

    try {
      if (response.statusCode == 200) {
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
