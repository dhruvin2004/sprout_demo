import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:new_project_setup/screens/about_me_module/about_me_modal.dart';

import '../../constants/app.export.dart';
import '../education_module/education_view.dart';
import 'about_me_modal.dart';

class AboutMeController extends GetxController {
  bool showDrop = false;
  String? gender;

  TextEditingController

  searchCon = TextEditingController(),
  aboutMeCon = TextEditingController(),
  emailCon = TextEditingController(),
  birthDateCon = TextEditingController(),
  additionalCon = TextEditingController();


  final searchText = ValueNotifier("");

  List<Datum> languageList = [];

  List<AddLanguageData> spokenList = [
    AddLanguageData(
        checkBoxValue: false,
        languageName: "English",
    ),
    AddLanguageData(
      checkBoxValue: false,
      languageName: "Tamil",
    ),
    AddLanguageData(
      checkBoxValue: false,
      languageName: "Chinese",
    ),
  ];

  // List<AddLanguageData> spokenList = [
  //   {
  //     'checkboxValue' : false,
  //     'name' : "English"
  //   },
  //   {
  //     'checkboxValue' : false,
  //     'name' : "Tamil"
  //   },
  //   {
  //     'checkboxValue' : false,
  //     'name' : "Chinese"
  //   },
  //];

  List selectedLanguageList = [];

  showDropDownButton() {
    showDrop = !showDrop;
    update();
  }

  selectRole({required String value}) {
    gender = value;
    update();
  }


  searchFunc(String val){
    searchText.value = val;
    update();
  }

  final List<String> items = [
    'Male',
    'Female',
    'Non-binary',
    'Others',
    'Prefer not to say',
  ];

  DateTime? birthDate;

  int addQualification = 1;
  List controllerList = [
    TextEditingController(),
  ];

  getAddLinkFunc() {
    controllerList.add(TextEditingController());
    update();
  }

  removeLinkFunc(int e) {
    //print("datat ${fileImageVideoList[index]}");
    controllerList.removeAt(e);
    update();
  }

  List<String> addSocialMediaLinksScreenList = [];

  addLanguageScreen(int index){
    String selectedLanguage = languageList[index].name!.toUpperCase();

    if (!spokenList.any((data) => data.languageName.toUpperCase() == selectedLanguage)) {
      spokenList.add(
        AddLanguageData(
          checkBoxValue: false,
          languageName: languageList[index].name.toString(),
        ),
      );
    } else {
      Utils.showToast("Already Language Selected");
    }

    print("================ print ===============");
    print(spokenList);
    print(languageList[index].name);
    update();
    Get.back();

  }

  void addLanguageSelectedCheckBox(bool value, int index) {
    if (value) {
      spokenList[index].checkBoxValue = true;
      selectedLanguageList.add(spokenList[index].languageName);
      print("============== data ================");
      print(selectedLanguageList);
    } else {
      spokenList[index].checkBoxValue = false;
      selectedLanguageList.remove(spokenList[index].languageName);
      print("============== data ================");
      print(selectedLanguageList);
    }
    update();
  }

  selectBirthDate(BuildContext context) async {
    birthDate = await showDatePicker(
      context: context,
      initialDate: birthDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (birthDate != null) {
      birthDateCon.text = DateFormat('dd/MM/yyyy').format(birthDate!);
    } else {
      Utils.showErrToast("Cancel");
    }
    update();
  }

  getLanguageResponse() async {
    http.Response response = await http.get(
      Uri.parse("https://uniqual.dev:3322/api/v1/language"),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer ${Injector.getAccessToken()}',
      },
    );

    try {
      if (response.statusCode == 200) {
        LanguageData languageData =
            LanguageData.fromJson(json.decode(response.body));
        if (languageData.data!.isNotEmpty) {
          languageList.addAll(languageData.data!);
          print("LanguageList ${languageList}");
          update();
        }
      }
    } catch (e) {
      throw "Error ewref3e43$e";
    }
  }

  AboutMeData? aboutMeData;
  List<AboutMeData> aboutMeList= [];

  getAboutMeResponse({
    required bool isSkip ,
    required String aboutMe,
    required String gender,
    required String email,
    required String postalCode,
    required String birthDate,
    required String language,
    required List<String> socialLinks,
    required String additionalInfo,
}) async {
    http.Response response = await http.put(
      Uri.parse("https://uniqual.dev:3322/api/v1/freelancer/about-me"),
      headers: {
        'accept' :'*/*',
        'Authorization' : 'Bearer ${Injector.getAccessToken()}',
        'Content-Type' : 'application/json',
      },
      body: json.encode({
        "isSkip": isSkip,
        "aboutMe": aboutMe,
        "gender": gender,
        "email": email,
        "postalCode": postalCode,
        "birthDate": birthDate,
        "language": language,
        "socialLinks": socialLinks,
        "additionalInfo": additionalInfo,
      })
    );

    try{
      if(response.statusCode == 200)
        {
          Get.off(() => EducationScreen());
        }
    }catch(e){
      throw "Error : $e";
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getLanguageResponse();
    super.onInit();
  }

}
