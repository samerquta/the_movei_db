import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_movie_db_task/moduels/popular_peoples_details/person_details_repository.dart';
import 'model/person_images_model.dart';

class PopularPeopleDetailsController extends GetxController {
  bool internetConnection = false;
  bool isLoadingRunning = false;
  late PersonImagesModel itemImages;

  void getPersonImages(int personId) async {
    isLoadingRunning = true;
    try {
      final res =
          await PopularPeopleDetailsRepository().getImages(personId);
      var map = json.decode(res);
      itemImages = PersonImagesModel.fromJson(map);
      isLoadingRunning = false;
      log(res);
      update();
    } catch (err) {
      log('Something went wrong ${err.toString()}');
      Get.snackbar('Something went wrong', 'Check your network',
          icon: const Icon(
            Icons.network_check,
            color: Colors.amber,
          ));
    }
    update();
  }

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      internetConnection = true;
      update();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      internetConnection = true;
      update();
    } else {
      internetConnection = false;
      update();
    }
  }

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    // firstLoad();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
