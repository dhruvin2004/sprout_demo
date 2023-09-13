import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:new_project_setup/constants/app.export.dart';

import '../../constants/injector.dart';
import 'model.dart';

class EducationController extends GetxController {
  List<EducationModal> controllerList = [
    EducationModal(
      institution: TextEditingController(),
      qualification: TextEditingController(),
      yearOfCompletion: TextEditingController(),
    ),
  ];

  getAddQualificationFunc() {
    controllerList.add(EducationModal(
      institution: TextEditingController(),
      qualification: TextEditingController(),
      yearOfCompletion: TextEditingController(),
    ));
    update();
  }

  removeQualificationFunc(int e) {
    controllerList.removeAt(e);
    update();
  }

  getEducationRespones({
    required String instituition,
    required String qualification,
    required String finalYear,
  }) async {
    http.Response response = await http.put(
      Uri.parse("https://uniqual.dev:3322/api/v1/freelancer/education"),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer ${Injector.getAccessToken()}',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        "isSkip": true,
        "education": {
          "instituition": instituition,
          "qualification": qualification,
          "finalYear": finalYear,
        },
      }),
    );

    try{
      if(response.statusCode == 200)
        {
          Utils.showInfoToast("Done");
        }
      else{
        print(response.statusCode);
      }
    }catch(e){
      throw "Error : $e";
    }
  }
}
