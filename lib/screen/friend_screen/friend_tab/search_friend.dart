import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/manage/controller/friend_controller.dart';
import 'package:social_media/widgets/friend_request_widget.dart';

class SearchFriendScreen extends StatelessWidget {
  const SearchFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FriendController>();
    return Obx(() {
      if (!controller.isLoading.value) {
        return Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: ListView.separated(
              separatorBuilder: (context, index) => spaceHeight(context),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                    width: double.infinity,
                    height: getHeight(context, height: 0.13),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          )
                        ]));
              },
            ));
      } else {
        return SizedBox(
          height: 500,
          child: SmartRefresher(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            enablePullDown: false,
            enablePullUp: true,
            header: const WaterDropHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, mode) {
                Widget body;
                if (mode == LoadStatus.loading) {
                  body = const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (mode == LoadStatus.failed) {
                  body = const Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = const Text("release to load more");
                } else {
                  body = const Text("No more Data");
                }
                return body;
              },
            ),
            controller: controller.refreshController,
            onLoading: controller.onLoading,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return FriendRequestWidget(
                      avatar: controller.listUser[index].avatar,
                      name: controller.listUser[index].username,
                      uid: controller.listUser[index].uid,
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => spaceHeight(context),
                  itemCount: controller.listUser.length),
            ),
          ),
        );
      }
    });
  }
}
