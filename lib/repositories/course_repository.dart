import 'package:atho/models/curriculum.dart';
import 'package:atho/models/lecture.dart';
import 'package:dio/dio.dart';
import 'package:atho/repositories/api.dart';

class CourseRepository {
  Future<CurriculumModel> curriculum(int subscribedCourseId, {Map<String, dynamic>? filter}) async {
    final response = await api.get('/subscribed-courses/$subscribedCourseId/curriculum', queryParameters: filter);
    final curriculum = CurriculumModel.fromJson(response.data['data']);
    return curriculum;
  }

  Future<LectureModel> lecture(int lectureId) async {
    final response = await api.get('/lectures/$lectureId', queryParameters: {});
    final lecture = LectureModel.fromJson(response.data['data']);
    return lecture;
  }

  Future<List<int>> completedLectures(int course) async {
    final response = await api.get('/subscribed-courses/$course/completedlectures', queryParameters: {});
    // response.data['data'].forEach((k, v) => result.add(v));
    return response.data['data'].cast<int>();
  }

  Future<Response> deleteCompletedLectures(int course, int lecture) async {
    return await api.delete('/subscribed-courses/$course/completedlectures/$lecture');
  }

  Future<Response> addCompletedLectures(int course, int lecture) async {
    return await api.post('/subscribed-courses/$course/completedlectures', data: {'lecture_id': lecture});
  }
}
