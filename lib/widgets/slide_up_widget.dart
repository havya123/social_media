import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/manage/controller/create_post_controller.dart';

class SlideUpWidget extends StatelessWidget {
  const SlideUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CreatePostController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        children: [
          spaceHeight(context),
          option(context, "Add a photo", FontAwesomeIcons.image,
              controller.pickImageAvatarFromGallery),
          spaceHeight(context),
          option(context, "Add a video", FontAwesomeIcons.video, () {}),
          spaceHeight(context),
          option(context, "Add a photo", FontAwesomeIcons.image, () {}),
          spaceHeight(context),
          option(context, "Add a photo", FontAwesomeIcons.image, () {}),
          spaceHeight(context),
          option(context, "Add a photo", FontAwesomeIcons.image, () {}),
          spaceHeight(context),
          option(context, "Add a photo", FontAwesomeIcons.image, () {})
        ],
      ),
    );
  }
}

GestureDetector option(
        context, String title, IconData icon, Function function) =>
    GestureDetector(
      onTap: () {
        function();
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xff007Aff),
          ),
          spaceWidth(context),
          Text(
            title,
            style: largeTextStyle(context, size: 18),
          ),
        ],
      ),
    );
