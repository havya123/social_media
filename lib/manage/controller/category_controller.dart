import 'package:get/get.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/manage/states/category_state.dart';
import 'package:social_media/model/user.dart';
import 'package:social_media/repository/user_repo.dart';

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
  void onInit() {
    getUser(AppStore.to.uid);
    super.onInit();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  Future<User?> getUser(String uid) async {
    var response = await UserRepo().getUser(uid);

    if (response != null) {
      user = response;
      return user;
    }
    return null;
  }
}
