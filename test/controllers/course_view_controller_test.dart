import 'package:atho/controllers/course_view_controller.dart';
import 'package:atho/models/curriculum.dart';
import 'package:atho/models/logindata.dart';
import 'package:atho/repositories/account_repository.dart';
import 'package:atho/repositories/api.dart';
import 'package:atho/repositories/course_repository.dart';
import 'package:atho/controllers/login_controller.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'course_view_controller_test.mocks.dart';

@GenerateMocks([CourseRepository])
void main() {
  final repository = MockCourseRepository();

  test('Deve carregar curriculum', () async {
    when(repository.curriculum(5))
        .thenAnswer((_) async => CurriculumModel(chapters: [], quiz: []));

    final curriculum = await repository.curriculum(5);
    expect(curriculum, isA<CurriculumModel>());
  });
}
