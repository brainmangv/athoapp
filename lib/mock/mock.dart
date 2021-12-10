import 'dart:convert';
import 'dart:core';
import 'package:atho/models/course.dart';
import 'package:atho/models/curriculum.dart';
import 'package:atho/models/user.dart';
import 'package:atho/mock/json.dart';

final user = UserModel(
    id: 1,
    name: "Ricardo",
    lastname: "Ramos",
    email: "quality_contato@hotmail.com",
    picture: "https://picsum.photos/200/200",
    company: 'Quality Designer',
    city: 'Governador Valadares',
    uf: 'MG',
    cpf: '894.514.576-15',
    jobTitle: "student",
    token: "xpto",
    phone: "31-3232323");

final curriculum =
    CurriculumModel.fromJson(jsonDecode(curriculumJson)['results']);

final list = jsonDecode(subscribedJson)['results'];

// List<SubscribedCourse> subscribedCourses = List<SubscribedCourse>.from(
// list.map((e) => SubscribedCourse.fromJson(e)).toList());

// TODO: Fazer algo aqui
List<SubscribedCourse> subscribedCourses = list
    .map((e) => SubscribedCourse.fromJson(e))
    .cast<SubscribedCourse>()
    .toList();
