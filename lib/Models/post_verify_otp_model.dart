import 'dart:convert';

PostVerifyOtpModel postVerifyOtpModelFromJson(String str) =>
    PostVerifyOtpModel.fromJson(json.decode(str));

String postVerifyOtpModelToJson(PostVerifyOtpModel data) =>
    json.encode(data.toJson());

class PostVerifyOtpModel {
  String? statusCode;
  String? status;
  String? message;
  RegisterDetails? registerDetails;

  PostVerifyOtpModel({
    this.statusCode,
    this.status,
    this.message,
    this.registerDetails,
  });

  factory PostVerifyOtpModel.fromJson(Map<String, dynamic> json) =>
      PostVerifyOtpModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        registerDetails: RegisterDetails.fromJson(json["register_details"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "register_details": registerDetails?.toJson(),
      };
}

class RegisterDetails {
  String? id;
  String? customerName;
  String? customerCode;
  String? email;
  String? phone;
  String? userType;

  RegisterDetails({
    this.id,
    this.customerName,
    this.customerCode,
    this.email,
    this.phone,
    this.userType,
  });

  factory RegisterDetails.fromJson(Map<String, dynamic> json) =>
      RegisterDetails(
        id: json["id"],
        customerName: json["customer_name"],
        customerCode: json["customer_code"],
        email: json["email"],
        phone: json["phone"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_name": customerName,
        "customer_code": customerCode,
        "email": email,
        "phone": phone,
        "user_type": userType,
      };
}
