import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/manage/controller/friend_controller.dart';

class DetailTabs extends StatelessWidget {
  DetailTabs({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FriendController>();
    return controller.listTab[index];
  }
}
