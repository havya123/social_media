import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/manage/controller/information_controller.dart';
import 'package:social_media/widgets/avatar_selected_widget.dart';
import 'package:social_media/widgets/button.dart';

class AvatarScreen extends StatelessWidget {
  const AvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<InformationController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                child: const Text(
                  "Skip >>",
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
                onPressed: () {},
              ),
            ),
            spaceHeight(context),
            Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xffE8E8E8),
              ),
              child: Stack(
                children: [
                  Obx(() {
                    if (controller.imagePath.isNotEmpty) {
                      return Container(
                        width: 192,
                        height: 192,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xffE8E8E8),
                        ),
                        child: Image.file(
                          File(controller.imagePath.value),
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return Image.network(
                        "https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg",
                        fit: BoxFit.cover,
                      );
                    }
                  }),
                  Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white),
                        child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const AvatarSelected();
                                },
                              );
                            },
                            icon: const Icon(FontAwesomeIcons.camera)),
                      ))
                ],
              ),
            ),
            spaceHeight(context, height: 0.3),
            ButtonWidget(
              function: () {
                controller.nextPage();
              },
              textButton: "Continue",
            )
          ],
        ),
      ),
    );
  }
}
