import 'dart:convert';

import 'package:get/get.dart';
import 'package:social_media/app/store/services.dart';
import 'package:social_media/app/util/key.dart';

class AppStore extends GetxController {
  static AppStore get to => Get.find();
  bool firstRun = false;

  @override
  void onInit() {
    String result = AppServices.to.getString(MyKey.firstRun);
    if (result.isNotEmpty) {
      firstRun = jsonDecode(result);
    }
    super.onInit();
  }
  
}
