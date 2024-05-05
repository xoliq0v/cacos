class FloatingButtonResponseModel {
  String? remark;
  String? status;
  Data? data;

  FloatingButtonResponseModel({this.remark, this.status, this.data});

  FloatingButtonResponseModel.fromJson(Map<String, dynamic> json) {
    remark = json['remark'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<FloatingButtons>? floatingButtons;

  Data({this.floatingButtons});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['floating_buttons'] != null) {
      floatingButtons = <FloatingButtons>[];
      json['floating_buttons'].forEach((v) {
        floatingButtons!.add(FloatingButtons.fromJson(v));
      });
    }
  }
}

class FloatingButtons {
  int? id;
  String? title;
  String? icon;
  String? url;
  String? status;
  String? createdAt;
  String? updatedAt;

  FloatingButtons(
      {this.id,
        this.title,
        this.icon,
        this.url,
        this.status,
        this.createdAt,
        this.updatedAt});

  FloatingButtons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null? json['title'].toString(): "";
    icon = json['icon'] != null? json['icon'].toString(): "";
    url = json['url'] != null? json['url'].toString(): "";
    status = json['status'] != null? json['status'].toString(): "";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'url': url,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
