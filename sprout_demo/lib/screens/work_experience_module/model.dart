



import 'package:flutter/cupertino.dart';

class ExperienceModal{

  TextEditingController companyName;
  TextEditingController position;
  TextEditingController starDate;
  TextEditingController endDate;



  ExperienceModal({
    required this.companyName,
    required this.position,
    required this.starDate,
    required this.endDate,
});

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName.text,
      'position': position.text,
      'experienceStartDate': starDate.text,
      'experienceEndDate' : endDate.text,
    };
  }


}