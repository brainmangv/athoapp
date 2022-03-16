import 'quiz.dart';
import 'chapter.dart';

class CurriculumModel {
  late List<ChapterModel> chapters;
  late List<QuizModel> quiz;

  CurriculumModel({required this.chapters, required this.quiz});

  CurriculumModel.fromJson(Map<String, dynamic> json) {
    if (json['chapters'] != null) {
      this.chapters = [];
      //chapters = [].map((e) => null);
      json['chapters'].forEach((v) {
        final chapter = new ChapterModel.fromJson(v);
        this.chapters.add(chapter);
      });
    }

    if (json['quiz'] != null) {
      this.quiz = [];
      json['quiz'].forEach((v) {
        if (v != null) this.quiz.add(new QuizModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapters'] = this.chapters.map((v) => v.toJson()).toList();
    data['quiz'] = this.quiz.map((v) => v.toJson()).toList();
    return data;
  }
}
