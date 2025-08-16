class CourseTestQuestion {
  final bool status;
  final String message;
  final bool alreadyTaken;
  final int questionCount;
  final int correctAnswers;
  final int bestResult;
  final TestQuestionDataModel test;

  CourseTestQuestion({
    required this.status,
    required this.message,
    required this.alreadyTaken,
    required this.questionCount,
    required this.correctAnswers,
    required this.bestResult,
    required this.test,
  });

  factory CourseTestQuestion.fromJson(Map<String, dynamic> json) {
    return CourseTestQuestion(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      alreadyTaken: json['already_taken'] ?? false,
      questionCount: json['question_count'] ?? 0,
      correctAnswers: json['correct_answers'] ?? 0,
      bestResult: json['best_result'] ?? 0,
      test: TestQuestionDataModel.fromJson(json['test'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'already_taken': alreadyTaken,
      'question_count': questionCount,
      'correct_answers': correctAnswers,
      'best_result': bestResult,
      'test': test.toJson(),
    };
  }
}

class TestQuestionDataModel {
  final int id;
  final String title;
  final int isFinal;
  final int questionsCount;
  final List<Question> questions;

  TestQuestionDataModel({
    required this.id,
    required this.title,
    required this.isFinal,
    required this.questionsCount,
    required this.questions,
  });

  factory TestQuestionDataModel.fromJson(Map<String, dynamic> json) {
    return TestQuestionDataModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      isFinal: json['is_final'] ?? 0,
      questionsCount: json['questions_count'] ?? 0,
      questions: (json['questions'] as List<dynamic>? ?? [])
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'is_final': isFinal,
      'questions_count': questionsCount,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
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
      options: (json['options'] as List<dynamic>? ?? [])
          .map((o) => Option.fromJson(o))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'options': options.map((o) => o.toJson()).toList(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'answer': answer,
    };
  }
}
