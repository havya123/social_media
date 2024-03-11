import 'package:get/get.dart';
import 'package:social_media/manage/states/category_state.dart';
import 'package:social_media/model/user.dart';

class CategoryController extends GetxController {
  int number = 1;
  final state = CategoryState();

  User? user;

  @override
  void onReady() {
    state.title.value = Get.arguments;
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }
}
