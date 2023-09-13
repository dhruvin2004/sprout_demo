import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../constants/utils.dart';

class CvPortfolioController extends GetxController{
  File? filePdf;
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
        filePdf = File(result.files.single.path!);
        filePdfName = result.files.single.name; // File name
        int fileSize = filePdf!.lengthSync(); // F
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

}