import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media/app/assets/assets.dart';
import 'package:social_media/manage/firebase_service/firebase_service.dart';
import 'package:social_media/model/user.dart';
import 'package:social_media/model/user_token.dart';

class UserRepo {
  Future<void> register(String phone, String uid) async {
    await FirebaseService.userRef.doc().set(User(
          phone: phone,
          uid: uid,
          username: "",
          dob: "",
          avatar: AssetsName.defaultAvatar,
          email: "",
          statusAccount: "new",
          listPost: [],
          friends: [],
        ));
  }

  Future<bool> checkPhoneExist(String phone) async {
    var account =
        await FirebaseService.userRef.where('phone', isEqualTo: phone).get();
    if (account.docs.isNotEmpty) {
      if (account.docs.first.data().phone == phone) {
        return true;
      }
      return false;
    }
    return false;
  }

  // Stream<User?> getUser(String uid) {
  //   return FirebaseService.userRef
  //       .where('uid', isEqualTo: uid)
  //       .snapshots()
  //       .map((event) {
  //     if (event.docs.isNotEmpty) {
  //       return event.docs.first.data();
  //     } else {
  //       return null;
  //     }
  //   });
  // }

  Future<User> getUser(String uid) async {
    var response =
        await FirebaseService.userRef.where('uid', isEqualTo: uid).get();

  return response.docs.first.data();

  }

  Future<void> uploadImg(String userUID, File file) async {
    try {
      Reference ref =
          FirebaseStorage.instance.ref().child('images/users/$userUID.png');

      await ref.putFile(file);

      String downloadURL = await ref.getDownloadURL();
      await updateImg(downloadURL, userUID);
    } catch (e) {}
  }

  Future<void> updateImg(String urlImg, String uid) async {
    var repsonse =
        await FirebaseService.userRef.where('uid', isEqualTo: uid).get();

    if (repsonse.docs.isNotEmpty) {
      await FirebaseService.userRef
          .doc(repsonse.docs.first.id)
          .update({'avatar': urlImg});
    }
  }

  Future<void> updateName(String uid, String newName) async {
    var repsonse =
        await FirebaseService.userRef.where('uid', isEqualTo: uid).get();

    if (repsonse.docs.isNotEmpty) {
      await FirebaseService.userRef
          .doc(repsonse.docs.first.id)
          .update({'username': newName});
    }
  }

  Future<void> updateDob(String uid, String dob) async {
    var repsonse =
        await FirebaseService.userRef.where('uid', isEqualTo: uid).get();

    if (repsonse.docs.isNotEmpty) {
      await FirebaseService.userRef
          .doc(repsonse.docs.first.id)
          .update({'dob': dob});
    }
  }

  Future<void> updateEmail(String uid, String newEmail) async {
    var repsonse =
        await FirebaseService.userRef.where('uid', isEqualTo: uid).get();

    if (repsonse.docs.isNotEmpty) {
      await FirebaseService.userRef
          .doc(repsonse.docs.first.id)
          .update({'email': newEmail});
    }
  }

  Future<void> updateStatusAccount(String uid) async {
    await FirebaseService.userRef
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        FirebaseService.userRef
            .doc(value.docs.first.id)
            .update({'statusAccount': "old"});
      }
    });
  }
}
