import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/manage/controller/register_controller.dart';
import 'package:social_media/screen/profile_screen/tab_screen/tab_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userController = Get.find<RegisterController>();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: getHeight(context, height: 0.4),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: getHeight(context, height: 0.33),
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 100,
                      width: 100,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xffE8E8E8),
                      ),
                      child: FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          placeholder: kTransparentImage,
                          image: AppStore.to.avatar.value),
                    ),
                  )
                ],
              ),
            ),
            spaceHeight(context),
            Text(
              AppStore.to.userName.value,
              style: largeTextStyle(context),
            ),
            spaceHeight(context, height: 0.02),
            Text(
              AppStore.to.email.value,
              style: smallTextStyle(context),
            ),
            spaceHeight(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: getHeight(context, height: 0.12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "50",
                              style: largeTextStyle(context),
                            ),
                            Text(
                              "Post",
                              style:
                                  smallTextStyle(context, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "50",
                              style: largeTextStyle(context),
                            ),
                            Text(
                              "Photo",
                              style:
                                  smallTextStyle(context, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "50",
                              style: largeTextStyle(context),
                            ),
                            Text(
                              "Followers",
                              style:
                                  smallTextStyle(context, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "50",
                              style: largeTextStyle(context),
                            ),
                            Text(
                              "Friend",
                              style:
                                  smallTextStyle(context, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            spaceHeight(context),
            const TabScreen()
          ],
        ),
      )),
    );
  }
}
