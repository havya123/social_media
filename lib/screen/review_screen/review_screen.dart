import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/manage/controller/review_controller.dart';

class ReviewScreen extends GetView<ReviewController> {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: controller.widgets,
      ),
    );
  }
}
