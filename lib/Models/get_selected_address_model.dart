import 'dart:convert';

GetSelectedAddressModel getSelectedAddressModelFromJson(String str) =>
    GetSelectedAddressModel.fromJson(json.decode(str));

String getSelectedAddressModelToJson(GetSelectedAddressModel data) =>
    json.encode(data.toJson());
class GetSelectedAddressModelUserSelectedAddress {
/*
{
  "id": "68",
  "customer_code": "VK79",
  "user_type": "User",
  "phone": "8080156839",
  "address_type": "Home",
  "state": "Maharashtra",
  "city": "Pune",
  "pincode": "411021",
  "address": "1st Floor, Office No 1, , Pashan Road, Bavdhan, Pune, Maharashtra 411021, India",
  "lat_long": "18.5203933 73.7720458",
  "receivers_name": "Chaitanya ",
  "contact_no": "8080156839",
  "branch": "mr0035",
  "date": "2024-04-16",
  "address_status": "selected",
  "bname": "Bavdhan"
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
  String? addressStatus;
  String? bname;

  GetSelectedAddressModelUserSelectedAddress({
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
    this.addressStatus,
    this.bname,
  });
  GetSelectedAddressModelUserSelectedAddress.fromJson(Map<String, dynamic> json) {
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
    addressStatus = json['address_status']?.toString();
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
    data['address_status'] = addressStatus;
    data['bname'] = bname;
    return data;
  }
}

class GetSelectedAddressModel {
/*
{
  "status_code": "200",
  "status": "success",
  "message": "Address List",
  "User_selected_address": [
    {
      "id": "68",
      "customer_code": "VK79",
      "user_type": "User",
      "phone": "8080156839",
      "address_type": "Home",
      "state": "Maharashtra",
      "city": "Pune",
      "pincode": "411021",
      "address": "1st Floor, Office No 1, , Pashan Road, Bavdhan, Pune, Maharashtra 411021, India",
      "lat_long": "18.5203933 73.7720458",
      "receivers_name": "Chaitanya ",
      "contact_no": "8080156839",
      "branch": "mr0035",
      "date": "2024-04-16",
      "address_status": "selected",
      "bname": "Bavdhan"
    }
  ]
} 
*/

  String? statusCode;
  String? status;
  String? message;
  List<GetSelectedAddressModelUserSelectedAddress?>? UserSelectedAddress;

  GetSelectedAddressModel({
    this.statusCode,
    this.status,
    this.message,
    this.UserSelectedAddress,
  });
  GetSelectedAddressModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
  if (json['User_selected_address'] != null) {
  final v = json['User_selected_address'];
  final arr0 = <GetSelectedAddressModelUserSelectedAddress>[];
  v.forEach((v) {
  arr0.add(GetSelectedAddressModelUserSelectedAddress.fromJson(v));
  });
    UserSelectedAddress = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    if (UserSelectedAddress != null) {
      final v = UserSelectedAddress;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['User_selected_address'] = arr0;
    }
    return data;
  }
}
