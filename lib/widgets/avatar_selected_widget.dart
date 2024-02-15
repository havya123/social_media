import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/manage/controller/information_controller.dart';

class AvatarSelected extends GetView<InformationController> {
  const AvatarSelected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1,
      child: Column(
        children: [
          spaceHeight(context),
          Column(
            children: [
              Container(
                width: 150,
                height: 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Obx(() {
                  if (controller.imagePath.isNotEmpty) {
                    return Image.file(
                      File(controller.imagePath.value),
                      fit: BoxFit.cover,
                    );
                  } else {
                    return Image.network(
                      "https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg",
                      fit: BoxFit.cover,
                    );
                  }
                }),
              ),
              spaceHeight(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Thoát"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await controller.updateImage(AppStore.to.uid);
                      Get.back();
                    },
                    child: const Text("Lưu"),
                  ),
                ],
              ),
            ],
          ),
          spaceHeight(context),
          TextButton(
            onPressed: () async {
              controller.pickImageAvatarFromGallery();
            },
            child: const Text('Lấy ảnh từ thư viện'),
          ),
          TextButton(
            onPressed: () {
              controller.pickImageAvatarFromCamera();
            },
            child: const Text('Lấy ảnh từ camera'),
          ),
        ],
      ),
    );
  }
}
