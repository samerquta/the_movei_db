import 'dart:convert';
import '../../../network/api_data.dart';

PersonImagesModel peopleImagesModelFromJson(String str) => PersonImagesModel.fromJson(json.decode(str));

class PersonImagesModel {
  PersonImagesModel({
    required this.id,
    required this.profiles,
  });

  int id;
  List<Profile> profiles;

  factory PersonImagesModel.fromJson(Map<String, dynamic> json) => PersonImagesModel(
    id: json["id"],
    profiles: List<Profile>.from(json["profiles"].map((x) => Profile.fromJson(x))),
  );

}

class Profile {
  Profile({
    required this.aspectRatio,
    required this.height,
    required this.iso6391,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  double aspectRatio;
  int height;
  dynamic iso6391;
  String filePath;
  double voteAverage;
  int voteCount;
  int width;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    aspectRatio: json["aspect_ratio"].toDouble(),
    height: json["height"],
    iso6391: json["iso_639_1"],
    filePath: json["file_path"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
    width: json["width"],
  );

  String imageUrl() {
    return "${ApiData.imageBaseUrl}${"w500"}$filePath";
  }
}
