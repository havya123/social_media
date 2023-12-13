import 'package:get/get.dart';
import 'package:social_media/manage/states/category_state.dart';

class CategoryController extends GetxController {
  int number = 1;
  final state = CategoryState();

  @override
  void onReady() {
    state.title.value = Get.arguments;
    super.onReady();
  }

  @override
  void onInit() {
    //
    super.onInit();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }
}
