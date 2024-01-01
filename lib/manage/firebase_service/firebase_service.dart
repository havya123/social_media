import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:social_media/model/user.dart';

class FirebaseService {
  static final userRef =
      FirebaseFirestore.instance.collection('user').withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap(),
          );
}
