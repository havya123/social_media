import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/app/store/services.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/manage/controller/login_controller.dart';
import 'package:social_media/widgets/button.dart';
import 'package:social_media/widgets/input_widget.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: size(context).width,
          height: size(context).height,
          child: Stack(
            children: [
              Container(
                width: size(context).width,
                color: Colors.yellow,
                height: getHeight(context, height: 0.5),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: size(context).width,
                  height: getHeight(context, height: 0.65),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          spaceHeight(context),
                          TextFieldWidget(
                            hint: "Phone",
                            removeBorder: true,
                            controller: controller.userNameController,
                            type: TextInputType.phone,
                            numberOfLetter: 10,
                          ),
                          spaceHeight(context),
                          Obx(
                            () => TextFieldWidget(
                              removeBorder: true,
                              hint: 'Mật khẩu',
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
                              controller: controller.passWordController,
                            ),
                          ),
                          spaceHeight(context),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forget password?",
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ),
                          spaceHeight(context),
                          ButtonWidget(
                            function: () async {
                              await controller.login().then((value) {
                                if (value) {
                                  controller.showDialog(
                                    context,
                                    QuickAlertType.success,
                                    "Login Success",
                                    "Login",
                                    () {
                                      Get.toNamed(RouteName.categoryRoute);
                                    },
                                  );

                                  return;
                                }
                                controller.showDialog(
                                    context,
                                    QuickAlertType.error,
                                    "Login Failed",
                                    "Login",
                                    () {});
                                return;
                              });
                            },
                            textButton: "Login",
                          ),
                          spaceHeight(context),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: getWidth(context, width: 0.3),
                                height: 1,
                                color: Colors.black,
                              ),
                              const Text("OR LOGIN BY",
                                  style: TextStyle(fontSize: 18)),
                              Container(
                                width: getWidth(context, width: 0.3),
                                height: 1,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          spaceHeight(context),
                          GestureDetector(
                            onTap: () {
                              controller.signInWithGoogle();
                            },
                            child: Center(
                              child: Image.asset("assets/images/google.png"),
                            ),
                          ),
                          spaceHeight(context),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(RouteName.registerRoute);
                                  },
                                  child: const Text(
                                    "Register now",
                                    style: TextStyle(color: Colors.blue),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
