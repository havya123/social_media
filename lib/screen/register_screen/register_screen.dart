import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/widgets/button.dart';
import 'package:social_media/widgets/register_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  spaceHeight(context, height: 0.2),
                  RegisterButton(
                    suffixIcon: const Icon(Icons.phone),
                    function: () {
                      Get.toNamed(RouteName.phoneRegisterRoute);
                    },
                    textButton: "Register with Phone",
                    colorBorder: Colors.grey.shade500,
                    border: true,
                  ),
                  spaceHeight(context),
                  RegisterButton(
                    suffixIcon: Image.asset("assets/images/Google logo.png"),
                    function: () {},
                    textButton: "Register with Google",
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
                ]),
          ),
        ),
      ),
    );
  }
}
