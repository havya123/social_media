// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Post {
  String userId;
  String? content;
  String? image;
  String createdAt;
  int likeCount;
  Post({
    required this.userId,
    this.content,
    this.image,
    required this.createdAt,
    required this.likeCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'content': content,
      'image': image,
      'createdAt': createdAt,
      'likeCount': likeCount,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userId: map['userId'] as String,
      content: map['content'] ?? "",
      image: map['image'] ?? "",
      createdAt: map['createdAt'] as String,
      likeCount: map['likeCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
