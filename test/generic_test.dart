import 'dart:convert';

import 'package:atho/controllers/login_controller.dart';
import 'package:atho/models/course.dart';
import 'package:atho/models/curriculum.dart';
import 'package:atho/models/logindata.dart';
import 'package:atho/repositories/account_repository.dart';
import 'package:atho/mock/mock.dart' as mock;
import 'package:atho/mock/json.dart';
import 'package:atho/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

main() async {
  // final repository = AccountRepository();
  // final controller = LoginController();
  // final logindata =
  //     LoginModel(email: "quality_contato@hotmail.com", password: "12345");
  // final UserModel user = await controller.login(logindata);
  // print(controller.state);
  // if (user != null) print(user.toJson());
  // try {
  //       // await repository.login(logindata).then((user) {
  //   //   //print(controller.state);
  //   //   if (user != null) print(user.toJson());
  //   // });
  //   var user = await controller.login(logindata);
  //   print(user);
  // } on DioError catch (e) {
  //   if (e.response != null) {
  //     print(e.response.statusCode);
  //     print('\r');
  //     print(e.response.data);
  //   } else {
  //     // Something happened in setting up or sending the request that triggered an Error
  //     print('Something happened');
  //     print(e.request);
  //     print(e.message);
  //   }
  // }
  // print(json.decode(assetJson)['slide_urls'].runtimeType);
  // var c = Curriculum.fromJson(jsonDecode(j)['results']);
  // print(c.toJson());
  // var chapter = Chapter();
  //print(mock.subscribedCourses[1].toJson());
  test('Build pattern', () {
    var i = Item('ola mundo');
    var j = i;
    j.s = '--';
    // var d = Director(i);
    print(i.s);
    print(j.s);
    return false;
  });
}

class Item {
  String s;
  Item(this.s);
}

class Director {
  Director(Item a) {
    assert(false, '344');
    a.s = 'mudado';
  }
}
