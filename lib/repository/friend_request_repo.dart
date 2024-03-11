import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/manage/controller/register_controller.dart';
import 'package:social_media/manage/firebase_service/firebase_service.dart';
import 'package:social_media/model/friend_request.dart';
import 'package:social_media/model/user.dart';

class FriendRepo {
  Future<Map<String, dynamic>> fetchListUser(
      int pageSize, String? lastUserId) async {
    List<User> listUser = [];
    String lastUser = "";

    var usersRef = FirebaseService.userRef;

    var query = usersRef.orderBy(FieldPath.documentId);

    if (lastUserId != null) {
      query = query.startAfter([lastUserId]);
    }
    query = query.limit(pageSize);

    var querySnapshot = await query.get();
    List<String> listFriend = AppStore.to.listFriend;

    if (querySnapshot.docs.isNotEmpty) {
      for (var document in querySnapshot.docs) {
        User user = document.data();

        if (user.uid != AppStore.to.uid.value &&
            !listFriend.contains(user.uid)) {
          listUser.add(user);
          lastUser = document.id;
        }
      }
    }

    return {"listUser": listUser, "lastUser": lastUser};
  }

  Future<void> sendFriendRequest(
    String userSent,
    String userReceived,
  ) async {
    await FirebaseService.requestRef.doc().set(FriendRequest(
        userSent: userSent,
        userReceive: userReceived,
        statusRequest: "waiting"));
  }

  Future<bool> isSent(String userSent, String userReceived) async {
    var response = await FirebaseService.requestRef
        .where('userSent', isEqualTo: userSent)
        .where('userReceive', isEqualTo: userReceived)
        .get();
    if (response.docs.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> removeRequest(String userSent, String userReceive) async {
    var response = await FirebaseService.requestRef
        .where('userSent', isEqualTo: userSent)
        .where('userReceive', isEqualTo: userReceive)
        .get();
    await FirebaseService.requestRef.doc(response.docs.first.id).delete();
  }

  Future<List<FriendRequest>> listFriendComing(String userId) async {
    List<FriendRequest> listFriendComing = [];
    var response = await FirebaseService.requestRef
        .where('userReceive', isEqualTo: userId)
        .get();
    if (response.docs.isNotEmpty) {
      for (var user in response.docs) {
        listFriendComing.add(user.data());
      }
    }
    return listFriendComing;
  }

  Future<User?> getUser(String uid) async {
    var response =
        await FirebaseService.userRef.where('uid', isEqualTo: uid).get();
    if (response.docs.isNotEmpty) {
      return response.docs.first.data();
    }
    return null;
  }

  Future<void> acceptFriend(String uid, String friendUid) async {
    var response =
        await FirebaseService.userRef.where('uid', isEqualTo: uid).get();
    var friend =
        await FirebaseService.userRef.where('uid', isEqualTo: friendUid).get();

    if (response.docs.isNotEmpty) {
      List<String> listFriend = response.docs.first.data().friends;
      List<String> friendList = friend.docs.first.data().friends;
      listFriend.add(friendUid);
      friendList.add(uid);

      await FirebaseService.userRef
          .doc(response.docs.first.id)
          .update({'friends': listFriend});
      await FirebaseService.userRef
          .doc(friend.docs.first.id)
          .update({'friends': friendList});
      var request = await FirebaseService.requestRef
          .where('userReceive', isEqualTo: friendUid)
          .where('userSent', isEqualTo: uid)
          .get();
      await FirebaseService.requestRef.doc(request.docs.first.id).delete();
    }
  }

  Future<void> decline(String uid, String friendUid) async {
    var response = await FirebaseService.requestRef
        .where('userReceive', isEqualTo: uid)
        .where('userSent', isEqualTo: friendUid)
        .get();
    await FirebaseService.requestRef.doc(response.docs.first.id).delete();
  }
}
