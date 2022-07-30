import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../custom_public_widgets/internet_connection_failed.dart';
import '../../custom_public_widgets/loading_card.dart';
import 'widgets/popular_people_card.dart';
import 'popular_people_list_controller.dart';


class PopularPeopleListScreen extends StatelessWidget {
  const PopularPeopleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('All Popular People',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: GetBuilder<PopularPeopleListController>(
          init: PopularPeopleListController(),
          builder: (controller) {
            if (controller.internetConnection) {
              if (controller.isFirstLoadRunning) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: controller.popularPeopleList.length,
                  itemBuilder: (_, index) => const LoadingCard(),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        controller: controller.scrollController,
                        itemCount: controller.popularPeopleList.length + 1,
                        itemBuilder: (_, index) =>
                            index == controller.popularPeopleList.length
                                ? (controller.isLoadMoreRunning
                                    ? Column(
                                      children: const [
                                        LoadingCard(),
                                        LoadingCard(),
                                      ],
                                    )
                                    : const SizedBox())
                                : PopularPeopleCard(popularPeopleItem: controller.popularPeopleList[index]),
                      ),
                    ),
                    if (!controller.hasNextPage)
                      Container(
                        padding: const EdgeInsets.only(top: 30, bottom: 40),
                        color: Colors.amber,
                        child: const Center(
                          child: Text('You have fetched all of the content'),
                        ),
                      ),
                  ],
                );
              }
            }else{
              return const InternetConnectionFailed();
            }
          }),
    );
  }
}
