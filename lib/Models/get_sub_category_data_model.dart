// To parse this JSON data, do
//
//     final subCategoryDataModel = subCategoryDataModelFromJson(jsonString);

import 'dart:convert';

SubCategoryDataModel subCategoryDataModelFromJson(String str) => SubCategoryDataModel.fromJson(json.decode(str));

String subCategoryDataModelToJson(SubCategoryDataModel data) => json.encode(data.toJson());

class SubCategoryDataModel {
    final String? statusCode;
    final String? status;
    final String? message;
    final List<SubcategoryList>? subcategoryList;

    SubCategoryDataModel({
        this.statusCode,
        this.status,
        this.message,
        this.subcategoryList,
    });

    factory SubCategoryDataModel.fromJson(Map<String, dynamic> json) => SubCategoryDataModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        subcategoryList: json["Subcategory_list"] == null ? [] : List<SubcategoryList>.from(json["Subcategory_list"]!.map((x) => SubcategoryList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "Subcategory_list": subcategoryList == null ? [] : List<dynamic>.from(subcategoryList!.map((x) => x.toJson())),
    };
}

class SubcategoryList {
    final String? id;
    final String? categoryName;
    final String? subcategoryName;
    final String? subcategoryImage;
     int count;

    SubcategoryList({
        this.id,
        this.categoryName,
        this.count = 0,
        this.subcategoryName,
        this.subcategoryImage,
    });

    factory SubcategoryList.fromJson(Map<String, dynamic> json) => SubcategoryList(
        id: json["id"],
        categoryName: json["category_name"],
        subcategoryName: json["subcategory_name"],
        subcategoryImage: json["subcategory_image"],
        count: 0
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "subcategory_name": subcategoryName,
        "subcategory_image": subcategoryImage,
        "count": count,
    };
}
