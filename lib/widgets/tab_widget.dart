import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/manage/controller/profile_controller.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/widgets/post_widget.dart';

class TabWidget extends StatelessWidget {
  int index;

  TabWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          if (controller.listPost['listPost'] == null) {
            return Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: ListView.separated(
                  separatorBuilder: (context, index) => spaceHeight(context),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: getHeight(context, height: 0.4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    );
                  },
                ));
          }

          List<Post> listPost = controller.listPost['listPost'];
          if (controller.listPost['status'] == "loading") {
            return Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: ListView.separated(
                  separatorBuilder: (context, index) => spaceHeight(context),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: getHeight(context, height: 0.4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    );
                  },
                ));
          }
          if (controller.listPost['status'] == "done" &&
              controller.listPost.isNotEmpty) {
            return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return PostWidget(
                    content: listPost[index].content ?? "",
                    imageUrl: listPost[index].image ?? "",
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: getHeight(context, height: 0.08),
                  );
                },
                itemCount: listPost.length);
          }
          return const Center(
            child: Text("Your have not any post yet"),
          );
        }));
  }
}
