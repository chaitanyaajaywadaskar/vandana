import 'dart:convert';

PostEditAddressModel postEditAddressModelFromJson(String str) =>
    PostEditAddressModel.fromJson(json.decode(str));

String postEditAddressModelToJson(PostEditAddressModel data) =>
    json.encode(data.toJson());

class PostEditAddressModel {
  String? statusCode;
  String? status;
  String? message;

  PostEditAddressModel({
    this.statusCode,
    this.status,
    this.message,
  });

  factory PostEditAddressModel.fromJson(Map<String, dynamic> json) =>
      PostEditAddressModel(
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
