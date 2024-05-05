class NavBarResponseModel {
  String? remark;
  String? status;
  Data? data;

  NavBarResponseModel({this.remark, this.status, this.data});

  NavBarResponseModel.fromJson(Map<String, dynamic> json) {
    remark = json['remark'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<NavBars>? navBars;

  Data({this.navBars});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['nav_bars'] != null) {
      navBars = <NavBars>[];
      json['nav_bars'].forEach((v) {
        navBars!.add(NavBars.fromJson(v));
      });
    }
  }
}

class NavBars {
  int? id;
  String? title;
  String? icon;
  String? url;
  String? status;
  String? createdAt;
  String? updatedAt;

  NavBars(
      {this.id,
        this.title,
        this.icon,
        this.url,
        this.status,
        this.createdAt,
        this.updatedAt});

  NavBars.fromJson(Map<String, dynamic> json) {
    id = json['id'] ;
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
