import 'package:atho/mock/mock.dart';
import 'package:atho/models/course.dart';
import 'package:atho/models/curriculum.dart';
import 'package:atho/models/logindata.dart';
import 'package:atho/models/user.dart';
import 'package:atho/repositories/account_repository.dart';
import 'package:atho/repositories/api.dart';
import 'package:atho/repositories/course_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:atho/controllers/login_controller.dart';

main() {
  final accountRepository = AccountRepository(api);

  final courseRepository = CourseRepository();

  final loginController = LoginController(accountRepository);
  UserModel user;
  LoginModel login;
  CurriculumModel curriculum;

  test('Login senha com invalida', () async {
    login = LoginModel(email: 'quality_contato@hotmail.com', password: '');
    user = await loginController.login(login);
    expect(user, isNull);
    expect(loginController.state, equals(LoginState.error));
  });

  test('Login com senha correta', () async {
    login =
        LoginModel(email: 'quality_contato@hotmail.com', password: 'password');
    user = await loginController.login(login);
    expect(user, isNotNull);
    expect(user.subscribedCourses?.isNotEmpty, true);
  });

  test('Retorno do curriculum', () async {
    login =
        LoginModel(email: 'quality_contato@hotmail.com', password: 'password');
    user = await loginController.login(login);
    curriculum = await courseRepository.curriculum(1, filter: {});
    int i = 1;
    expect(curriculum.chapters.isNotEmpty, true);
  });

  test('Conexão ao servidor local', () async {
    final d = new Dio(BaseOptions(baseUrl: 'http://172.22.66.156:8000'));
    final data = await d.get('/');
    expect(data.statusCode, 200);
  });
}
