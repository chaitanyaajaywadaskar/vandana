import 'dart:convert';

GetAddressListModel getAddressListModelFromJson(String str) =>
    GetAddressListModel.fromJson(json.decode(str));

String getAddressListModelToJson(GetAddressListModel data) =>
    json.encode(data.toJson());

class GetAddressListModelAddressList {
/*
{
  "id": "65",
  "customer_code": "VK79",
  "user_type": "User",
  "phone": "8080156839",
  "address_type": "Home",
  "state": "Maharashtra",
  "city": "Pune",
  "pincode": "411021",
  "address": "High Class Society, , , Bavdhan, Pune, Maharashtra 411021, India",
  "lat_long": "18.5204261 73.7720075",
  "receivers_name": "Chaitanya ",
  "contact_no": "8080156839",
  "branch": "Bavdhan",
  "date": "2024-04-16",
  "bname": null
} 
*/

  String? id;
  String? customerCode;
  String? userType;
  String? phone;
  String? addressType;
  String? state;
  String? city;
  String? pincode;
  String? address;
  String? latLong;
  String? receiversName;
  String? contactNo;
  String? branch;
  String? date;
  String? bname;

  GetAddressListModelAddressList({
    this.id,
    this.customerCode,
    this.userType,
    this.phone,
    this.addressType,
    this.state,
    this.city,
    this.pincode,
    this.address,
    this.latLong,
    this.receiversName,
    this.contactNo,
    this.branch,
    this.date,
    this.bname,
  });
  GetAddressListModelAddressList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    customerCode = json['customer_code']?.toString();
    userType = json['user_type']?.toString();
    phone = json['phone']?.toString();
    addressType = json['address_type']?.toString();
    state = json['state']?.toString();
    city = json['city']?.toString();
    pincode = json['pincode']?.toString();
    address = json['address']?.toString();
    latLong = json['lat_long']?.toString();
    receiversName = json['receivers_name']?.toString();
    contactNo = json['contact_no']?.toString();
    branch = json['branch']?.toString();
    date = json['date']?.toString();
    bname = json['bname']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['customer_code'] = customerCode;
    data['user_type'] = userType;
    data['phone'] = phone;
    data['address_type'] = addressType;
    data['state'] = state;
    data['city'] = city;
    data['pincode'] = pincode;
    data['address'] = address;
    data['lat_long'] = latLong;
    data['receivers_name'] = receiversName;
    data['contact_no'] = contactNo;
    data['branch'] = branch;
    data['date'] = date;
    data['bname'] = bname;
    return data;
  }
}

class GetAddressListModel {
/*
{
  "status_code": "200",
  "status": "success",
  "message": "Address List",
  "address_list": [
    {
      "id": "65",
      "customer_code": "VK79",
      "user_type": "User",
      "phone": "8080156839",
      "address_type": "Home",
      "state": "Maharashtra",
      "city": "Pune",
      "pincode": "411021",
      "address": "High Class Society, , , Bavdhan, Pune, Maharashtra 411021, India",
      "lat_long": "18.5204261 73.7720075",
      "receivers_name": "Chaitanya ",
      "contact_no": "8080156839",
      "branch": "Bavdhan",
      "date": "2024-04-16",
      "bname": null
    }
  ]
} 
*/

  String? statusCode;
  String? status;
  String? message;
  List<GetAddressListModelAddressList?>? addressList;

  GetAddressListModel({
    this.statusCode,
    this.status,
    this.message,
    this.addressList,
  });
  GetAddressListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
  if (json['address_list'] != null) {
  final v = json['address_list'];
  final arr0 = <GetAddressListModelAddressList>[];
  v.forEach((v) {
  arr0.add(GetAddressListModelAddressList.fromJson(v));
  });
    addressList = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    if (addressList != null) {
      final v = addressList;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['address_list'] = arr0;
    }
    return data;
  }
}
