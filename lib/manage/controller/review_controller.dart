import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/app/store/services.dart';
import 'package:social_media/app/util/key.dart';

class ReviewController extends GetxController {
  List<Widget> widgets = [
    Container(
      color: Colors.yellow,
      width: double.infinity,
      height: double.infinity,
    ),
    Container(
      color: Colors.red,
      width: double.infinity,
      height: double.infinity,
    ),
    Container(
      color: Colors.blue,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              Get.offNamed(RouteName.loginRoute);
              AppServices.to.setString(MyKey.firstRun, true);
            },
            child: const Text("Next")),
      ),
    ),
  ];
}
