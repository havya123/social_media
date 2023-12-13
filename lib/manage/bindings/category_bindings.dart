import 'package:get/get.dart';
import 'package:social_media/manage/controller/category_controller.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController());
  }
}
