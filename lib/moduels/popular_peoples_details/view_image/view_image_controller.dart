import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';

class ViewImageController extends GetxController {
  Future<void> saveImage(String imageUrl) async {
    try {
      var imageId = await ImageDownloader.downloadImage(imageUrl);
      if (imageId == null) {
        return;
      }
    } on PlatformException catch (error) {
      print(error);
    }
  }
}
