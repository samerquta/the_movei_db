import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/person_images_model.dart';


class PersonImageCard extends StatelessWidget {
  final Profile profile;
  final PersonImagesModel personImages;

  const PersonImageCard({Key? key, required this.profile,required this.personImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: (){

          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: profile..toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: profile.imageUrl(),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                              color: Colors.white24,
                              child: const CupertinoActivityIndicator()),
                      errorWidget: (context, url, error) => Container(
                          color: Colors.white24,
                          child: const Icon(Icons.error)),
                      fit: BoxFit.cover,
                      height: 230,
                      width: 130,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
