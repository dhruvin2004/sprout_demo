import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:new_project_setup/constants/app.export.dart';
import '../../constants/injector.dart';
import '../work_experience_module/work_experience_view.dart';
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
    controllerList.add(
        EducationModal(
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

  void onInit(){
    super.onInit();
  }



  getEducationResponse() async {
    // List<dynamic> educationJsonList = controllerList.map((education) => education
    //     .toJson()).toList();
    // String educationJson = json.encode(educationJsonList);
    List<Map<String, dynamic>> educationJsonList = controllerList
        .map((education) => education.toJson())
        .toList();

    print("============================= data================================") ;
    print("${educationJsonList}");
    String educationJson = json.encode(educationJsonList);
    print("============================= data2 ================================") ;
    print("${educationJson}");
    http.Response response = await http.post(
      Uri.parse("https://uniqual.dev:3322/api/v1/freelancer/education"),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer ${Injector.getAccessToken()}',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        "isSkip": true ,
        "education": educationJson
      }),
    );

    try{
      if(response.statusCode == 200)
      {
        Utils.showInfoToast("Done");
        Get.off(() => WorkExperienceView());
      }
      else{
        print(response.statusCode);
      }
    }catch(e){
      throw "Error : $e";
    }
  }

}
