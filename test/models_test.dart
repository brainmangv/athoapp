import 'dart:convert';
import 'package:atho/models/lecture.dart';
import 'package:atho/repositories/api.dart';

import 'package:atho/controllers/login_controller.dart';
import 'package:atho/models/chapter.dart';
import 'package:atho/models/logindata.dart';
import 'package:atho/models/user.dart';
import 'package:atho/repositories/account_repository.dart';
import 'package:atho/repositories/course_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:test/test.dart';
import 'json.dart';

main() {
  final accountRepository = AccountRepository(api);
  final courseRepository = CourseRepository();

  final loginController = LoginController(accountRepository);
  UserModel user;
  LoginModel login;

  test('Chapter Model', () {
    List<ChapterModel>? chapters;
    final list = jsonDecode(json);
    chapters = list['chapters']
        .map((e) => ChapterModel?.fromJson(e))
        .cast<ChapterModel>()
        .toList();

    print(chapters?[1].toJson());
    print(list?['id']);
  });

  test('teste CompletedLectures', () async {
    login =
        LoginModel(email: 'quality_contato@hotmail.com', password: 'password');
    user = await loginController.login(login);
    List completed = await courseRepository.completedLectures(1);
    completed.forEach((element) {
      print(element.toJson());
      print('-');
    });
    expect(completed, isA<List>());
  });

  test('add CompletedLectures', () async {
    login =
        LoginModel(email: 'quality_contato@hotmail.com', password: 'password');
    user = await loginController.login(login);
    Response response = await courseRepository.addCompletedLectures(1, 4);
    expect(response.statusCode, 200);
  });

  test('delete CompletedLectures', () async {
    login =
        LoginModel(email: 'quality_contato@hotmail.com', password: 'password');
    user = await loginController.login(login);
    Response response = await courseRepository.deleteCompletedLectures(1, 4);
    expect(response.statusCode, 200);
  });

  test('Lecture', () async {
    login =
        LoginModel(email: 'quality_contato@hotmail.com', password: 'password');
    user = await loginController.login(login);
    final lecture = await courseRepository.lecture(4);
    print(lecture.asset?.mediaSource);
    expect(lecture, isA<LectureModel>());
  });
}
