import 'package:social_media/manage/firebase_service/firebase_service.dart';
import 'package:social_media/model/user.dart';

class UserRepo {
  Future<bool> register(String phone, String password) async {
    if (await checkEmailExist(phone)) {
      return false;
    }
    await FirebaseService.userRef
        .doc()
        .set(User(phone: phone, password: password));
    return true;
  }

  Future<User?> login(String phone) async {
    var response =
        await FirebaseService.userRef.where('phone', isEqualTo: phone).get();
    if (response.docs.isNotEmpty) {
      return response.docs.first.data();
    }

    return null;
  }

  Future<bool> checkEmailExist(String phone) async {
    await FirebaseService.userRef
        .where('email', isEqualTo: phone)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return true;
      }
    });
    return false;
  }
}
