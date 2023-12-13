import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/manage/controller/category_controller.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.state.title.value)),
      ),
    );
  }
}
