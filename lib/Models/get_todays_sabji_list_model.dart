
import 'dart:convert';

TodaysSabjiModel getTodaysSabjiModelFromJson(String str) =>
    TodaysSabjiModel.fromJson(json.decode(str));

String getSubCategoryModelToJson(TodaysSabjiModel data) =>
    json.encode(data.toJson());
    
class TodaysSabjiModelCheckSabjiList {
/*
{
  "id": "15",
  "sabji": "Methi",
  "tiffin_type": "Dinner"
} 
*/

  String? id;
  String? sabji;
  String? tiffinType;

  TodaysSabjiModelCheckSabjiList({
    this.id,
    this.sabji,
    this.tiffinType,
  });
  TodaysSabjiModelCheckSabjiList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    sabji = json['sabji']?.toString();
    tiffinType = json['tiffin_type']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['sabji'] = sabji;
    data['tiffin_type'] = tiffinType;
    return data;
  }
}

class TodaysSabjiModel {
/*
{
  "status_code": "200",
  "status": "success",
  "message": "Todays sabji list",
  "ttype": "Dinner",
  "check_sabji_list": [
    {
      "id": "15",
      "sabji": "Methi",
      "tiffin_type": "Dinner"
    }
  ]
} 
*/

  String? statusCode;
  String? status;
  String? message;
  String? ttype;
  List<TodaysSabjiModelCheckSabjiList?>? checkSabjiList;

  TodaysSabjiModel({
    this.statusCode,
    this.status,
    this.message,
    this.ttype,
    this.checkSabjiList,
  });
  TodaysSabjiModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
    ttype = json['ttype']?.toString();
    if (json['check_sabji_list'] != null) {
      final v = json['check_sabji_list'];
      final arr0 = <TodaysSabjiModelCheckSabjiList>[];
      v.forEach((v) {
        arr0.add(TodaysSabjiModelCheckSabjiList.fromJson(v));
      });
      checkSabjiList = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    data['ttype'] = ttype;
    if (checkSabjiList != null) {
      final v = checkSabjiList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['check_sabji_list'] = arr0;
    }
    return data;
  }
}
