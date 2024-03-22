import 'dart:convert';

GetSabjiListDaywiseModel getSabjiListDaywiseModelFromJson(String str) =>
    GetSabjiListDaywiseModel.fromJson(json.decode(str));

String getSabjiListDaywiseModelToJson(GetSabjiListDaywiseModel data) =>
    json.encode(data.toJson());

class GetSabjiListDaywiseModelSabjiList {
/*
{
  "id": "23",
  "sabji": "Dry Aloo Matar",
  "tiffin_type": "Lunch",
  "day": "Fri"
} 
*/

  String? id;
  String? sabji;
  String? tiffinType;
  String? day;

  GetSabjiListDaywiseModelSabjiList({
    this.id,
    this.sabji,
    this.tiffinType,
    this.day,
  });
  GetSabjiListDaywiseModelSabjiList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    sabji = json['sabji']?.toString();
    tiffinType = json['tiffin_type']?.toString();
    day = json['day']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['sabji'] = sabji;
    data['tiffin_type'] = tiffinType;
    data['day'] = day;
    return data;
  }
}

class GetSabjiListDaywiseModel {
/*
{
  "status_code": "200",
  "status": "success",
  "message": "Success",
  "sabji_list": [
    {
      "id": "23",
      "sabji": "Dry Aloo Matar",
      "tiffin_type": "Lunch",
      "day": "Fri"
    }
  ]
} 
*/

  String? statusCode;
  String? status;
  String? message;
  List<GetSabjiListDaywiseModelSabjiList?>? sabjiList;

  GetSabjiListDaywiseModel({
    this.statusCode,
    this.status,
    this.message,
    this.sabjiList,
  });
  GetSabjiListDaywiseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
    if (json['sabji_list'] != null) {
      final v = json['sabji_list'];
      final arr0 = <GetSabjiListDaywiseModelSabjiList>[];
      v.forEach((v) {
        arr0.add(GetSabjiListDaywiseModelSabjiList.fromJson(v));
      });
      sabjiList = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    if (sabjiList != null) {
      final v = sabjiList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['sabji_list'] = arr0;
    }
    return data;
  }
}
