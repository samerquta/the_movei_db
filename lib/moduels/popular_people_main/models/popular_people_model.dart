import '../../../network/api_data.dart';
class PopularPeopleModel {

  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  double popularity;
  String profilePath;

  PopularPeopleModel({
   required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    required this.profilePath
  });


  factory PopularPeopleModel.fromMap(Map<String, dynamic> json) => PopularPeopleModel(
    id: json["id"],
    adult: json["adult"],
    gender: json["gender"]??1,
    knownForDepartment: json["known_for_department"]??"",
    name: json["name"]??"",
    popularity: json["popularity"]??0,
    profilePath: json["profile_path"]??"",
  );

  String imageUrl() {
    return "${ApiData.imageBaseUrl}${"w500"}$profilePath";
  }
}