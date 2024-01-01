import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickalert/quickalert.dart';
import 'package:social_media/repository/user_repo.dart';

class LoginController extends GetxController with StateMixin {
  RxBool showPass = true.obs;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    super.onInit();
  }

  loadData() async {
    Future.delayed(const Duration(seconds: 2), () {});
  }

  void hidePass() {
    showPass.value = !showPass.value;
  }

  Future<bool> register() async {
    await UserRepo()
        .register(userNameController.text, passWordController.text)
        .then((value) {
      if (value) {
        return false;
      }
    });
    return true;
  }

  Future<bool> login() async {
    var response = await UserRepo().login(userNameController.text);
    if (response != null) {
      if (passWordController.text == response.password) {
        return true;
      }
      return false;
    }
    return false;
  }

  void showDialog(context, QuickAlertType type, String message, String title,
      void Function()? function) {
    QuickAlert.show(
        context: context,
        type: type,
        text: message,
        title: title,
        onConfirmBtnTap: function);
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
