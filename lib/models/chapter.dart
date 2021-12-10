import 'lecture.dart';

class ChapterModel {
  int id;
  String title;
  String description;
  int sortOrder;
  int courseId;
  List<LectureModel>? lectures;

  ChapterModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.sortOrder,
      required this.courseId,
      this.lectures});

  ChapterModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sortOrder = json['sort_order'],
        title = json['title'],
        courseId = json['course_id'],
        description = json['description'],
        lectures = json['lectures']
            ?.map((e) => LectureModel?.fromJson(e))
            .cast<LectureModel>()
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['sort_order'] = this.sortOrder;
    data['course_id'] = this.courseId;
    data['lectures'] = this.lectures?.map((v) => v.toJson()).toList();
    // data['lectures'] = this.lectures != null
    //     ? this.lectures?.map((v) => v.toJson()).toList()
    //     : null;
    return data;
  }
}
