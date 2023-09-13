import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import 'package:http/http.dart' as http;
import 'package:new_project_setup/screens/otp_module/otp_view.dart';
import 'package:new_project_setup/screens/signup_module/model.dart';

import '../../constants/injector.dart';
import '../../constants/utils.dart';
import '../home_module/home_view.dart';

class SignupController extends GetxController{

  TabController? tabController;
  SignUpData? signUpData;
  SignUpData? isVerified;

  TextEditingController
  nameEmailController = TextEditingController(),
  companyNameEmailController = TextEditingController(),
  emailController = TextEditingController(),
  emailPassword = TextEditingController(),
      emailConfirmPassword = TextEditingController(),

  phoneNameController = TextEditingController(),
      phoneCompanyNameController = TextEditingController(),
      phoneController = TextEditingController(),
  phonePassword = TextEditingController(),
      phoneConfirmPassword = TextEditingController();

  String countryCodeText = "91";

  bool createEmailPassShow = true;

  createEmailPassShowFunc(){
    createEmailPassShow = !createEmailPassShow;
    update();
  }

  bool confirmEmailPassShow = true;

  confirmEmailPassShowFunc(){
    confirmEmailPassShow = !confirmEmailPassShow;
    update();
  }



  bool createPhonePassShow = true;

  createPhonePassShowFunc(){
    createPhonePassShow = !createPhonePassShow;
    update();
  }

  bool confirmPhonePassShow = true;

  confirmPhonePassShowFunc(){
    confirmPhonePassShow = !confirmPhonePassShow;
    update();
  }

  FocusNode focusNode = FocusNode();

  getCountryData(Country country){
    countryCodeText= country.phoneCode;
    update();
  }




  getSignUp({required String name,
    required String companyName,
    required String type,
    required String email,
    required String countryCode,
    required String phone,
    required String password,
    required String confirmPassword,
    required String role,
  })async {
    http.Response response = await http.post(
      Uri.parse("https://uniqual.dev:3322/api/v1/auth/register"),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "name": name,
        "companyName": companyName,
        "type": type,
        "email": email,
        "countryCode": countryCode,
        "phone": phone,
        "password": password,
        "confirmPassword": confirmPassword,
        "role": role,
      }),
    );
    try{
      if (response.statusCode == 200) {
        signUpData = SignUpData.fromJson(json.decode(response.body)['data']);
          Get.off(()=> OtpView(loginType: type,token: signUpData!.authentication!.accessToken!, isTrue: false,) );
          Utils.showInfoToast("otp send on your register number or email");
      }

      if (response.statusCode == 409)
        {
          Utils.showInfoToast("An account already exists");
        }
      else {
        print(response.statusCode);
      }
    }
    catch(error){
      throw "Unable to retrieve posts.$error";

    }

  }



}