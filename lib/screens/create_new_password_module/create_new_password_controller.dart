import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants/utils.dart';
import '../login/login_view.dart';

class CreateNewPasswordController extends GetxController{

  TextEditingController
  createController = TextEditingController(),
  confirmController = TextEditingController();

  bool createEmailPassShow = true;

  createEmailPassShowFunc() {
    createEmailPassShow = !createEmailPassShow;
    update();
  }

  bool confirmEmailPassShow = true;

  confirmEmailPassShowFunc() {
    confirmEmailPassShow = !confirmEmailPassShow;
    update();
  }
  
  
  getChangePassword({required String emailOrPhone,
    required String countryCode,
    required String role,
    required String type,
    required String password,
    required String confirmPassword,
  }) async {
    http.Response response = await http.post(Uri.parse(
        "https://uniqual.dev:3322/api/v1/forgot-password/new-password"),
      headers: {
        'accept': '/',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "emailOrPhone": emailOrPhone,
        "countryCode": countryCode,
        "role": role,
        "type": type,
        "password": password,
        "confirmPassword": confirmPassword,
      }),
    );
    try{
      if(response.statusCode == 200){
        Utils.showInfoToast("Password changed successfully");
        Get.back();
        Get.back();
      }
    }catch(e){
      throw "e";
    }
  }
  

}