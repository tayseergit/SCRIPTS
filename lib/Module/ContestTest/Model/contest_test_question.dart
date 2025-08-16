class ContestQuestionResponse {
  final bool status;
  final String contestType;
  final bool alreadyParticipate;
  final int questionsCount;
  final int correctAnswers;
  final int yourResult;
  final String endDate;       
  final double minutesLeft;   
  final List<Question> questions;

  ContestQuestionResponse({
    required this.status,
    required this.contestType,
    required this.alreadyParticipate,
    required this.questionsCount,
    required this.correctAnswers,
    required this.yourResult,
    required this.endDate,
    required this.minutesLeft,
    required this.questions,
  });

  factory ContestQuestionResponse.fromJson(Map<String, dynamic> json) {
    return ContestQuestionResponse(
      status: json['status'] ?? false,
      contestType: json['contest_type'] ?? '',
      alreadyParticipate: json['alreadyParticipate'] ?? false,
      questionsCount: json['questions_count'] ?? 0,
      correctAnswers: json['correct_answers'] ?? 0,
      yourResult: json['your_result'] ?? 0,
      endDate: json['end_date'] ?? '',
      minutesLeft: (json['minutes_left'] != null)
          ? double.tryParse(json['minutes_left'].toString()) ?? 0
          : 0,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((q) => Question.fromJson(q))
              .toList() ??
          [],
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
      options: (json['options'] as List<dynamic>?)
              ?.map((o) => Option.fromJson(o))
              .toList() ??
          [],
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
