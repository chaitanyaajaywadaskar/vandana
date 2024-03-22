import 'dart:convert';

GetFoodDetailListModel getFoodDetailListModelFromJson(String str) =>
    GetFoodDetailListModel.fromJson(json.decode(str));

String getFoodDetailListModelToJson(GetFoodDetailListModel data) =>
    json.encode(data.toJson());

class GetFoodDetailListModel {
  String? statusCode;
  String? status;
  String? message;
  List<ProductList>? productList;

  GetFoodDetailListModel({
    this.statusCode,
    this.status,
    this.message,
    this.productList,
  });

  factory GetFoodDetailListModel.fromJson(Map<String, dynamic> json) =>
      GetFoodDetailListModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        productList: List<ProductList>.from(
            json["product_list"].map((x) => ProductList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "product_list": (productList != null)
            ? List<dynamic>.from(productList!.map((x) => x.toJson()))
            : null,
      };
}

class ProductList {
  String? pid;
  String? categoryName;
  String? subcategoryName;
  String? productName;
  String? productCode;
  String? description;
  String? productImage1;
  String? productImage2;
  String? tax;
  String? price;
  String? mrp;
  String? dinnerLunchPrice;
  String? satSundayPrice;
  String? tiffinCount;
  String? subjiCount;
  String? itemAddStatus;
  String? itemAddQuantity;

  ProductList({
    this.pid,
    this.categoryName,
    this.subcategoryName,
    this.productName,
    this.productCode,
    this.description,
    this.productImage1,
    this.productImage2,
    this.tax,
    this.price,
    this.mrp,
    this.dinnerLunchPrice,
    this.satSundayPrice,
    this.tiffinCount,
    this.subjiCount,
    this.itemAddStatus,
    this.itemAddQuantity,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        pid: json["pid"],
        categoryName: json["category_name"],
        subcategoryName: json["subcategory_name"],
        productName: json["product_name"],
        productCode: json["product_code"],
        description: json["description"],
        productImage1: json["product_image1"],
        productImage2: json["product_image2"],
        tax: json["tax"],
        price: json["price"],
        mrp: json["mrp"],
        dinnerLunchPrice: json["dinner_lunch_price"],
        satSundayPrice: json["sat_sunday_price"],
        tiffinCount: json["tiffin_count"],
        subjiCount: json["subji_count"],
        itemAddStatus: json["item_add_status"],
        itemAddQuantity: json["item_add_quantity"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "category_name": categoryName,
        "subcategory_name": subcategoryName,
        "product_name": productName,
        "product_code": productCode,
        "description": description,
        "product_image1": productImage1,
        "product_image2": productImage2,
        "tax": tax,
        "price": price,
        "mrp": mrp,
        "dinner_lunch_price": dinnerLunchPrice,
        "sat_sunday_price": satSundayPrice,
        "tiffin_count": tiffinCount,
        "subji_count": subjiCount,
        "item_add_status": itemAddStatus,
        "item_add_quantity": itemAddQuantity,
      };
}
