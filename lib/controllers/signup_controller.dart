import 'package:atho/models/user.dart';
import 'package:atho/repositories/account_repository.dart';
import 'package:atho/repositories/api.dart';
import 'package:dio/dio.dart';

class SignupController {
  late AccountRepository repository;
  late UserModel user;

  SignupController() {
    repository = new AccountRepository(api);
  }

  Future<UserModel> update(UserModel model) async {
    // await repository.updateAccount(model)
    try {
      var courses = await repository.subscribedCourses();
      user = await repository.profile();
    } on DioError catch (e) {
      print(e.response!.data);
      print([e.error, e.message, e.type, e.response]);
    }
    return user;
  }
}
