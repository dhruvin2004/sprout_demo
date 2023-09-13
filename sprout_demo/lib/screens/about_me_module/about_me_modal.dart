

import 'dart:convert';

LanguageData languageDataFromJson(String str) => LanguageData.fromJson(json.decode(str));

String languageDataToJson(LanguageData data) => json.encode(data.toJson());

class LanguageData {
  List<Datum>? data;

  LanguageData({
    this.data,
  });

  factory LanguageData.fromJson(Map<String, dynamic> json) => LanguageData(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? name;

  Datum({
    this.id,
    this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class AboutMeData {
  int? id;
  dynamic aboutMe;
  dynamic gender;
  String? email;
  dynamic postalCode;
  dynamic birthDate;
  dynamic language;
  dynamic additionalInfo;
  List<dynamic>? socialLinks;
  int? step;

  AboutMeData({
    this.id,
    this.aboutMe,
    this.gender,
    this.email,
    this.postalCode,
    this.birthDate,
    this.language,
    this.additionalInfo,
    this.socialLinks,
    this.step,
  });

  factory AboutMeData.fromJson(Map<String, dynamic> json) => AboutMeData(
    id: json["id"],
    aboutMe: json["aboutMe"],
    gender: json["gender"],
    email: json["email"],
    postalCode: json["postalCode"],
    birthDate: json["birthDate"],
    language: json["language"],
    additionalInfo: json["additionalInfo"],
    socialLinks: json["socialLinks"] == null ? [] : List<dynamic>.from(json["socialLinks"]!.map((x) => x)),
    step: json["step"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "aboutMe": aboutMe,
    "gender": gender,
    "email": email,
    "postalCode": postalCode,
    "birthDate": birthDate,
    "language": language,
    "additionalInfo": additionalInfo,
    "socialLinks": socialLinks == null ? [] : List<dynamic>.from(socialLinks!.map((x) => x)),
    "step": step,
  };
}


class AddLanguageData{
   bool checkBoxValue;
  final String languageName;

  AddLanguageData({
     this.checkBoxValue = false,
      required this.languageName,
  });
}