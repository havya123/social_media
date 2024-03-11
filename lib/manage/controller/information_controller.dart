import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/extension/snackbar.dart';
import 'package:social_media/manage/controller/register_controller.dart';
import 'package:social_media/repository/user_repo.dart';
import 'package:social_media/screen/information_screen/avatar_user.dart';
import 'package:social_media/screen/information_screen/infor_user.dart';

class InformationController extends GetxController {
  static InformationController get to => Get.find();

  RxString imagePath = RxString("");

  late PageController pageController;

  List<Widget> widgets = [const AvatarScreen(), const InforUserScreen()];

  late TextEditingController nameController;
  late TextEditingController emailController;
  String dob = "";

  @override
  onInit() {
    super.onInit();
    pageController = PageController();
    nameController = TextEditingController();
    emailController = TextEditingController();
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  Future<void> pickImageAvatarFromGallery() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      return Future.error("Storage permission is denied");
    }
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    imagePath.value = returnImage.path;
  }

  Future<void> pickImageAvatarFromCamera() async {
    var status = await Permission.camera.request();
    if (status.isDenied) {
      return Future.error("Camera permission is denied");
    }
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    imagePath.value = returnImage.path;
  }

  Future<void> updateImage(String userUID) async {
    await UserRepo().uploadImg(userUID, File(imagePath.value));
  }

  Future<void> updateInforUser() async {
    try {
      String uid = AppStore.to.uid.value;
      await UserRepo().updateName(uid, nameController.text);
      await UserRepo().updateEmail(uid, emailController.text);
      await UserRepo().updateDob(uid, dob);
      await UserRepo().updateStatusAccount(uid);
      MyDialogs.success(msg: "You have added information successfully");
    } catch (e) {
      MyDialogs.error(msg: "Something went wrong. Please try again");
      rethrow;
    }
  }
}
