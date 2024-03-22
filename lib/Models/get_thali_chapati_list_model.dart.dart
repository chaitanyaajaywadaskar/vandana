import 'dart:convert';

GetThaliChapatiListModel getThaliChapatiModelFromJson(String str) =>
    GetThaliChapatiListModel.fromJson(json.decode(str));

String getThaliChapatiModelToJson(GetThaliChapatiListModel data) =>
    json.encode(data.toJson());

class GetThaliChapatiListModelProductList {
/*
{
  "sid": 1,
  "pid": "13",
  "category_name": "Thali With Chapati",
  "subcategory_name": "Regular",
  "product_name": "Matar and Malay Kofta Sabji 2 Chapati Rice",
  "product_code": "PC13",
  "description": "Sabji 2 Chapati Rice",
  "subjiname": "Matar and Malay Kofta ",
  "product_image1": "https://softhubtechno.com/cloud_kitchen/uploads/th13.jpeg",
  "product_image2": "https://softhubtechno.com/cloud_kitchen/uploads/",
  "tax": "0",
  "price": "120",
  "mrp": "140",
  "dinner_lunch_price": " ",
  "sat_sunday_price": " ",
  "tiffin_count": "",
  "subji_count": "2",
  "item_add_status": "true",
  "item_add_quantity": "1",
  "item_add_cartid": "134"
} 
*/

  int? sid;
  String? pid;
  String? categoryName;
  String? subcategoryName;
  String? productName;
  String? productCode;
  String? description;
  String? subjiname;
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
  String? itemAddCartid;

  GetThaliChapatiListModelProductList({
    this.sid,
    this.pid,
    this.categoryName,
    this.subcategoryName,
    this.productName,
    this.productCode,
    this.description,
    this.subjiname,
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
    this.itemAddCartid,
  });
  GetThaliChapatiListModelProductList.fromJson(Map<String, dynamic> json) {
    sid = json['sid']?.toInt();
    pid = json['pid']?.toString();
    categoryName = json['category_name']?.toString();
    subcategoryName = json['subcategory_name']?.toString();
    productName = json['product_name']?.toString();
    productCode = json['product_code']?.toString();
    description = json['description']?.toString();
    subjiname = json['subjiname']?.toString();
    productImage1 = json['product_image1']?.toString();
    productImage2 = json['product_image2']?.toString();
    tax = json['tax']?.toString();
    price = json['price']?.toString();
    mrp = json['mrp']?.toString();
    dinnerLunchPrice = json['dinner_lunch_price']?.toString();
    satSundayPrice = json['sat_sunday_price']?.toString();
    tiffinCount = json['tiffin_count']?.toString();
    subjiCount = json['subji_count']?.toString();
    itemAddStatus = json['item_add_status']?.toString();
    itemAddQuantity = json['item_add_quantity']?.toString();
    itemAddCartid = json['item_add_cartid']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sid'] = sid;
    data['pid'] = pid;
    data['category_name'] = categoryName;
    data['subcategory_name'] = subcategoryName;
    data['product_name'] = productName;
    data['product_code'] = productCode;
    data['description'] = description;
    data['subjiname'] = subjiname;
    data['product_image1'] = productImage1;
    data['product_image2'] = productImage2;
    data['tax'] = tax;
    data['price'] = price;
    data['mrp'] = mrp;
    data['dinner_lunch_price'] = dinnerLunchPrice;
    data['sat_sunday_price'] = satSundayPrice;
    data['tiffin_count'] = tiffinCount;
    data['subji_count'] = subjiCount;
    data['item_add_status'] = itemAddStatus;
    data['item_add_quantity'] = itemAddQuantity;
    data['item_add_cartid'] = itemAddCartid;
    return data;
  }
}

class GetThaliChapatiListModel {
/*
{
  "status_code": "200",
  "status": "success",
  "message": "Success",
  "product_list": [
    {
      "sid": 1,
      "pid": "13",
      "category_name": "Thali With Chapati",
      "subcategory_name": "Regular",
      "product_name": "Matar and Malay Kofta Sabji 2 Chapati Rice",
      "product_code": "PC13",
      "description": "Sabji 2 Chapati Rice",
      "subjiname": "Matar and Malay Kofta ",
      "product_image1": "https://softhubtechno.com/cloud_kitchen/uploads/th13.jpeg",
      "product_image2": "https://softhubtechno.com/cloud_kitchen/uploads/",
      "tax": "0",
      "price": "120",
      "mrp": "140",
      "dinner_lunch_price": " ",
      "sat_sunday_price": " ",
      "tiffin_count": "",
      "subji_count": "2",
      "item_add_status": "true",
      "item_add_quantity": "1",
      "item_add_cartid": "134"
    }
  ]
} 
*/

  String? statusCode;
  String? status;
  String? message;
  List<GetThaliChapatiListModelProductList?>? productList;

  GetThaliChapatiListModel({
    this.statusCode,
    this.status,
    this.message,
    this.productList,
  });
  GetThaliChapatiListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
    if (json['product_list'] != null) {
      final v = json['product_list'];
      final arr0 = <GetThaliChapatiListModelProductList>[];
      v.forEach((v) {
        arr0.add(GetThaliChapatiListModelProductList.fromJson(v));
      });
      productList = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    if (productList != null) {
      final v = productList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['product_list'] = arr0;
    }
    return data;
  }
}
