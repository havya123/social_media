import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/manage/controller/register_controller.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/repository/post_repo.dart';

class ProfileController extends GetxController {
  RxMap listPost = {}.obs;
  StreamController<Map> postController = StreamController<Map>();
  Timer? _timer;

  List<String> listTab = [
    "Post",
    "Details",
  ];
  List<Widget> listWidget = [];

  RxInt currentTab = 0.obs;

  @override
  void onInit() {
    postController.add({'status': 'loading', 'listPost': listPost});
    getPost();
    super.onInit();
  }

  void changeTab(int index) {
    currentTab.value = index;
  }

  getPost() async {
    _timer?.cancel();
    List<String> listPostId = AppStore.to.listPost;
    List<Post> listPostUser = [];
    _timer = Timer(const Duration(seconds: 1), () async {
      for (var postId in listPostId) {
        Post post = await PostRepo().getPost(postId);
        listPostUser.add(post);
      }
      postController.add({'status': "done", 'listPost': listPostUser});
      listPost.bindStream(postController.stream);
    });
  }
}
