import 'dart:convert';

GetOrderListModel getOrderListModelFromJson(String str) =>
    GetOrderListModel.fromJson(json.decode(str));

String getOrderListModelToJson(GetOrderListModel data) =>
    json.encode(data.toJson());

class GetOrderListModelOrderListItemList {
/*
{
  "id": "177",
  "so_number": "179",
  "category_name": "Food",
  "subcategory_name": "Addonitem_food",
  "product_name": "item1",
  "product_code": "PC24",
  "unit": "nos",
  "quantity": "1",
  "price": "15",
  "amount": "15.0",
  "tax": "2.5",
  "tax_sgst": "2.5",
  "tax_igst": "",
  "total": "15.0",
  "product_image": "https://softhubtechno.com/cloud_kitchen/uploads/dinner-61.jpg",
  "prod_name": "item1",
  "description": "add on item 1",
  "tax_percent": "5",
  "mrp": "20",
  "itemprice": "15"
} 
*/

  String? id;
  String? soNumber;
  String? categoryName;
  String? subcategoryName;
  String? productName;
  String? productCode;
  String? unit;
  String? quantity;
  String? price;
  String? amount;
  String? tax;
  String? taxSgst;
  String? taxIgst;
  String? total;
  String? productImage;
  String? prodName;
  String? description;
  String? taxPercent;
  String? mrp;
  String? itemprice;

  GetOrderListModelOrderListItemList({
    this.id,
    this.soNumber,
    this.categoryName,
    this.subcategoryName,
    this.productName,
    this.productCode,
    this.unit,
    this.quantity,
    this.price,
    this.amount,
    this.tax,
    this.taxSgst,
    this.taxIgst,
    this.total,
    this.productImage,
    this.prodName,
    this.description,
    this.taxPercent,
    this.mrp,
    this.itemprice,
  });
  GetOrderListModelOrderListItemList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    soNumber = json['so_number']?.toString();
    categoryName = json['category_name']?.toString();
    subcategoryName = json['subcategory_name']?.toString();
    productName = json['product_name']?.toString();
    productCode = json['product_code']?.toString();
    unit = json['unit']?.toString();
    quantity = json['quantity']?.toString();
    price = json['price']?.toString();
    amount = json['amount']?.toString();
    tax = json['tax']?.toString();
    taxSgst = json['tax_sgst']?.toString();
    taxIgst = json['tax_igst']?.toString();
    total = json['total']?.toString();
    productImage = json['product_image']?.toString();
    prodName = json['prod_name']?.toString();
    description = json['description']?.toString();
    taxPercent = json['tax_percent']?.toString();
    mrp = json['mrp']?.toString();
    itemprice = json['itemprice']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['so_number'] = soNumber;
    data['category_name'] = categoryName;
    data['subcategory_name'] = subcategoryName;
    data['product_name'] = productName;
    data['product_code'] = productCode;
    data['unit'] = unit;
    data['quantity'] = quantity;
    data['price'] = price;
    data['amount'] = amount;
    data['tax'] = tax;
    data['tax_sgst'] = taxSgst;
    data['tax_igst'] = taxIgst;
    data['total'] = total;
    data['product_image'] = productImage;
    data['prod_name'] = prodName;
    data['description'] = description;
    data['tax_percent'] = taxPercent;
    data['mrp'] = mrp;
    data['itemprice'] = itemprice;
    return data;
  }
}

class GetOrderListModelOrderList {
/*
{
  "id": "180",
  "so_number": "179",
  "order_date": "26-04-2024",
  "customer_name": "Chaitanya ",
  "customer_code": "VK79",
  "phone": "8080156839",
  "order_packaging_status": "N",
  "order_shipping_status": "N",
  "order_completed_status": "N",
  "total": "45.00",
  "branch_name": "Bavdhan",
  "branch_contactno": "9822113577",
  "coupon_amount": "0",
  "final_amount": 45,
  "order_category": "Food",
  "bname": null,
  "packaging_type": "Eco Friendly",
  "packaging_price": "30",
  "delivery_charges": "70",
  "item_list": [
    {
      "id": "177",
      "so_number": "179",
      "category_name": "Food",
      "subcategory_name": "Addonitem_food",
      "product_name": "item1",
      "product_code": "PC24",
      "unit": "nos",
      "quantity": "1",
      "price": "15",
      "amount": "15.0",
      "tax": "2.5",
      "tax_sgst": "2.5",
      "tax_igst": "",
      "total": "15.0",
      "product_image": "https://softhubtechno.com/cloud_kitchen/uploads/dinner-61.jpg",
      "prod_name": "item1",
      "description": "add on item 1",
      "tax_percent": "5",
      "mrp": "20",
      "itemprice": "15"
    }
  ]
} 
*/

  String? id;
  String? soNumber;
  String? orderDate;
  String? customerName;
  String? customerCode;
  String? phone;
  String? orderPackagingStatus;
  String? orderShippingStatus;
  String? orderCompletedStatus;
  String? total;
  String? branchName;
  String? branchContactno;
  String? couponAmount;
  int? finalAmount;
  String? orderCategory;
  String? bname;
  String? packagingType;
  String? packagingPrice;
  String? deliveryCharges;
  List<GetOrderListModelOrderListItemList?>? itemList;

  GetOrderListModelOrderList({
    this.id,
    this.soNumber,
    this.orderDate,
    this.customerName,
    this.customerCode,
    this.phone,
    this.orderPackagingStatus,
    this.orderShippingStatus,
    this.orderCompletedStatus,
    this.total,
    this.branchName,
    this.branchContactno,
    this.couponAmount,
    this.finalAmount,
    this.orderCategory,
    this.bname,
    this.packagingType,
    this.packagingPrice,
    this.deliveryCharges,
    this.itemList,
  });
  GetOrderListModelOrderList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    soNumber = json['so_number']?.toString();
    orderDate = json['order_date']?.toString();
    customerName = json['customer_name']?.toString();
    customerCode = json['customer_code']?.toString();
    phone = json['phone']?.toString();
    orderPackagingStatus = json['order_packaging_status']?.toString();
    orderShippingStatus = json['order_shipping_status']?.toString();
    orderCompletedStatus = json['order_completed_status']?.toString();
    total = json['total']?.toString();
    branchName = json['branch_name']?.toString();
    branchContactno = json['branch_contactno']?.toString();
    couponAmount = json['coupon_amount']?.toString();
    finalAmount = json['final_amount']?.toInt();
    orderCategory = json['order_category']?.toString();
    bname = json['bname']?.toString();
    packagingType = json['packaging_type']?.toString();
    packagingPrice = json['packaging_price']?.toString();
    deliveryCharges = json['delivery_charges']?.toString();
    if (json['item_list'] != null) {
      final v = json['item_list'];
      final arr0 = <GetOrderListModelOrderListItemList>[];
      v.forEach((v) {
        arr0.add(GetOrderListModelOrderListItemList.fromJson(v));
      });
      itemList = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['so_number'] = soNumber;
    data['order_date'] = orderDate;
    data['customer_name'] = customerName;
    data['customer_code'] = customerCode;
    data['phone'] = phone;
    data['order_packaging_status'] = orderPackagingStatus;
    data['order_shipping_status'] = orderShippingStatus;
    data['order_completed_status'] = orderCompletedStatus;
    data['total'] = total;
    data['branch_name'] = branchName;
    data['branch_contactno'] = branchContactno;
    data['coupon_amount'] = couponAmount;
    data['final_amount'] = finalAmount;
    data['order_category'] = orderCategory;
    data['bname'] = bname;
    data['packaging_type'] = packagingType;
    data['packaging_price'] = packagingPrice;
    data['delivery_charges'] = deliveryCharges;
    if (itemList != null) {
      final v = itemList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['item_list'] = arr0;
    }
    return data;
  }
}

class GetOrderListModel {
/*
{
  "status_code": "200",
  "status": "success",
  "message": "Order List",
  "order_list": [
    {
      "id": "180",
      "so_number": "179",
      "order_date": "26-04-2024",
      "customer_name": "Chaitanya ",
      "customer_code": "VK79",
      "phone": "8080156839",
      "order_packaging_status": "N",
      "order_shipping_status": "N",
      "order_completed_status": "N",
      "total": "45.00",
      "branch_name": "Bavdhan",
      "branch_contactno": "9822113577",
      "coupon_amount": "0",
      "final_amount": 45,
      "order_category": "Food",
      "bname": null,
      "packaging_type": "Eco Friendly",
      "packaging_price": "30",
      "delivery_charges": "70",
      "item_list": [
        {
          "id": "177",
          "so_number": "179",
          "category_name": "Food",
          "subcategory_name": "Addonitem_food",
          "product_name": "item1",
          "product_code": "PC24",
          "unit": "nos",
          "quantity": "1",
          "price": "15",
          "amount": "15.0",
          "tax": "2.5",
          "tax_sgst": "2.5",
          "tax_igst": "",
          "total": "15.0",
          "product_image": "https://softhubtechno.com/cloud_kitchen/uploads/dinner-61.jpg",
          "prod_name": "item1",
          "description": "add on item 1",
          "tax_percent": "5",
          "mrp": "20",
          "itemprice": "15"
        }
      ]
    }
  ]
} 
*/

  String? statusCode;
  String? status;
  String? message;
  List<GetOrderListModelOrderList?>? orderList;

  GetOrderListModel({
    this.statusCode,
    this.status,
    this.message,
    this.orderList,
  });
  GetOrderListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
    if (json['order_list'] != null) {
      final v = json['order_list'];
      final arr0 = <GetOrderListModelOrderList>[];
      v.forEach((v) {
        arr0.add(GetOrderListModelOrderList.fromJson(v));
      });
      orderList = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    if (orderList != null) {
      final v = orderList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['order_list'] = arr0;
    }
    return data;
  }
}
