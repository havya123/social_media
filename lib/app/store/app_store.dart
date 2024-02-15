import 'dart:convert';

import 'package:get/get.dart';
import 'package:social_media/app/store/services.dart';
import 'package:social_media/app/util/key.dart';

class AppStore extends GetxController {
  static AppStore get to => Get.find();
  bool firstRun = false;
  String uid = "";

  @override
  void onInit() {
    String result = AppServices.to.getString(MyKey.firstRun);
    String uidSaved = AppServices.to.getString(MyKey.uid);
    if (result.isNotEmpty) {
      firstRun = jsonDecode(result);
    }
    if (uidSaved.isNotEmpty) {
      uid = uidSaved;
    } else {
      uid = "";
    }
    super.onInit();
  }
}
