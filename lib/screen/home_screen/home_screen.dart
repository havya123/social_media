import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/manage/controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            controller.obx(
              (state) => Text(
                state.toString(),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.addNumber();
                },
                child: const Text('data')),
          ],
        ),
      ),
    );
  }
}
