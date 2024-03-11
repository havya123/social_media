import 'package:get/get.dart';
import 'package:social_media/manage/controller/register_controller.dart';
import 'package:social_media/manage/controller/review_controller.dart';

class ReviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ReviewController());
  }
}
