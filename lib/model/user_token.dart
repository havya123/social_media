import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserToken {
  String uid;
  String deviceToken;
  UserToken({
    required this.uid,
    required this.deviceToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'deviceToken': deviceToken,
    };
  }

  factory UserToken.fromMap(Map<String, dynamic> map) {
    return UserToken(
      uid: map['uid'] as String,
      deviceToken: map['deviceToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserToken.fromJson(String source) =>
      UserToken.fromMap(json.decode(source) as Map<String, dynamic>);
}
