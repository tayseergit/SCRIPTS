class ContestTestQuestion {
  final bool status;
  final String message;
  final bool alreadyTaken;
  final String bestResult;
  final TestQuestionDataModel test;

  ContestTestQuestion({
    required this.status,
    required this.message,
    required this.alreadyTaken,
    required this.bestResult,
    required this.test,
  });

  factory ContestTestQuestion.fromJson(Map<String, dynamic> json) {
    return ContestTestQuestion(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      alreadyTaken: json['already_taken'] ?? false,
      bestResult: json['best_result'] ?? '',
      test: TestQuestionDataModel.fromJson(json['test']),
    );
  }
}

class TestQuestionDataModel {
  final int id;
  final String title;
  final int isFinal;
  final int questionsCount;
  final List<Question> questions;

  TestQuestionDataModel.ContestQuestionDataModel({
    required this.id,
    required this.title,
    required this.isFinal,
    required this.questionsCount,
    required this.questions,
  });

  factory TestQuestionDataModel.fromJson(Map<String, dynamic> json) {
    return TestQuestionDataModel.ContestQuestionDataModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      isFinal: json['is_final'] ?? 0,
      questionsCount: json['questions_count'] ?? 0,
      questions: (json['questions'] as List<dynamic>)
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }
}

class Question {
  final int id;
  final String text;
  final List<Option> options;

  Question({
    required this.id,
    required this.text,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      options: (json['options'] as List<dynamic>)
          .map((o) => Option.fromJson(o))
          .toList(),
    );
  }
}

class Option {
  final int id;
  final String answer;

  Option({
    required this.id,
    required this.answer,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'] ?? 0,
      answer: json['answer'] ?? '',
    );
  }
}
