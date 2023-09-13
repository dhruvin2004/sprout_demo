
import '../../constants/app.export.dart';

// To parse this JSON data, do
//
//     final educationData = educationDataFromJson(jsonString);

import 'dart:convert';

EducationData educationDataFromJson(String str) => EducationData.fromJson(json.decode(str));

String educationDataToJson(EducationData data) => json.encode(data.toJson());

class EducationData {
  Data? data;

  EducationData({
    this.data,
  });

  factory EducationData.fromJson(Map<String, dynamic> json) => EducationData(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  List<dynamic>? education;
  int? step;

  Data({
    this.education,
    this.step,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    education: json["education"] == null ? [] : List<dynamic>.from(json["education"]!.map((x) => x)),
    step: json["step"],
  );

  Map<String, dynamic> toJson() => {
    "education": education == null ? [] : List<dynamic>.from(education!.map((x) => x)),
    "step": step,
  };
}



class EducationModal{

  TextEditingController institution;
  TextEditingController qualification;
  TextEditingController yearOfCompletion;


  EducationModal({
    required this.institution,
    required this.qualification,
    required this.yearOfCompletion,

});

  Map<String, dynamic> toJson() {
    return {
      'instituition': institution.text,
      'qualification': qualification.text,
      'finalYear': yearOfCompletion.text,
    };
  }

}