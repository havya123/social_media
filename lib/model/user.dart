import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String phone;
  String uid;
  String username;
  String dob;
  String avatar;
  String email;
  String statusAccount;
  User({
    required this.phone,
    required this.uid,
    required this.username,
    required this.dob,
    required this.avatar,
    required this.email,
    required this.statusAccount,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
