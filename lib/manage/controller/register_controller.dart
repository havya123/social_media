import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pinput/pinput.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/app/store/services.dart';
import 'package:social_media/app/util/key.dart';
import 'package:social_media/model/user.dart';
import 'package:social_media/repository/device_token_repo.dart';
import 'package:social_media/repository/user_repo.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find<RegisterController>();

  late TextEditingController phoneNumber;

  bool tokenExpired = true;

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

  @override
  void onInit() async {
    phoneNumber = TextEditingController();
    super.onInit();
  }

  void startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value -= 1;
      } else {
        return;
      }
    });
  }

  void resetCountDown() {
    countdown.value = 30;
    startCountdown();
  }

  @override
  void onClose() {
    phoneNumber.dispose();
    super.onInit();
  }

  Future<void> sentOtp(context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+84${phoneNumber.text}",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Center(
                        child: Text('The provided phone number is not valid')),
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
            return;
          }
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(child: Text('Failed to send OTP')),
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
                  title: const Center(child: Text('OTP Sent Successfully')),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Your OTP is sent to your phone'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Get.back();
                        Get.toNamed(RouteName.otpRoute);
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

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      String uid = userCredential.user!.uid;
      String token = await userCredential.user!.getIdToken() as String;
      AppServices.to.setString(MyKey.uid, token);
      String deviceToken =
          await FirebaseMessaging.instance.getToken() as String;
      AppServices.to.setString(MyKey.deviceToken, deviceToken);
      await DeviceTokenRepo().saveDeviceToken(token, uid);

      if (userCredential.user != null) {
        login(phoneNumber.text, uid);
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

  Future<void> login(
    String phone,
    String uid,
  ) async {
    bool exist = await UserRepo().checkPhoneExist(phone);
    User user = await (UserRepo().getUser(uid));
    AppStore.to.updateUser(user);
    AppServices.to.setString(MyKey.user, jsonEncode(user));
    
    await Future.delayed(const Duration(seconds: 2), () {});

    if (exist) {
      Get.offNamed(RouteName.categoryRoute);
    } else {
      await UserRepo().register(phone, uid);
      Get.offNamed(RouteName.categoryRoute);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
