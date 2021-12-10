import 'course.dart';

class UserModel {
  int? id;
  String? token;
  String name;
  String lastname;
  String email;
  String? cpf;
  String? phone;
  String? city;
  String? uf;
  String? company;
  String? jobTitle;
  String? picture;
  List<SubscribedCourse>? subscribedCourses;
  UserModel(
      {this.id,
      required this.name,
      required this.lastname,
      required this.email,
      this.cpf,
      this.phone,
      this.city,
      this.uf,
      this.company,
      this.jobTitle,
      this.picture,
      this.token,
      this.subscribedCourses});

  UserModel.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        name = json['name'],
        lastname = json['lastname'],
        email = json['email'],
        cpf = json['cpf'],
        phone = json['phone'],
        city = json['city'],
        uf = json['uf'],
        company = json['company'],
        jobTitle = json['job_title'],
        picture = json['picture'],
        token = json['token'] {
    if (json['subscribed_courses'] != null) {
      subscribedCourses = <SubscribedCourse>[];
      json['subscribed_courses'].forEach((v) {
        subscribedCourses?.add(new SubscribedCourse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['cpf'] = this.cpf;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['uf'] = this.uf;
    data['company'] = this.company;
    data['job_title'] = this.jobTitle;
    data['picture'] = this.picture;
    data['token'] = this.token;
    if (this.subscribedCourses != null) {
      data['subscribedCourses'] =
          this.subscribedCourses?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  double courseAchievement() {
    double score = 0;
    if (this.subscribedCourses != null) {
      this.subscribedCourses?.forEach((element) {
        score += element.completionRate;
      });

      int l = this.subscribedCourses!.length;
      score = score / l;
    }
    return score;
  }
}
