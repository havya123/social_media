import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media/manage/firebase_service/firebase_service.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/model/user.dart';

class PostRepo {
  Future<void> createPost(String userId, String? content, File file) async {
    DateTime currentTime = DateTime.now();
    String createdAt = currentTime.toString();
    DocumentReference postRef = FirebaseService.postRef.doc();
    await postRef.set(Post(
        userId: userId,
        createdAt: createdAt,
        likeCount: 0,
        image: "",
        content: content));

    var url = await uploadImg(postRef.id, file);
    await updateImg(url, postRef.id);

    var response =
        await FirebaseService.userRef.where('uid', isEqualTo: userId).get();
    if (response.docs.isNotEmpty) {
      User user = response.docs.first.data();
      List<String> currentPost = user.listPost;
      currentPost.add(postRef.id);

      await FirebaseService.userRef
          .doc(response.docs.first.id)
          .update({'listPost': currentPost});
    }
  }

  Future<String> uploadImg(String postId, File file) async {
    try {
      Reference ref =
          FirebaseStorage.instance.ref().child('images/users/$postId.png');

      await ref.putFile(file);

      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return "";
    }
  }

  Future<void> updateImg(String urlImg, String postId) async {
    await FirebaseService.postRef.doc(postId).update({'image': urlImg});
  }

  Future<List<Post>> getAllPost() async {
    List<Post> listUserPost = [];
    var response = await FirebaseService.postRef.get();
    listUserPost = response.docs.map((e) => e.data()).toList();
    return listUserPost;
  }

  Future<Post> getPost(String postId) async {
    var response = await FirebaseService.postRef.doc(postId).get();
    Post post = response.data() as Post;
    return post;
  }
}
