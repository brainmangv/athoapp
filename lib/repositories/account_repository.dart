import 'package:atho/models/course.dart';
import 'package:atho/models/user.dart';

import 'package:atho/models/logindata.dart';
import 'package:dio/dio.dart';

class AccountRepository {
  final Dio _dio;

  AccountRepository(this._dio);
  // Future<UserModel> updateAccount(UserModel model) async {
  //   return user;
  // }

  Future<String> login(LoginModel loginData) async {
    final response = await _dio.post('/login', data: loginData.toJson());
    final String token = response.data['data']['token'];
    _dio.options.headers['Authorization'] = 'Bearer ${token}';
    return token;
  }

  Future<UserModel> profile() async {
    final response = await _dio.get('/profile/me');

    final UserModel user = UserModel.fromJson(response.data['data']);
    user.token = _dio.options.headers['Authorization'];
    return user;
  }

  Future<bool> verifyEmail(String email) async {
    try {
      final response = await _dio.post(
        '/verify_email',
        data: {'email': email},
      );
      print(response);
      return response.statusCode == 200 ? true : false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<SubscribedCourse>> subscribedCourses() async {
    final response = await _dio.get('/users/me/subscribed-courses');

    final List<SubscribedCourse> subscribedCourses =
        response.data['data'].map((e) => SubscribedCourse.fromJson(e)).cast<SubscribedCourse>().toList();

    return subscribedCourses;
  }
}

///GET - /users/me/subscribed-courses/3714532/progress/
//{"_class":"course","id":3714532,"first_completion_time":null,"completed_lecture_ids":[23914018,23914096,23945126,24103204,24103810],"completed_quiz_ids":[5102600],"completed_assignment_ids":[],"last_seen_page":{"1265592":"start-page"}}
//POST - /visits/me/page-events/page-performance/CourseTakingV5.data-loaded/
// {"userId":128423,"visitorUUID":"9b395c41877b490cbf9dfec85929bd89","eventType":"mark","eventTime":6443,"pagePath":"/course/draft/3714532/learn/lecture/24103204","extra":{"_cart_dio":{"duration":2235,"startTime":2726},"_entry_main":{"duration":201,"startTime":2886},"_course_taking_app":{"duration":2274,"startTime":3089},"_event_tracking_app":{"duration":1,"startTime":5628},"_footer_app":{"duration":4,"startTime":5647},"_eu_cookie_message_app":{"duration":2,"startTime":5648},"js_entries":{"manifest":{"duration":483,"networkDurations":{"dns":0,"tcp":0,"waiting":229,"content":136},"startTime":1451,"isCacheHit":false},"main-modern-vendor":{"duration":769,"networkDurations":{"dns":0,"tcp":0,"waiting":228,"content":422},"startTime":1451,"isCacheHit":false},"main-modern":{"duration":811,"networkDurations":{"dns":0,"tcp":0,"waiting":222,"content":464},"startTime":1452,"isCacheHit":false}},"css_entries":{"main-legacy":{"duration":201,"networkDurations":{"dns":0,"tcp":0,"waiting":151,"content":13},"startTime":1193,"isCacheHit":false}},"ng_apps":{"course-taking":{"duration":644,"networkDurations":{"dns":0,"tcp":0,"waiting":156,"content":451},"startTime":1450,"isCacheHit":false}}},"osName":"windows","deviceType":"desktop","navigationTiming":{"redirectCount":0,"redirectDuration":0,"ttfb":1113,"responseDuration":28,"domInteractiveDuration":673,"domContentLoadedDuration":1728,"domCompleteDuration":4758,"firstPaint":1831,"firstContentfulPaint":1831,"connection":{"downlink":10,"rtt":100}}}
//POST - /users/me/subscribed-courses/3714532/lectures/23914018/view-logs/
//POST - /users/me/subscribed-courses/3714532/lectures/23914018/progress-logs/
//[{"total":28,"position":15,"time":"2021-01-04T15:47:59-03:00+15:47","openPanel":null,"isFullscreen":false,"context":{"type":"Lecture"}},{"total":28,"position":28,"time":"2021-01-04T15:48:14-03:00+15:48","openPanel":null,"isFullscreen":false,"context":{"type":"Lecture"}}]
//POST - /users/me/subscribed-courses/3714532/lectures/23914018/progress-logs/
//[{"position":1,"total":1,"context":{"type":"Article"},"time":"2021-01-04T15:56:21-03:00+15:56"}]
