import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/manage/controller/friend_controller.dart';
import 'package:social_media/manage/controller/register_controller.dart';
import 'package:social_media/widgets/button.dart';
import 'package:transparent_image/transparent_image.dart';

class FriendRequestWidget extends StatelessWidget {
  FriendRequestWidget(
      {required this.avatar,
      required this.name,
      super.key,
      required this.uid,
      required this.index});
  String avatar, name, uid;
  int index;
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FriendController>();
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
          ),
        ],
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Row(children: [
            Container(
              width: 50,
              height: 50,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: FadeInImage.memoryNetwork(
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder: kTransparentImage,
                image: avatar,
                imageErrorBuilder: (context, error, stackTrace) =>
                    Image.network(
                  "https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132_640.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            spaceWidth(context),
            Expanded(
              child: Text(
                name,
                style: mediumTextStyle(context),
              ),
            ),
            Obx(() {
              return ButtonWidget(
                function: () async {
                  controller.listText[index] == "Waiting"
                      ? await controller.removeRequest(
                          AppStore.to.uid.value, uid)
                      : await controller.sendFriendRequest(
                          AppStore.to.uid.value, uid);
                  controller.changeText(index);
                },
                width: getWidth(context, width: 0.2),
                height: getHeight(context, height: 0.06),
                borderRadius: 5,
                textButton: controller.listText[index],
                fontSize: 12,
              );
            }),
          ])),
    );
  }
}
