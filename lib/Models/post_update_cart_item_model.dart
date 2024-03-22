import 'dart:convert';

PostUpdateCartItemModel postUpdateCartItemModelFromJson(String str) => PostUpdateCartItemModel.fromJson(json.decode(str));

String postUpdateCartItemModelToJson(PostUpdateCartItemModel data) => json.encode(data.toJson());

class PostUpdateCartItemModel {
  String? statusCode;
  String? status;
  String? message;

  PostUpdateCartItemModel({
    this.statusCode,
    this.status,
    this.message,
  });

  factory PostUpdateCartItemModel.fromJson(Map<String, dynamic> json) => PostUpdateCartItemModel(
    statusCode: json["status_code"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status": status,
    "message": message,
  };
}
