import 'dart:convert';

GetAddressListModel getAddressListModelFromJson(String str) =>
    GetAddressListModel.fromJson(json.decode(str));

String getAddressListModelToJson(GetAddressListModel data) =>
    json.encode(data.toJson());

class GetAddressListModel {
  String? statusCode;
  String? status;
  String? message;
  List<AddressList>? addressList;

  GetAddressListModel({
    this.statusCode,
    this.status,
    this.message,
    this.addressList,
  });

  factory GetAddressListModel.fromJson(Map<String, dynamic> json) =>
      GetAddressListModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        addressList: List<AddressList>.from(
            json["address_list"].map((x) => AddressList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "address_list": List<dynamic>.from(addressList!.map((x) => x.toJson())),
      };
}

class AddressList {
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
  DateTime? date;

  AddressList({
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
    this.date,
  });

  factory AddressList.fromJson(Map<String, dynamic> json) => AddressList(
        id: json["id"],
        customerCode: json["customer_code"],
        userType: json["user_type"],
        phone: json["phone"],
        addressType: json["address_type"],
        state: json["state"],
        city: json["city"],
        pincode: json["pincode"],
        address: json["address"],
        latLong: json["lat_long"],
        receiversName: json["receivers_name"],
        contactNo: json["contact_no"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_code": customerCode,
        "user_type": userType,
        "phone": phone,
        "address_type": addressType,
        "state": state,
        "city": city,
        "pincode": pincode,
        "address": address,
        "lat_long": latLong,
        "receivers_name": receiversName,
        "contact_no": contactNo,
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
      };
}
