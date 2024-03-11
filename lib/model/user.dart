import 'dart:convert';

class User {
  String phone;
  String uid;
  String username;
  String dob;
  String avatar;
  String email;
  String statusAccount;
  List<String> listPost;
  List<String> friends;
  User({
    required this.phone,
    required this.uid,
    required this.username,
    required this.dob,
    required this.avatar,
    required this.email,
    required this.statusAccount,
    required this.listPost,
    required this.friends,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'uid': uid,
      'username': username,
      'dob': dob,
      'avatar': avatar,
      'email': email,
      'statusAccount': statusAccount,
      'listPost': listPost,
      'friends': friends
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        phone: map['phone'] as String,
        uid: map['uid'] as String,
        username: map['username'] as String,
        dob: map['dob'] as String,
        avatar: map['avatar'] as String,
        email: map['email'] as String,
        statusAccount: map['statusAccount'] as String,
        listPost: List<String>.from(map['listPost']),
        friends: List<String>.from(map['friends']));
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
