import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/extension/snackbar.dart';
import 'package:social_media/manage/controller/register_controller.dart';
import 'package:social_media/repository/post_repo.dart';

class CreatePostController extends GetxController {
  static CreatePostController get to => Get.find();

  String selectOption = "";
  FocusNode focusPanel = FocusNode();
  List<String> listOption = [
    'Public',
    'Friends',
  ];
  TextEditingController contentController = TextEditingController();

  var panelController = PanelController();

  RxString imagePath = "".obs;

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

  void clearImage() {
    imagePath.value = "";
  }

  void openPanel() {
    Future.delayed(Duration.zero, () {
      panelController.open();
    });
  }

  void closePanel() {
    panelController.close();
  }

  @override
  void onReady() {
    openPanel();
    super.onReady();
  }

  Future<void> createPost() async {
    try {
      await PostRepo().createPost(
          AppStore.to.uid.value, contentController.text, File(imagePath.value));
      MyDialogs.success(msg: "Create Post Successfully");
    } catch (e) {
      MyDialogs.error(msg: "Something went wrong. Please try again");
      rethrow;
    }
  }
}
