//import 'package:mobx/mobx.dart';
//part 'app.store.g.dart';

//class AppStore = _AppStore with _$AppStore;

//abstract class _AppStore with Store {
import 'package:atho/models/course.dart';
import 'package:atho/models/lecture.dart';
import 'package:atho/models/user.dart';
import 'package:flutter/foundation.dart';

class AppStore extends ChangeNotifier {
  // @observable
  UserModel? _user;
  LectureModel? _lecture;

  LectureModel? get currentLecture => _lecture;
  UserModel? get user => _user;

  void setCurrentLecture(LectureModel? lecture) {
    this._lecture = lecture;
    notifyListeners();
  }

  // @action
  void setUser(UserModel? user) {
    this._user = user;
    notifyListeners();
  }

  void setCourses(List<SubscribedCourse> courses) {
    this._user?.subscribedCourses = courses;
    notifyListeners();
  }
}
