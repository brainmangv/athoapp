class Name {
  int id = 0;
}

class AssessmentModel {
  int id;
  String assessmentType;
  String created;
  String question;
  int correctResponse;
  List<String> answers;
  List<String> feedbacks;
  int quizId;
  String updated;

  AssessmentModel(
      {required this.id,
      required this.assessmentType,
      required this.created,
      required this.question,
      required this.answers,
      required this.feedbacks,
      required this.quizId,
      required this.correctResponse,
      required this.updated});

  AssessmentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? json['id'],
        assessmentType = json['assessment_type'] ?? json['assessment_type'],
        question = json['question'] ?? json['question'],
        answers = json['answers'].cast<String>(),
        feedbacks = json['feedbacks'].cast<String>(),
        quizId = json['quiz_id'] ?? json['quiz_id'],
        created = json['created'] ?? json['created'],
        correctResponse = json['correct_response'] ?? json['correct_response'],
        updated = json['updated'] ?? json['updated'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['assessment_type'] = this.assessmentType;
    data['created'] = this.created;
    data['question'] = this.question;
    data['answers'] = this.answers;
    data['feedbacks'] = this.feedbacks;
    data['quiz_id'] = this.quizId;
    data['correct_response'] = this.correctResponse;
    data['updated'] = this.updated;
    return data;
  }
}
