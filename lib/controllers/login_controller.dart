import 'dart:io' show Platform;

import 'package:atho/models/user.dart';
import 'package:atho/repositories/account_repository.dart';
import 'package:atho/models/logindata.dart';
import 'package:atho/repositories/api.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

class LoginController {
  final AccountRepository accountRepository;
  LoginState state = LoginState.start;
  late DioError error;
  late UserModel user;

  LoginController(accountRepository) : accountRepository = accountRepository;

  Future<UserModel> login(LoginModel logindata) async {
    state = LoginState.loading;
    try {
      String token = await accountRepository.login(logindata);
      user = await accountRepository.profile();
      //user.subscribedCourses = await accountRepository.subscribedCourses();
      state = LoginState.success;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', api.options.headers['Authorization']);
      api.options.headers['Authorization'] = 'Bearer ${token}';

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      print('OS: ${Platform.operatingSystem}');
      // if (defaultTargetPlatform == TargetPlatform.android) {
      //   print('device info ${deviceInfo.toString()}');
      //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      //   print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
      // }
      // if (defaultTargetPlatform == TargetPlatform.iOS) {
      //   IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      //   print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
      // }
      // if (defaultTargetPlatform == TargetPlatform.linux) {}
      // if (defaultTargetPlatform == TargetPlatform.macOS) {}
      // if (defaultTargetPlatform == TargetPlatform.windows) {
      //   WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      //   print('Running on ${webBrowserInfo.userAgent}');
      //   // WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
      //   // print('Running on ${windowsInfo.computerName}');
      // } else {
      //   WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      //   print('Running on ${webBrowserInfo.userAgent}');
      // }
    } on DioError catch (e) {
      state = LoginState.error;
      error = e;
      print(e.response!.data);
      print([e.error, e.message, e.type, e.response]);
    }
    return user;
  }
}

enum LoginState { start, loading, success, error }
