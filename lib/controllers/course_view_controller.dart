import 'package:atho/models/curriculum.dart';
import 'package:atho/repositories/course_repository.dart';

class CourseViewController {
  final CourseRepository _courseRepository;
  CourseViewController([CourseRepository? courseRepository])
      : _courseRepository = courseRepository ?? CourseRepository();

  Future<CurriculumModel> curriculum(int subscribedCourseId) async {
    return await this._courseRepository.curriculum(subscribedCourseId);
  }
}
