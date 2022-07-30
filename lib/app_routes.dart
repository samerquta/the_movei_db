import 'package:get/get_navigation/src/routes/get_route.dart';

import 'moduels/popular_people_main/popular_people_list_screen.dart';
import 'moduels/popular_peoples_details/person_details_screen.dart';
import 'moduels/popular_peoples_details/view_image/view_image_screen.dart';


class AppRoutes {
  static final pages = [
    GetPage(
      name: AppLinks.popularPeopleScreen,
      page: () => const PopularPeopleListScreen(),
    ),
    GetPage(
      name: AppLinks.popularPeopleDetailsScreen,
      page: () => PersonDetailsScreen(),
    ),
    GetPage(
      name: AppLinks.imageScreen,
      page: () => ViewImageScreen(),
    ),
  ];
}

class AppLinks {
  static const String popularPeopleScreen = "/popular_people";
  static const String popularPeopleDetailsScreen = "/popular_people_detials";
  static const String imageScreen = "/image";
}