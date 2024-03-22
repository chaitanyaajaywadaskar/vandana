import 'dart:convert';

GetBannerImagesModel getBannerImagesModelFromJson(String str) =>
    GetBannerImagesModel.fromJson(json.decode(str));

String getBannerImagesModelToJson(GetBannerImagesModel data) =>
    json.encode(data.toJson());

class GetBannerImagesModel {
  String? statusCode;
  String? message;
  List<BannerList>? bannerList;

  GetBannerImagesModel({
    this.statusCode,
    this.message,
    this.bannerList,
  });

  factory GetBannerImagesModel.fromJson(Map<String, dynamic> json) =>
      GetBannerImagesModel(
        statusCode: json["status_code"],
        message: json["message"],
        bannerList: List<BannerList>.from(
            json["Banner_list"].map((x) => BannerList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "Banner_list": (bannerList != null)
            ? List<dynamic>.from(bannerList!.map((x) => x.toJson()))
            : null,
      };
}

class BannerList {
  String? id;
  String? type;
  String? bannerImage;

  BannerList({
    this.id,
    this.type,
    this.bannerImage,
  });

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
        id: json["id"],
        type: json["type"],
        bannerImage: json["baner_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "baner_image": bannerImage,
      };
}
