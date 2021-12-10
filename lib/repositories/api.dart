import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
  baseUrl: "https://athoapp.com.br/api",
  // baseUrl: "http://localhost:8000/api",
  responseType: ResponseType.json,
  headers: {
    Headers.contentTypeHeader: Headers.jsonContentType,
    Headers.acceptHeader: Headers.jsonContentType,
  },
);
Dio api = new Dio(options);
// chapter
//     title
//     description

// lecture
//     id
//     title
//     description

// asset
//     id
//     title
//     created
//     type
//     content_summary
//     time_estimation
//     status
//     source_url
//     thumbnail_url
//     body

// quiz
//     id
//     type  simple_quiz
//     title
//     description
//     is_published
//     duration
//     pass_percent
//     num_assessments
//     is_randomized
//     requires_draft

// assessment
//     id
//     assessment_type =multiple_choice
//     prompt
//         relatedlectureids
//         answers

// {"_class":"assessment","id":26887940,"assessment_type":"multiple-choice","prompt":{"relatedLectureIds":["23914018"],"answers":["<p>Resposta do Quiz</p>","<p>Segunda Reposta do Quiz</p>"],"feedbacks":["Explicacão da resposta","Explicacao 2"],"question":"<p>Primeira <strong>Pergunta </strong>do Quiz</p>"},"correct_response":["a"],"section":""}
