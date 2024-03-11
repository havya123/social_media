import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:get/get.dart';
import 'package:social_media/app/store/services.dart';
import 'package:social_media/app/util/key.dart';
import 'package:social_media/model/user.dart';

class AppStore extends GetxController {
  static AppStore get to => Get.find();
  bool firstRun = false;
  String token = "";
  String deviceToken = "";
  Rx<User?> user = Rx<User?>(null);
  RxString userName = ''.obs;
  RxString avatar = "".obs;
  RxString uid = "".obs;
  RxString email = "".obs;
  RxString statusAccount = "".obs;
  RxList<String> listPost = <String>[].obs;
  RxList<String> listFriend = <String>[].obs;

  @override
  void onInit() async {
    String result = AppServices.to.getString(MyKey.firstRun);
    token = AppServices.to.getString(MyKey.uid);
    deviceToken = AppServices.to.getString(MyKey.deviceToken);
    User? user = jsonDecode(AppServices.to.getString(MyKey.user));
    if (user != null) {
      updateUser(user);
    }
    if (result.isNotEmpty) {
      firstRun = jsonDecode(result);
    }

    super.onInit();
  }

  Future<void> updateUser(User user) async {
    userName.value = user.username;
    avatar.value = user.avatar;
    listPost.value = user.listPost;
    uid.value = user.uid;
    statusAccount.value = user.statusAccount;
    listFriend.value = user.friends;
    email.value = user.email;
  }
}
