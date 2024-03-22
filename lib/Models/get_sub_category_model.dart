import 'dart:convert';

GetSubCategoryModel getSubCategoryModelFromJson(String str) =>
    GetSubCategoryModel.fromJson(json.decode(str));

String getSubCategoryModelToJson(GetSubCategoryModel data) =>
    json.encode(data.toJson());

class GetSubCategoryModel {
  String? statusCode;
  String? status;
  String? message;
  List<SubcategoryList>? subcategoryList;

  GetSubCategoryModel({
    this.statusCode,
    this.status,
    this.message,
    this.subcategoryList,
  });

  factory GetSubCategoryModel.fromJson(Map<String, dynamic> json) =>
      GetSubCategoryModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        subcategoryList: List<SubcategoryList>.from(
            json["Subcategory_list"].map((x) => SubcategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "Subcategory_list": (subcategoryList != null)
            ? List<dynamic>.from(subcategoryList!.map((x) => x.toJson()))
            : null,
      };
}

class SubcategoryList {
  String? id;
  String? categoryName;
  String? subcategoryName;
  String? subcategoryImage;

  SubcategoryList({
    this.id,
    this.categoryName,
    this.subcategoryName,
    this.subcategoryImage,
  });

  factory SubcategoryList.fromJson(Map<String, dynamic> json) =>
      SubcategoryList(
        id: json["id"],
        categoryName: json["category_name"],
        subcategoryName: json["subcategory_name"],
        subcategoryImage: json["subcategory_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "subcategory_name": subcategoryName,
        "subcategory_image": subcategoryImage,
      };
}
