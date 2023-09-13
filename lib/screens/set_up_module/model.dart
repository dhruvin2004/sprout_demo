// To parse this JSON data, do
//
//     final setUpData = setUpDataFromJson(jsonString);

import 'dart:convert';

SetUpData setUpDataFromJson(String str) => SetUpData.fromJson(json.decode(str));

String setUpDataToJson(SetUpData data) => json.encode(data.toJson());



class SetUpData {
  List<dynamic>? subjobType;
  int? step;

  SetUpData({
    this.subjobType,
    this.step,
  });

  factory SetUpData.fromJson(Map<String, dynamic> json) => SetUpData(
    subjobType: json["subjobType"] == null ? [] : List<dynamic>.from(json["subjobType"]!.map((x) => x)),
    step: json["step"],
  );

  Map<String, dynamic> toJson() => {
    "subjobType": subjobType == null ? [] : List<dynamic>.from(subjobType!.map((x) => x)),
    "step": step,
  };
}






JobData jobDataFromJson(String str) => JobData.fromJson(json.decode(str));

String jobDataToJson(JobData data) => json.encode(data.toJson());

class JobData {
  List<Datum>? data;

  JobData({
    this.data,
  });

  factory JobData.fromJson(Map<String, dynamic> json) => JobData(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? jobTypesId;
  String? jobTypesName;
  String? image;
  List<SubCategory>? subCategories;

  Datum({
    this.jobTypesId,
    this.jobTypesName,
    this.image,
    this.subCategories,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    jobTypesId: json["jobTypesId"],
    jobTypesName: json["jobTypesName"],
    image: json["image"],
    subCategories: json["subCategories"] == null ? [] : List<SubCategory>.from(json["subCategories"]!.map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "jobTypesId": jobTypesId,
    "jobTypesName": jobTypesName,
    "image": image,
    "subCategories": subCategories == null ? [] : List<SubCategory>.from(subCategories!.map((x) => x.toJson())),
  };
}

class SubCategory {
  int? subJobTypeId;
  String? subJobTypeName;

  SubCategory({
    this.subJobTypeId,
    this.subJobTypeName,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    subJobTypeId: json["subJobTypeId"],
    subJobTypeName: json["subJobTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "subJobTypeId": subJobTypeId,
    "subJobTypeName": subJobTypeName,
  };
}
