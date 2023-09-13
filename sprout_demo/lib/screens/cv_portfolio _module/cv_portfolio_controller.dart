import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../constants/injector.dart';
import '../../constants/utils.dart';
import 'package:http/http.dart' as http;

class CvPortfolioController extends GetxController{
  File? cvFile;
  String? filePdfName;
  String? formatFilePdfSize;
  bool video = false;
   File? fileImageVideo;
   File? fileThumbnailImage;
   List<Map<String,dynamic>> fileImageVideoList = [];
   double megabytes = 0;

  uploadPDF() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        cvFile = File(result.files.single.path!);
        filePdfName = result.files.single.name; // File name
        int fileSize = cvFile!.lengthSync(); // F
        if(megabytes <= 20) {
          formatFilePdfSize = formatFileSize(fileSize);
        }else{
          return Utils.showToast("Please check your size decrease !!");
        }// ile size in bytes
        update();
      }
    }

  String formatFileSize(int bytes) {
    megabytes = (bytes / (1024 * 1024));
    return megabytes!.toStringAsFixed(2) + ' MB';
  }

  uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
    );
    if (result != null) {
      fileImageVideo = File(result.files.single.path!);
      if (result.files.single.extension == 'jpg' ||
          result.files.single.extension == 'jpeg' ||
          result.files.single.extension == 'png') {
        fileImageVideoList.add({
          'image' : fileImageVideo,
          'bool' : false,
        });
        print('Image selected');
      } else if (result.files.single.extension == 'mp4') {
        File file = File(result.files.single.path!);
        final thumbnailPath = await VideoThumbnail.thumbnailFile(
          video: file.path,
          thumbnailPath: (await getTemporaryDirectory()).path,
          imageFormat: ImageFormat.JPEG,
        );
        fileThumbnailImage = File(thumbnailPath!);
        fileImageVideoList.add({
          'image' : fileThumbnailImage,
          'bool' : true,
        });
        print('Video selected');
      } else {
        print('Unsupported file type');
      }
    }
    update();
  }

  removeImageFunc(int e){
    //print("datat ${fileImageVideoList[index]}");
    fileImageVideoList.removeAt(e);
    update();
  }
  removeCv(){
    cvFile = null;
    Get.back();
    update();
  }
  List controllerList = [TextEditingController()];

  getAddLinksFunc(){
    controllerList.add(TextEditingController());
    update();
  }

  removeLinks(int e){
    //print("datat ${fileImageVideoList[index]}");
    controllerList.removeAt(e);
    update();
  }


  getCvRespones()async{
    http.Response response = await http.put(
        Uri.parse("https://uniqual.dev:3322/api/v1/freelancer/cv"),
        headers: {
          'accept' :'*/*',
          'Authorization' : 'Bearer ${Injector.getAccessToken()}',
          'Content-Type' : 'multipart/form-data',
        },
      body: {
        'isSkip': 'true',
        'cv': cvFile,
      },

    );

    if (response.statusCode == 200) {
      Utils.showSuccessToast("Done");
      print(response.body);
    } else {
      print('CV deletion failed');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }

  }




  Future<void> deleteFreelancerCV() async {


    final response = await http.delete(
      Uri.parse("https://uniqual.dev:3322/api/v1/freelancer/cv"),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer ${Injector.getAccessToken()}',
      },
    );

    if (response.statusCode == 200) {
      print('CV deletion successful');
      print(response.body);
    } else {
      print('CV deletion failed');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }
  }


}