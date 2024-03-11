import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FriendRequest {
  String userSent;
  String userReceive;
  String statusRequest;
  FriendRequest({
    required this.userSent,
    required this.userReceive,
    required this.statusRequest,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userSent': userSent,
      'userReceive': userReceive,
      'statusRequest': statusRequest,
    };
  }

  factory FriendRequest.fromMap(Map<String, dynamic> map) {
    return FriendRequest(
      userSent: map['userSent'] as String,
      userReceive: map['userReceive'] as String,
      statusRequest: map['statusRequest'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendRequest.fromJson(String source) =>
      FriendRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
