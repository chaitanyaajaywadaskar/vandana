import 'dart:convert';

PostAddressModel postAddressModelFromJson(String str) =>
    PostAddressModel.fromJson(json.decode(str));

String postAddressModelToJson(PostAddressModel data) =>
    json.encode(data.toJson());

class PostAddressModel {
  String? statusCode;
  String? status;
  String? message;
  AddressDetails? addressDetails;

  PostAddressModel({
    this.statusCode,
    this.status,
    this.message,
    this.addressDetails,
  });

  factory PostAddressModel.fromJson(Map<String, dynamic> json) =>
      PostAddressModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        addressDetails: AddressDetails.fromJson(json["Address_Details"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "Address_Details": addressDetails?.toJson(),
      };
}

class AddressDetails {
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

  AddressDetails({
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

  factory AddressDetails.fromJson(Map<String, dynamic> json) => AddressDetails(
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
