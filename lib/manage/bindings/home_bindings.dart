import 'package:get/get.dart';
import 'package:social_media/manage/controller/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
