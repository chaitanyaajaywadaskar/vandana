import 'dart:convert';

GetCartItemsListModel getCartItemsListModelFromJson(String str) =>
    GetCartItemsListModel.fromJson(json.decode(str));

String getCartItemsListModelToJson(GetCartItemsListModel data) =>
    json.encode(data.toJson());

class GetCartItemsListModel {
  String? statusCode;
  String? status;
  String? message;
  List<CartItemList>? cartItemList;

  GetCartItemsListModel({
    this.statusCode,
    this.status,
    this.message,
    this.cartItemList,
  });

  factory GetCartItemsListModel.fromJson(Map<String, dynamic> json) {
    return GetCartItemsListModel(
      statusCode: json["status_code"],
      status: json["status"],
      message: json["message"],
      cartItemList: (json["Cart_Item_list"] != null)
          ? List<CartItemList>.from(
              json["Cart_Item_list"].map((x) => CartItemList.fromJson(x)))
          : null, // Handle null case here
    );
  }

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "Cart_Item_list":
            List<dynamic>.from(cartItemList!.map((x) => x.toJson())),
      };
}

class CartItemList {
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
  DateTime? date;
  String? productImage;

  CartItemList({
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
    this.date,
    this.productImage,
  });

  factory CartItemList.fromJson(Map<String, dynamic> json) => CartItemList(
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
        date: DateTime.parse(json["date"]),
        productImage: json["product_image"],
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
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "product_image": productImage,
      };
}
