import 'dart:convert';

PostLoginModel postLoginModelFromJson(String str) =>
    PostLoginModel.fromJson(json.decode(str));

String postLoginModelToJson(PostLoginModel data) => json.encode(data.toJson());

class PostLoginModel {
  String? statusCode;
  String? status;
  String? message;
  Result? result;

  PostLoginModel({
    this.statusCode,
    this.status,
    this.message,
    this.result,
  });

  factory PostLoginModel.fromJson(Map<String, dynamic> json) => PostLoginModel(
        statusCode: json["Status_code"],
        status: json["status"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "Status_code": statusCode,
        "status": status,
        "message": message,
        "result": result?.toJson(),
      };
}

class Result {
  String? id;
  String? phone;
  String? userType;
  String? customerCode;
  String? customerName;
  String? email;

  Result({
    this.id,
    this.phone,
    this.userType,
    this.customerCode,
    this.customerName,
    this.email,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        phone: json["phone"],
        userType: json["user_type"],
        customerCode: json["customer_code"],
        customerName: json["customer_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "user_type": userType,
        "customer_code": customerCode,
        "customer_name": customerName,
        "email": email,
      };
}
