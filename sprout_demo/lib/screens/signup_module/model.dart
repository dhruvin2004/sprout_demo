// To parse this JSON data, do
//
//     final signUpData = signUpDataFromJson(jsonString);

import 'dart:convert';


class SignUpData {
  int? userId;
  String? name;
  String? email;
  String? phone;
  String? role;
  int? step;
  dynamic profilePicture;
  dynamic cv;
  dynamic cvName;
  dynamic gender;
  dynamic address;
  dynamic postalCode;
  dynamic birthDate;
  dynamic language;
  String? companyName;
  dynamic description;
  bool? isVerified;
  Authentication? authentication;

  SignUpData({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.step,
    this.profilePicture,
    this.cv,
    this.cvName,
    this.gender,
    this.address,
    this.postalCode,
    this.birthDate,
    this.language,
    this.companyName,
    this.description,
    this.isVerified,
    this.authentication,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) => SignUpData(
    userId: json["userId"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    role: json["role"],
    step: json["step"],
    profilePicture: json["profilePicture"],
    cv: json["cv"],
    cvName: json["cvName"],
    gender: json["gender"],
    address: json["address"],
    postalCode: json["postalCode"],
    birthDate: json["birthDate"],
    language: json["language"],
    companyName: json["companyName"],
    description: json["description"],
    isVerified: json["isVerified"],
    authentication: json["authentication"] == null ? null : Authentication.fromJson(json["authentication"]),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "email": email,
    "phone": phone,
    "role": role,
    "step": step,
    "profilePicture": profilePicture,
    "cv": cv,
    "cvName": cvName,
    "gender": gender,
    "address": address,
    "postalCode": postalCode,
    "birthDate": birthDate,
    "language": language,
    "companyName": companyName,
    "description": description,
    "isVerified": isVerified,
    "authentication": authentication?.toJson(),
  };
}

class Authentication {
  String? accessToken;
  String? refreshToken;
  int? expireAt;

  Authentication({
    this.accessToken,
    this.refreshToken,
    this.expireAt,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    expireAt: json["expireAt"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "expireAt": expireAt,
  };
}
