class DrawingItemResponseModel {
  String? remark;
  String? status;
  Data? data;

  DrawingItemResponseModel({this.remark, this.status, this.data});

  DrawingItemResponseModel.fromJson(Map<String, dynamic> json) {
    remark = json['remark'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Drawers>? drawers;

  Data({this.drawers});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['drawers'] != null) {
      drawers = <Drawers>[];
      json['drawers'].forEach((v) {
        drawers!.add(Drawers.fromJson(v));
      });
    }
  }
}

class Drawers {
  int? id;
  String? name;
  String? icon;
  String? url;
  String? status;
  String? createdAt;
  String? updatedAt;

  Drawers(
      {this.id,
        this.name,
        this.icon,
        this.url,
        this.status,
        this.createdAt,
        this.updatedAt});

  Drawers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null? json['name'].toString(): "";
    icon = json['icon'] != null? json['icon'].toString(): "";
    url = json['url'] != null? json['url'].toString(): "";
    status = json['status'] != null? json['status'].toString(): "";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'url': url,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }


}
