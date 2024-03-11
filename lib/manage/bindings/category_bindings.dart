import 'package:get/get.dart';
import 'package:social_media/manage/controller/category_controller.dart';
import 'package:social_media/manage/controller/notification_controller.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => CategoryController());
    await Get.putAsync(() => NotificationController().init());
  }
}
