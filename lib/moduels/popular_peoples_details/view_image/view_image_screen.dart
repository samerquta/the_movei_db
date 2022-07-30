import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:photo_view/photo_view.dart';
import 'package:the_movie_db_task/moduels/popular_peoples_details/view_image/view_image_controller.dart';
import '../model/person_images_model.dart';

class ViewImageScreen extends StatelessWidget {
  ViewImageScreen({Key? key}) : super(key: key);
  final profile = Get.arguments as Profile;
  ViewImageController _viewImageController =Get.put(ViewImageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 40,
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 80,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Expanded(
                  flex: 10,
                  child: Hero(
                    tag: profile..toString(),
                    child: PhotoView(
                      loadingBuilder: (context, progress) => Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      backgroundDecoration:
                          const BoxDecoration(color: Colors.white),
                      imageProvider: NetworkImage(profile.imageUrl()),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 10,
                child: InkWell(
                  child: const Text("Save Image"),
                  onTap: (){
                    _viewImageController.saveImage(profile.imageUrl());
                  },
                ))
          ],
        ),
      ),
    );
  }
}
