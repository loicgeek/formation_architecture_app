import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PostModel {
  final int id;
  final String title;
  final String body;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
  toJson() {
    return {
      "id": id,
      "title": title,
      "body": body,
    };
  }
}
