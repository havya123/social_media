import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppServices extends GetxController {
  static AppServices get to => Get.find();

  late SharedPreferences prefs;

  Future<AppServices> init() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> setString(String key, Object value) async {
    await prefs.setString(key, jsonEncode(value));
  }

  String getString(String key) {
    final String result = prefs.getString(key) ?? "";
    return result;
  }
}
