import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/manage/controller/register_controller.dart';
import 'package:social_media/widgets/button.dart';
import 'package:social_media/widgets/input_widget.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: const Color(0xffD8DADC)),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  spaceHeight(context),
                  Container(
                    width: getWidth(context, width: 0.7),
                    height: getHeight(context, height: 0.3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.yellow),
                  ),
                  spaceHeight(context),
                  const Text(
                    "Create Account",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  spaceHeight(context, height: 0.1),
                  Obx(
                    () => TextFieldWidget(
                      removeBorder: true,
                      hint: 'Password',
                      isPass1: controller.showPass.value,
                      isPass: controller.showPass.value,
                      icon: IconButton(
                          onPressed: () {
                            controller.hidePass();
                          },
                          icon: Icon(
                            controller.showPass.value
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            color: Colors.black,
                          )),
                      minLetter: 8,
                      errorText: "Hãy nhập mật khẩu",
                      errorPass: "Nhập đủ 8 ký tự",
                      controller: controller.passwordController,
                    ),
                  ),
                  spaceHeight(context),
                  Obx(
                    () => TextFieldWidget(
                      removeBorder: true,
                      hint: 'Confirm password',
                      isPass1: controller.showPass.value,
                      isPass: controller.showPass.value,
                      icon: IconButton(
                          onPressed: () {
                            controller.hidePass();
                          },
                          icon: Icon(
                            controller.showPass.value
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            color: Colors.black,
                          )),
                      minLetter: 8,
                      errorText: "Hãy nhập mật khẩu",
                      errorPass: "Nhập đủ 8 ký tự",
                      controller: controller.confirmPassController,
                    ),
                  ),
                  spaceHeight(context),
                  ButtonWidget(
                    function: () async {
                      await controller.registerPhone(context);
                    },
                    textButton: " Finish",
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
