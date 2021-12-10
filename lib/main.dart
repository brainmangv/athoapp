import 'dart:convert';
import 'dart:io';

import 'package:atho/repositories/account_repository.dart';
import 'package:atho/repositories/api.dart';
import 'package:atho/stores/app.store.dart';
import 'package:atho/views/course_view.dart';
import 'package:atho/views/course_view.dart';
import 'package:atho/views/home_view.dart';
import 'package:atho/views/onboarding_view.dart';
import 'package:atho/views/signup_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/login_view.dart';
import 'utilities/preloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(
      ChangeNotifierProvider(create: (context) => AppStore(), child: MyApp()));
}

class MyHome extends StatelessWidget {
  final accountRepository = AccountRepository(api);

  @override
  Widget build(BuildContext context) {
    final AppStore store = Provider.of<AppStore>(context, listen: false);

    return FutureBuilder(
      future: _chechAuth(store),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return OnboardingScreen();
          // return Center(child: Text(snapshot.error.toString()));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return (api.options.headers['Authorization'] == null)
              ? OnboardingScreen()
              : HomeView();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Future<void> _chechAuth(store) async {
    preLoadSVG();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      api.options.headers['Authorization'] = token;
      final user = await accountRepository.profile();
      store.setUser(user);
    }
  }
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atho',
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Theme.of(context).primaryColor,
          splashColor: Theme.of(context).accentColor,
          elevation: 4.0,
          highlightElevation: 2.0,
          shape: StadiumBorder(),
        ),
        cardTheme: CardTheme(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            margin: EdgeInsets.all(0)),

        textTheme: TextTheme(subtitle1: TextStyle(fontSize: 16)),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(6.0),
            ),
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[50],
        backgroundColor: Colors.green,
        brightness: Brightness.light,
        primaryColor: Colors.black,
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.purple, cursorColor: Colors.red),
        accentColor: Colors.red[600],
        //accentColor: Colors.yellow,
        //primarySwatch: Colors.green,
        // primaryColor: Colors.blue[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.lightBlue[800],
          ),
        ),
      ),
      routes: {
        '/home': (context) => HomeView(),
        '/signup': (context) => SignupView(),
        '/login': (context) => LoginView(),
        // CourseView.routeName: (context) => CourseView(),
        '/course': (context) => CourseView(),
      },
      home: MyHome(),
    );
  }
}
