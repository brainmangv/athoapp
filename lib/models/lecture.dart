import 'asset.dart';

class LectureModel {
  int id;
  String title;
  String description;
  // bool active;
  Asset? asset;

  LectureModel(
      {required this.id,
      required this.title,
      required this.description,
      // required this.active,
      this.asset});

  LectureModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'] ?? json['title'],
        // active = json['active'],
        description = json['description'] ?? json['description'],
        asset = json['asset'] != null ? Asset.fromJson(json['asset']) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    // data['active'] = this.active;
    data['asset'] = this.asset?.toJson();
    return data;
  }
}
