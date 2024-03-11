import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/widgets/friend_coming_widget.dart';
import 'package:social_media/widgets/friend_request_widget.dart';

import '../../../manage/controller/friend_controller.dart';

class ComingFriendScreen extends StatelessWidget {
  const ComingFriendScreen({super.key});

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
        if (controller.listComing.isEmpty) {
          return const Center(
            child: Text("You have not any request"),
          );
        }
        return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FriendComingWidget(
                avatar: controller.listComing[index].avatar,
                name: controller.listComing[index].username,
                uid: controller.listComing[index].uid,
              );
            },
            separatorBuilder: (context, index) => spaceHeight(context),
            itemCount: controller.listComing.length);
      }
    });
  }
}
