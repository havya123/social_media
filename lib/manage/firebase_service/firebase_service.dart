import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/model/friend_request.dart';

import 'package:social_media/model/post.dart';
import 'package:social_media/model/user.dart';
import 'package:social_media/model/user_token.dart';

class FirebaseService {
  static final userRef =
      FirebaseFirestore.instance.collection('user').withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap(),
          );
  static final postRef =
      FirebaseFirestore.instance.collection('posts').withConverter<Post>(
            fromFirestore: (snapshot, _) => Post.fromMap(snapshot.data()!),
            toFirestore: (post, _) => post.toMap(),
          );
  static final requestRef = FirebaseFirestore.instance
      .collection('friendRequest')
      .withConverter<FriendRequest>(
        fromFirestore: (snapshot, _) => FriendRequest.fromMap(snapshot.data()!),
        toFirestore: (friendRequest, _) => friendRequest.toMap(),
      );
  static final deviceTokenRef = FirebaseFirestore.instance
      .collection('deviceToken')
      .withConverter<UserToken>(
        fromFirestore: (snapshot, _) => UserToken.fromMap(snapshot.data()!),
        toFirestore: (deviceToken, _) => deviceToken.toMap(),
      );
}
