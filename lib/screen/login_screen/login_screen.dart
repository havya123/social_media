import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/manage/controller/register_controller.dart';
import 'package:social_media/widgets/register_button.dart';

class LoginScreen extends GetView<RegisterController> {
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          spaceHeight(context),
                          const Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          spaceHeight(context, height: 0.1),
                          RegisterButton(
                            suffixIcon: const Icon(Icons.phone),
                            function: () {
                              Get.toNamed(RouteName.phoneRegisterRoute);
                            },
                            textButton: "Login with Phone",
                            colorBorder: Colors.grey.shade500,
                            border: true,
                          ),
                          spaceHeight(context),
                          RegisterButton(
                            suffixIcon:
                                Image.asset("assets/images/Google logo.png"),
                            function: () {
                              controller.signInWithGoogle();
                            },
                            textButton: "Login with Google",
                            colorBorder: Colors.grey.shade500,
                            border: true,
                          ),
                          spaceHeight(context, height: 0.1),
                          SizedBox(
                            width: getWidth(context, width: 0.7),
                            height: getHeight(context, height: 0.1),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    'By creating an account or signing you agree to our ',
                                style: const TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Terms and Conditions',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print("Terms and Conditions clicked!");
                                      },
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
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
