import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:the_movie_db_task/moduels/popular_peoples_details/person_details_controller.dart';
import '../../custom_public_widgets/internet_connection_failed.dart';
import '../../custom_public_widgets/loading_card.dart';
import 'widgets/person_image_card.dart';
import '../popular_people_main/models/popular_people_model.dart';

class PersonDetailsScreen extends StatelessWidget {
  PersonDetailsScreen({Key? key}) : super(key: key);
  final person = Get.arguments as PopularPeopleModel;
  final PopularPeopleDetailsController _detailsController =
      Get.put(PopularPeopleDetailsController());

  @override
  Widget build(BuildContext context) {
    _detailsController.getPersonImages(person.id);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            buildPersonDetails(),
            buildPersonImages(),
          ],
        ),
      ),
    );
  }

  Expanded buildPersonImages() {
    return Expanded(
            child: Center(
              child: GetBuilder<PopularPeopleDetailsController>(
                  init: PopularPeopleDetailsController(),
                  builder: (controller) {
                    if (controller.internetConnection) {
                      if (controller.isLoadingRunning) {
                        return LoadingCard();
                      } else {
                        return Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                padding: const EdgeInsets.all(16.0),
                                controller: controller.scrollController,
                                itemCount: controller.itemImages.profiles.length,
                                itemBuilder: (_, index) => PersonImageCard(
                                    profile: controller.itemImages.profiles[index],
                                  personImages: controller.itemImages,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    } else {
                      return const InternetConnectionFailed();
                    }
                  }),
            ),
          );
  }

  Center buildPersonDetails() {
    return Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Column(
                children: [
                  SizedBox(height: Get.height * 00.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 40,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      Hero(
                        tag: person.id.toString(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: person.imageUrl(),
                            progressIndicatorBuilder: (context, url,
                                downloadProgress) =>
                                Container(
                                    color: Colors.white24,
                                    child:
                                    const CupertinoActivityIndicator()),
                            errorWidget: (context, url, error) =>
                                Container(
                                    color: Colors.white24,
                                    child: const Icon(Icons.error)),
                            fit: BoxFit.cover,
                            height: 150,
                            // width: 150,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 2, right: 2, top: 10),
                                child: FittedBox(
                                  child: Text(
                                    person.name,
                                    softWrap: false,
                                    maxLines: 1,
                                    style:  TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.white),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 2, right: 2, top: 10),
                                child: Text(
                                  person.knownForDepartment,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 2, right: 2, top: 10),
                                child: person.gender == 1
                                    ? Icon(
                                  Icons.female,
                                  color: Colors.pink,
                                )
                                    : Icon(
                                  Icons.male,
                                  color: Colors.blueAccent,
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 2, right: 2, top: 10,bottom: 20),
                                child:RatingBarIndicator(
                                  rating:(person.popularity/100)*5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 25.0,
                                  direction: Axis.horizontal,
                                ),),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
