import 'dart:convert';

GetCategoryListModel getCategoryListModelFromJson(String str) =>
    GetCategoryListModel.fromJson(json.decode(str));

String getCategoryListModelToJson(GetCategoryListModel data) =>
    json.encode(data.toJson());

class GetCategoryListModel {
  String? statusCode;
  String? status;
  String? message;
  List<CategoryList>? categoryList;

  GetCategoryListModel({
    this.statusCode,
    this.status,
    this.message,
    this.categoryList,
  });

  factory GetCategoryListModel.fromJson(Map<String, dynamic> json) =>
      GetCategoryListModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        categoryList: List<CategoryList>.from(
            json["category_list"].map((x) => CategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "category_list": (categoryList != null)
            ? List<dynamic>.from(categoryList!.map((x) => x.toJson()))
            : null,
      };
}

class CategoryList {
  String? id;
  String? categoryName;
  String? categoryImage;

  CategoryList({
    this.id,
    this.categoryName,
    this.categoryImage,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json["id"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "category_image": categoryImage,
      };
}
