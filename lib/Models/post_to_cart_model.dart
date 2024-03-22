import 'dart:convert';

PostToCartModel postToCartModelFromJson(String str) =>
    PostToCartModel.fromJson(json.decode(str));

String postToCartModelToJson(PostToCartModel data) =>
    json.encode(data.toJson());

class PostToCartModel {
  String? statusCode;
  String? status;
  String? message;
  CartItemDetails? cartItemDetails;

  PostToCartModel({
    this.statusCode,
    this.status,
    this.message,
    this.cartItemDetails,
  });

  factory PostToCartModel.fromJson(Map<String, dynamic> json) =>
      PostToCartModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        cartItemDetails: (json["Cart_Item_Details"] != null)
            ? CartItemDetails.fromJson(json["Cart_Item_Details"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "Cart_Item_Details": cartItemDetails?.toJson(),
      };
}

class CartItemDetails {
  String? id;
  String? categoryName;
  String? subcategoryName;
  String? productName;
  String? productCode;
  String? unit;
  String? quantity;
  String? price;
  String? total;
  String? tax;
  String? username;
  String? userType;

  CartItemDetails({
    this.id,
    this.categoryName,
    this.subcategoryName,
    this.productName,
    this.productCode,
    this.unit,
    this.quantity,
    this.price,
    this.total,
    this.tax,
    this.username,
    this.userType,
  });

  factory CartItemDetails.fromJson(Map<String, dynamic> json) =>
      CartItemDetails(
        id: json["id"],
        categoryName: json["category_name"],
        subcategoryName: json["subcategory_name"],
        productName: json["product_name"],
        productCode: json["product_code"],
        unit: json["unit"],
        quantity: json["quantity"],
        price: json["price"],
        total: json["total"],
        tax: json["tax"],
        username: json["username"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "subcategory_name": subcategoryName,
        "product_name": productName,
        "product_code": productCode,
        "unit": unit,
        "quantity": quantity,
        "price": price,
        "total": total,
        "tax": tax,
        "username": username,
        "user_type": userType,
      };
}
