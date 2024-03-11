import 'package:social_media/manage/firebase_service/firebase_service.dart';
import 'package:social_media/model/user_token.dart';

class DeviceTokenRepo {
  Future<void> saveDeviceToken(String token, String uid) async {
    String? isExist = await checkDeviceTokenExist(uid);
    if (isExist != null) {
      await FirebaseService.deviceTokenRef
          .doc(isExist)
          .update({'deviceToken': token});
      return;
    }
    await FirebaseService.deviceTokenRef
        .doc()
        .set(UserToken(uid: uid, deviceToken: token));
  }

  Future<String?> checkDeviceTokenExist(String uid) async {
    var response =
        await FirebaseService.deviceTokenRef.where('uid', isEqualTo: uid).get();
    if (response.docs.isNotEmpty) {
      return response.docs.first.id;
    }
    return null;
  }
}
