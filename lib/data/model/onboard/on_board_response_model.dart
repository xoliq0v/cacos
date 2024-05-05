class OnBoardResponseModel {
  String? remark;
  String? status;
  Data? data;

  OnBoardResponseModel({this.remark, this.status, this.data});

  OnBoardResponseModel.fromJson(Map<String, dynamic> json) {
    remark = json['remark'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<ObsContent>? obsContent;

  Data({this.obsContent});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['obs_content'] != null) {
      obsContent = <ObsContent>[];
      json['obs_content'].forEach((v) {
        obsContent!.add(ObsContent.fromJson(v));
      });
    }
  }

}

class ObsContent {
  int? id;
  String? image;
  String? heading;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  ObsContent(
      {this.id,
        this.image,
        this.heading,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  ObsContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'] != null? json['image'].toString() : '';
    heading = json['heading'] != null? json['heading'].toString(): "";
    description = json['description'] != null? json['description'].toString() : "" ;
    status = json['status'] != null? json['status'].toString(): "";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
