import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pinput/pinput.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/repository/user_repo.dart';

class RegisterController extends GetxController {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  RxInt countdown = 30.obs;
  RxBool isCountingDown = false.obs;
  String verifyID = "";
  RxBool isSent = false.obs;

  Timer? _timer;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(15),
    ),
  );

  final errorPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.red),
      borderRadius: BorderRadius.circular(15),
    ),
  );

  RxBool showPass = true.obs;

  void hidePass() {
    showPass.value = !showPass.value;
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value -= 1;
      } else {
        return;
      }
    });
  }

  void resetCountDown() {
    _timer?.cancel();
    countdown.value = 30;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> sentOtp(context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+84${phoneNumber.text}",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(child: Text('Gửi mã OTP thất bại')),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(e.code.toString()),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                );
              });
        },
        codeSent: (String verificationId, int? resendToken) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                isSent.value = true;
                return AlertDialog(
                  title: const Center(child: Text('Gửi mã OTP thành công')),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Mã OTP đã được gửi vào số điện thoại của bạn'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                );
              });
          verifyID = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      return;
    }
  }

  Future<void> confirmOtp(context, String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyID,
        smsCode: otp,
      );

      // Sign in with the credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        // SMS code verification is successful
        Get.toNamed(RouteName.passwordRoute)!
            .then((value) => Get.back(result: value ?? []));
      } else {
        // Verification failed
      }
    } catch (e) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text('Sai mã OTP')),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Bạn đã nhập sai mã OTP. Hãy kiểm tra mã OTP và nhập lại'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> registerPhone(context) async {
    if (passwordController.text == confirmPassController.text) {
      await UserRepo()
          .register(phoneNumber.text, confirmPassController.text)
          .then((value) => Get.toNamed(RouteName.loginRoute));
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text('Mật khẩu không trùng khớp')),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Mật khẩu không trùng khớp'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
