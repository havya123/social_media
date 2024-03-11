import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/extension/snackbar.dart';
import 'package:social_media/manage/controller/notification_controller.dart';
import 'package:social_media/manage/controller/register_controller.dart';
import 'package:social_media/manage/firebase_service/firebase_service.dart';
import 'package:social_media/model/friend_request.dart';
import 'package:social_media/model/user.dart';
import 'package:social_media/repository/device_token_repo.dart';
import 'package:social_media/repository/friend_request_repo.dart';
import 'package:social_media/repository/user_repo.dart';
import 'package:social_media/screen/friend_screen/friend_tab/coming_friend.dart';
import 'package:social_media/screen/friend_screen/friend_tab/search_friend.dart';

class FriendController extends GetxController {
  static FriendController get to => Get.find<FriendController>();
  List<User> listUser = <User>[].obs;
  String? lastUserId;
  RxBool isLoading = true.obs;
  List<String> listType = [
    "Search Friend",
    "Friend Coming",
  ];
  List<Widget> listTab = [
    const SearchFriendScreen(),
    const ComingFriendScreen()
  ];
  RxList<String> listText = <String>[].obs;
  RxInt currentTab = 0.obs;
  RxList<FriendRequest> listFriendRequest = <FriendRequest>[].obs;
  RxList<User> listComing = <User>[].obs;

  void changeTab(int index) {
    currentTab.value = index;
  }

  void changeText(int index) {
    listText[index] == "Waiting"
        ? listText[index] = "Add Friend"
        : listText[index] = "Waiting";
  }

  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  Future<void> onLoading() async {
    await fetchUserList();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }

  @override
  void onInit() async {
    await fetchUserList();
    await getListRequest(AppStore.to.uid.value);
    await getComing();
    super.onInit();
  }

  Future<void> fetchUserList() async {
    try {
      isLoading.value = !isLoading.value;
      Map<String, dynamic> result =
          await FriendRepo().fetchListUser(2, lastUserId);
      lastUserId = result['lastUser'];
      List<User> list = result['listUser'];
      for (var user in list) {
        listUser.add(user);
        listText.add(await isSent(AppStore.to.uid.value, user.uid)
            ? "Waiting"
            : "Add Friend");
      }
      isLoading.value = !isLoading.value;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isSent(String userSent, String userReceive) async {
    return await FriendRepo().isSent(userSent, userReceive);
  }

  Future<void> sendFriendRequest(String userSent, String userReceived) async {
    try {
      await FriendRepo().sendFriendRequest(userSent, userReceived);
      String? userToken =
          await DeviceTokenRepo().checkDeviceTokenExist(userReceived);
      if (userToken != null) {
        String friendDeviceToken = await FirebaseService.deviceTokenRef
            .doc(userToken)
            .get()
            .then((value) {
          return value.data()!.deviceToken;
        });
        await NotificationController().sendFriendRequest(
            friendDeviceToken, "You have new friend request", "Friend Request");
      }

      MyDialogs.success(msg: "Sent request successfully");
    } catch (e) {}
  }

  Future<void> removeRequest(String userSent, String userReceive) async {
    try {
      await FriendRepo().removeRequest(userSent, userReceive);
      MyDialogs.error(msg: "You have canceled friend request");
    } catch (e) {
      MyDialogs.error(msg: "Something went wrong");
    }
  }

  Future<void> getListRequest(String userId) async {
    try {
      listFriendRequest.value = await FriendRepo().listFriendComing(userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getComing() async {
    for (var request in listFriendRequest) {
      User? user = await FriendRepo().getUser(request.userSent);
      listComing.add(user as User);
    }
  }

  Future<void> acceptFriend(
    String friendUid,
  ) async {
    try {
      await FriendRepo().acceptFriend(AppStore.to.uid.value, friendUid);
      MyDialogs.success(msg: "You have added new friend");
    } catch (e) {
      MyDialogs.error(msg: e.toString());
    }
  }

  Future<void> declineFriend(
    String friendUid,
  ) async {
    try {
      await FriendRepo().decline(AppStore.to.uid.value, friendUid);
      MyDialogs.success(msg: "You have delinced  friend");
    } catch (e) {
      MyDialogs.error(msg: e.toString());
    }
  }
}
