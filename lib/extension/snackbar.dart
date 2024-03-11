import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialogs {
  static success({required String msg}) {
    Get.snackbar('Success', msg,
        duration: const Duration(seconds: 1),
        colorText: Colors.white,
        backgroundColor: Colors.green.withOpacity(.9));
  }

  static error({required String msg}) {
    Get.snackbar('Error', msg,
        duration: const Duration(seconds: 1),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withOpacity(.9));
  }

  static info({required String msg}) {
    Get.snackbar('Info', msg, colorText: Colors.white);
  }

  static showProgress() {
    Get.dialog(const Center(child: CircularProgressIndicator(strokeWidth: 2)));
  }
}
