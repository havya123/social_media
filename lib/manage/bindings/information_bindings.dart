import 'package:get/get.dart';
import 'package:social_media/manage/controller/information_controller.dart';

class InformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InformationController());
  }
}
