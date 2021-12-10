import 'package:atho/models/assessment.dart';

class QuizModel {
  int id;
  String title;
  String type;
  // String created;
  String description;
  // String titleCleaned;
  // bool isPublished;
  // int sortOrder;
  // int objectIndex;
  // bool isDraft;
  // int version;
  int duration;
  int passPercent;
  late List<AssessmentModel> assessments;

  QuizModel(
      {required this.id,
      required this.title,
      required this.type,
      // required this.created,
      required this.description,
      // required this.titleCleaned,
      // required this.isPublished,
      // required this.sortOrder,
      // required this.objectIndex,
      // required this.isDraft,
      // required this.version,
      required this.duration,
      required this.passPercent});

  QuizModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        type = json['type'],
        // created = json['created'],
        description = json['description'],
        // titleCleaned = json['title_cleaned'],
        // isPublished = json['is_published'],
        // sortOrder = json['sort_order'],
        // objectIndex = json['object_index'],
        // isDraft = json['is_draft'],
        // version = json['version'],
        duration = json['duration'],
        passPercent = json['pass_percent'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_class'] = 'quiz';
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    // data['created'] = this.created;
    data['description'] = this.description;
    // data['title_cleaned'] = this.titleCleaned;
    // data['is_published'] = this.isPublished;
    // data['sort_order'] = this.sortOrder;
    // data['object_index'] = this.objectIndex;
    // data['is_draft'] = this.isDraft;
    // data['version'] = this.version;
    data['duration'] = this.duration;
    data['pass_percent'] = this.passPercent;
    return data;
  }
}
