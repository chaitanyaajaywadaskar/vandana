import 'dart:convert';

UpdateSubjiModel updateSubjiModelFromJson(String str) =>
    UpdateSubjiModel.fromJson(json.decode(str));

String updateSubjiModelToJson(UpdateSubjiModel data) =>
    json.encode(data.toJson());

class UpdateSubjiModel {
/*
{
  "status_code": "200",
  "status": "success",
  "message": "Subji update Successfully..."
} 
*/

  String? statusCode;
  String? status;
  String? message;

  UpdateSubjiModel({
    this.statusCode,
    this.status,
    this.message,
  });
  UpdateSubjiModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
