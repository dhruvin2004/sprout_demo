import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/app.export.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class WorkExperienceController extends GetxController {
  // List companyNameList = [
  //   TextEditingController(),
  // ];
  // List positionList = [
  //   TextEditingController(),
  // ];
  // List experienceList = [
  //   TextEditingController(),
  // ];

  int getIndex = 0;

  // TextEditingController
  // companyNameList = TextEditingController(),
  //     positionList = TextEditingController(),
  // experienceList = TextEditingController();

  // List companyNameList = [];
  // List positionList = [];
  // List experienceList = [];
  //
  List<ExperienceModal> controllerList = [
    ExperienceModal
      (companyName:TextEditingController(),
      endDate:TextEditingController(),
      position:TextEditingController(),
      starDate:TextEditingController(),),
  ];

  // List qualificationList = [];


  getAddExperienceFunc() {
    controllerList.add(ExperienceModal
      (companyName:TextEditingController(),
      endDate:TextEditingController(),
      position:TextEditingController(),
      starDate:TextEditingController(),),);
    // controllerList.add(TextEditingController());
    // qualificationList.addAll(
    //  [{
    //     'companyNameList' : companyNameList[index],
    //     'positionList' : positionList[index],
    //     'experienceList' : experienceList[index],
    //   }]
    // );
    // companyNameList.add(TextEditingController());
    // positionList.add(TextEditingController());
    // experienceList.add(TextEditingController());
    update();
  }

  removeExperienceFunc(int e) {
    //print("datat ${fileImageVideoList[index]}");
    // companyNameList.removeAt(e);
    // positionList.removeAt(e);
    // experienceList.removeAt(e);
    controllerList.removeAt(e);
    update();
  }

  DateTime? startDate;
  DateTime? endDate;


  selectDate(BuildContext context, int index, DateTime? dateTime,TextEditingController controller) async {
    dateTime = await showDatePicker(
      context: context,
      initialDate: dateTime ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (dateTime != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(dateTime);
    } else {
      Utils.showErrToast("Cancel");
    }
  }



  getWorkExperience() async {
    http.Response response = await http.post(
        Uri.parse("https://uniqual.dev:3322/api/v1/freelancer/work-experience"),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${Injector.getAccessToken()}',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          "isSkip": true,
          "workExperience": {
            "companyName": "TEDtext softhouse",
            "position": "Product designer",
            "experienceStartDate": "25/07/2022",
            "experienceEndDate": "25/08/2022"
          }
        })
    );
    try {
      if (response.statusCode == 200) {
        //Get.off(() => AboutMeView(),);
      }
      else{
        Utils.showToast('error');
      }
    } catch (e) {
      print("e");
    }
  }

}