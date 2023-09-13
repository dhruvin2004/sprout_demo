import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_project_setup/constants/app.export.dart';

import '../about_me_module/about_me_view.dart';
import 'model.dart';

class SetUpController extends GetxController {

  bool expansionChanged = false;

  List<Datum> jobType = [];




  List selectSubCategory= [];




  expansionChangedVal(val) {
    expansionChanged = val;
    update();
  }


  getSelectJobResponse() async {
    http.Response response = await http.post(
        Uri.parse("https://uniqual.dev:3322/api/v1/freelancer/sub-job-types"),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${Injector.getAccessToken()}',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          "isSkip": true,
          "subJobTypeIds": selectSubCategory,
        })
    );
    try {
      if (response.statusCode == 200) {
        Get.off(() => AboutMeView(),);
      }
      else{
        Utils.showToast('error');
        print(selectSubCategory);
      }
    } catch (e) {
      print("e");
    }
  }

   getAdd(SubCategory subCategory){
     selectSubCategory.remove(subCategory.subJobTypeId);
     update();
   }

   getRemove(SubCategory subCategory){
     selectSubCategory.add(subCategory.subJobTypeId);
     update();
   }

  getJobType() async {
    http.Response response = await http.get(
      Uri.parse("https://uniqual.dev:3322/api/v1/job-types"),
      headers: {
        'accept': '*/*',
         'Authorization' : 'Bearer ${Injector.getAccessToken()}',
      }

    );
    try {
      if (response.statusCode == 200) {
        JobData jobData = JobData.fromJson(json.decode(response.body));

        if(jobData.data!.isNotEmpty)
          {
            jobType.addAll(jobData.data!);
            print(jobType);
            print(jobData.data);
            update();
          }

      }
    } catch (e) {
      print("Error : $e");
    }
  }



  @override
  void onInit() {
    // TODO: implement onInit
    getJobType();
    super.onInit();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    jobType.clear();
    super.dispose();
  }

}