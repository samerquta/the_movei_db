import 'package:get/get_navigation/src/routes/get_route.dart';

import 'moduels/popular_people_main/popular_people_list_screen.dart';


class AppRoutes {
  static final pages = [
    GetPage(
      name: AppLinks.popularPeopleScreen,
      page: () => const PopularPeopleListScreen(),
    ),
  ];
}

class AppLinks {
  static const String popularPeopleScreen = "/popular_people";
}