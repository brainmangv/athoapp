import 'package:atho/models/curriculum.dart';
import 'dart:core';

import 'package:atho/models/lecture.dart';

class CourseModel {
  int id;
  String title;
  String description;
  String headline;
  String contentInfo;
  String thumbnailUrl;
  CurriculumModel? curriculum;
  CourseModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.headline,

      /// String formatada como o tempo estimado de duração do curso.
      /// Ex:**8 horas no total**
      required this.contentInfo,
      required this.thumbnailUrl});

  CourseModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? json['id'],
        title = json['title'] ?? '',
        description = json['description'] ?? '',
        headline = json['headline'] ?? '',
        contentInfo = json['content_info'] ?? '',
        thumbnailUrl = json['thumbnail_url'] ?? '';

  // factory CourseModel.fromJson(Map<String, dynamic> json) {
  //   return CourseModel(
  //       id: json['id'] ?? json['id'],
  //       title: json['title'] ?? '',
  //       description: json['description'] ?? '',
  //       headline: json['headline'] ?? '',
  //       contentInfo: json['content_info'] ?? '',
  //       thumbnailUrl: json['thumbnail_url'] ?? '');
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['headline'] = this.headline;
    data['content_info'] = this.contentInfo;
    data['thumbnail_url'] = this.thumbnailUrl;
    return data;
  }
}

class SubscribedCourse extends CourseModel {
  DateTime limiteDate;
  double completionRate;
  int lastSeenLecture;
  SubscribedCourse({
    required int id,
    required String title,
    required String description,
    required String headline,
    required String contentInfo,
    required String thumbnailUrl,
    required this.limiteDate,
    required this.completionRate,
    required this.lastSeenLecture,
  }) : super(
          id: id,
          title: title,
          description: description,
          headline: headline,
          contentInfo: contentInfo,
          thumbnailUrl: thumbnailUrl,
        );

  SubscribedCourse.fromJson(Map<String, dynamic> json)
      : limiteDate = DateTime.parse(json['limite_date']),
        completionRate = json['completion_rate'].toDouble(),
        lastSeenLecture = json['last_seen_lecture'],
        super.fromJson(json) {}

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = super.toJson();
    data.putIfAbsent('completion_rate', () => this.completionRate.toString());
    data.putIfAbsent('limite_date', () => this.limiteDate.toString());
    data['last_seen_lecture'] = this.lastSeenLecture;
    return data;
  }
}

// enum ProgressStatus { inprogress, notstarted, completed }

// getProgressStatusFromJson(String statusAsString) {
//   for (ProgressStatus element in ProgressStatus.values) {
//     if (element.toString() == 'ProgressStatus.' + statusAsString) {
//       return element;
//     }
//   }
//   return null;
// }
