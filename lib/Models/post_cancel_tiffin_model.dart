import 'dart:convert';

PostCancelTiffinModel postCancelModelFromJson(String str) =>
    PostCancelTiffinModel.fromJson(json.decode(str));

String postCancelModelToJson(PostCancelTiffinModel data) =>
    json.encode(data.toJson());
class PostCancelTiffinModelTiffinCancelDetails {
/*
{
  "id": "2",
  "customer_code": "VK11",
  "phone": "9325612162",
  "branch_name": "mr0035",
  "so_number": "128",
  "tiffintype_lunch": "Lunch",
  "tiffintype_dinner": "",
  "tiffin_cancel_date": "2024-04-16",
  "date": "2024-04-11"
} 
*/

  String? id;
  String? customerCode;
  String? phone;
  String? branchName;
  String? soNumber;
  String? tiffintypeLunch;
  String? tiffintypeDinner;
  String? tiffinCancelDate;
  String? date;

  PostCancelTiffinModelTiffinCancelDetails({
    this.id,
    this.customerCode,
    this.phone,
    this.branchName,
    this.soNumber,
    this.tiffintypeLunch,
    this.tiffintypeDinner,
    this.tiffinCancelDate,
    this.date,
  });
  PostCancelTiffinModelTiffinCancelDetails.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    customerCode = json['customer_code']?.toString();
    phone = json['phone']?.toString();
    branchName = json['branch_name']?.toString();
    soNumber = json['so_number']?.toString();
    tiffintypeLunch = json['tiffintype_lunch']?.toString();
    tiffintypeDinner = json['tiffintype_dinner']?.toString();
    tiffinCancelDate = json['tiffin_cancel_date']?.toString();
    date = json['date']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['customer_code'] = customerCode;
    data['phone'] = phone;
    data['branch_name'] = branchName;
    data['so_number'] = soNumber;
    data['tiffintype_lunch'] = tiffintypeLunch;
    data['tiffintype_dinner'] = tiffintypeDinner;
    data['tiffin_cancel_date'] = tiffinCancelDate;
    data['date'] = date;
    return data;
  }
}

class PostCancelTiffinModel {
/*
{
  "status_code": "200",
  "status": "success",
  "message": "Tiffin Cancelled Successfully",
  "Tiffin_cancel_Details": {
    "id": "2",
    "customer_code": "VK11",
    "phone": "9325612162",
    "branch_name": "mr0035",
    "so_number": "128",
    "tiffintype_lunch": "Lunch",
    "tiffintype_dinner": "",
    "tiffin_cancel_date": "2024-04-16",
    "date": "2024-04-11"
  }
} 
*/

  String? statusCode;
  String? status;
  String? message;
  PostCancelTiffinModelTiffinCancelDetails? TiffinCancelDetails;

  PostCancelTiffinModel({
    this.statusCode,
    this.status,
    this.message,
    this.TiffinCancelDetails,
  });
  PostCancelTiffinModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
    TiffinCancelDetails = (json['Tiffin_cancel_Details'] != null)
        ? PostCancelTiffinModelTiffinCancelDetails.fromJson(
            json['Tiffin_cancel_Details'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    if (TiffinCancelDetails != null) {
      data['Tiffin_cancel_Details'] = TiffinCancelDetails!.toJson();
    }
    return data;
  }
}
