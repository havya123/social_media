import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/manage/controller/information_controller.dart';

class InformationUser extends GetView<InformationController> {
  const InformationUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: controller.widgets,
      ),
    );
  }
}
