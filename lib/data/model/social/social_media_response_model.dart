class SocialMediaResponseModel {
  SocialMediaResponseModel({
      String? remark, 
      String? status, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _data = data;
}

  SocialMediaResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Data? get data => _data;

}

class Data {
  Data({
      List<SocialsMedia>? socialsMedia,}){
    _socialsMedia = socialsMedia;
}

  Data.fromJson(dynamic json) {
    if (json['socials_media'] != null) {
      _socialsMedia = [];
      json['socials_media'].forEach((v) {
        _socialsMedia?.add(SocialsMedia.fromJson(v));
      });
    }
  }
  List<SocialsMedia>? _socialsMedia;

  List<SocialsMedia>? get socialsMedia => _socialsMedia;

}

class SocialsMedia {
  SocialsMedia({
      int? id, 
      String? name, 
      String? icon, 
      String? url, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _icon = icon;
    _url = url;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  SocialsMedia.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'] != null? json['name'].toString(): "";
    _icon = json['icon'] != null? json['icon'].toString(): "";
    _url = json['url'] != null? json['url'].toString(): "";
    _status = json['status'] != null? json['status'].toString(): "";
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _icon;
  String? _url;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get icon => _icon;
  String? get url => _url;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;


  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'icon': _icon,
      'url': _url,
      'status': _status,
      'created_at': _createdAt,
      'updated_at': _updatedAt,
    };

}

}