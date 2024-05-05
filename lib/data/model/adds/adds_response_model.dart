class AddsResponseModel {
  String? remark;
  String? status;
  Data? data;

  AddsResponseModel({this.remark, this.status, this.data});

  AddsResponseModel.fromJson(Map<String, dynamic> json) {
    remark = json['remark'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? bannerAds;
  String? interstitialId;
  List<PopUpAds>? popUpAds;

  Data({this.bannerAds, this.interstitialId, this.popUpAds});

  Data.fromJson(Map<String, dynamic> json) {
    bannerAds = json['banner_ads'] != null? json['banner_ads'].toString(): "";
    interstitialId = json['interstitial_id'] != null? json['interstitial_id'].toString(): "";
    if (json['pop_up_ads'] is List) {
      popUpAds = <PopUpAds>[];
      json['pop_up_ads'].forEach((v) {
        popUpAds!.add(PopUpAds.fromJson(v));
      });
    }
  }
}

class PopUpAds {
  int? id;
  String? image;
  String? url;
  String? status;
  String? createdAt;
  String? updatedAt;

  PopUpAds(
      {this.id,
        this.image,
        this.url,
        this.status,
        this.createdAt,
        this.updatedAt});

  PopUpAds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'] != null? json['image'].toString(): "";
    url = json['url'] != null? json['url'].toString(): "";
    status = json['status'] != null? json['status'].toString(): "";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
