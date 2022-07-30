import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_movie_db_task/moduels/popular_people_main/popular_people_repositroy.dart';
import 'models/popular_people_model.dart';

class PopularPeopleListController extends GetxController {
  int pageNumber = 1;
  bool internetConnection = false;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  List<PopularPeopleModel> popularPeopleList = [];

  void _firstLoadPopularPeopleList() async {
    isFirstLoadRunning = true;
    update();
    try {
      final res = await PopularPeopleRepository().getPopularPeopleList(pageNumber);

      popularPeopleList = List<PopularPeopleModel>.from(
          json.decode(res)["results"].map((x) => PopularPeopleModel.fromMap(x)));
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

    isFirstLoadRunning = false;
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

  void _loadMorePopularPeopleList() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        scrollController.position.extentAfter < 300) {
      isLoadMoreRunning = true;
      update();
      pageNumber += 1;
      try {
        final res = await PopularPeopleRepository().getPopularPeopleList(pageNumber);

        final List<PopularPeopleModel> fetchedResults = List<PopularPeopleModel>.from(
            json.decode(res)["results"].map((x) => PopularPeopleModel.fromMap(x)));
        if (fetchedResults.isNotEmpty) {
          popularPeopleList.addAll(fetchedResults);
          update();
        } else {
          hasNextPage = false;
          update();
        }
      } catch (err) {
        Get.snackbar('Something went wrong', 'Check your network',
            icon: const Icon(
              Icons.network_check,
              color: Colors.amber,
            ));
      }

      isLoadMoreRunning = false;
      update();
    }
  }

  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    _firstLoadPopularPeopleList();
    scrollController = ScrollController()..addListener(_loadMorePopularPeopleList);
  }

  @override
  void dispose() {
    scrollController.removeListener(_loadMorePopularPeopleList);
    super.dispose();
  }
}