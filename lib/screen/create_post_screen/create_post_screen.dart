import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/manage/controller/create_post_controller.dart';
import 'package:social_media/manage/controller/register_controller.dart';
import 'package:social_media/widgets/slide_up_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class CreatePostScreen extends GetView<CreatePostController> {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userController = Get.find<RegisterController>();

    return Scaffold(
        body: GestureDetector(
      onTap: () => controller.closePanel(),
      child: SlidingUpPanel(
        maxHeight: getHeight(context, height: 0.5),
        panel: const SlideUpWidget(),
        controller: controller.panelController,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          FontAwesomeIcons.x,
                          color: Color(0xff848485),
                          size: 15,
                        )),
                    Text(
                      "Create Post",
                      style: mediumTextStyle(context,
                          color: const Color(0xff848485)),
                    ),
                    TextButton(
                        onPressed: () async {
                          await controller.createPost();
                          Future.delayed(
                              const Duration(seconds: 1), () => Get.back());
                        },
                        child: Text(
                          "Post",
                          style: mediumTextStyle(context,
                              color: const Color(0xff848485)),
                        )),
                  ],
                ),
                spaceHeight(context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: AppStore.to.avatar.value),
                      ),
                      spaceHeight(context),
                      TextFormField(
                        controller: controller.contentController,
                        onTap: () => controller.closePanel(),
                        decoration: const InputDecoration(
                          hintText: 'Write something...',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Obx(() {
                    if (controller.imagePath.isNotEmpty) {
                      return Stack(
                        children: [
                          Image.file(
                            File(controller.imagePath.value),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                  onPressed: () {
                                    controller.clearImage();
                                  },
                                  icon: const Icon(FontAwesomeIcons.x)))
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
