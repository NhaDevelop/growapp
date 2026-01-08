class StylistEvaluationData {
  final String title;
  final String subTitle;
  final Question1 question1;
  final Question2 question2;
  final Question3 question3;
  final Question4 question4;
  final Question5 question5;
  final Question6 question6;
  final String? staffName; // Pre-filled staff name from API

  StylistEvaluationData({
    required this.title,
    required this.subTitle,
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.question5,
    required this.question6,
    this.staffName,
  });

  factory StylistEvaluationData.fromJson(Map<String, dynamic> json) {
    return StylistEvaluationData(
      title: json['title'] ?? 'Stylist Evaluation',
      subTitle: json['sub_title'] ?? '',
      question1: Question1.fromJson(json['question_1'] ?? {}),
      question2: Question2.fromJson(json['question_2'] ?? {}),
      question3: Question3.fromJson(json['question_3'] ?? {}),
      question4: Question4.fromJson(json['question_4'] ?? {}),
      question5: Question5.fromJson(json['question_5'] ?? {}),
      question6: Question6.fromJson(json['question_6'] ?? {}),
    );
  }
}

class Question1 {
  final String title;
  final List<String> options;

  Question1({required this.title, required this.options});

  factory Question1.fromJson(Map<String, dynamic> json) {
    return Question1(
      title: json['title'] ?? '',
      options: List<String>.from(json['option'] ?? []),
    );
  }
}

class Question2 {
  final String title;
  final List<String> options;

  Question2({required this.title, required this.options});

  factory Question2.fromJson(Map<String, dynamic> json) {
    return Question2(
      title: json['title'] ?? '',
      options: List<String>.from(json['option'] ?? []),
    );
  }
}

class Question3 {
  final String title;
  final List<String> options;

  Question3({required this.title, required this.options});

  factory Question3.fromJson(Map<String, dynamic> json) {
    return Question3(
      title: json['title'] ?? '',
      options: List<String>.from(json['option'] ?? []),
    );
  }
}

class Question4 {
  final String title;
  final List<String> options;

  Question4({required this.title, required this.options});

  factory Question4.fromJson(Map<String, dynamic> json) {
    return Question4(
      title: json['title'] ?? '',
      options: List<String>.from(json['option'] ?? []),
     
    );
  }
}

class Question5 {
  final String title;
  final String value;

  Question5({required this.title, required this.value});

  factory Question5.fromJson(Map<String, dynamic> json) {
    return Question5(
      title: json['title'] ?? '',
      value: json['value'] ?? '',
    );
  }
}

class Question6 {
  final String title;
  final String value;

  Question6({required this.title, required this.value});

  factory Question6.fromJson(Map<String, dynamic> json) {
    return Question6(
      title: json['title'] ?? '',
      value: json['value'] ?? '',
    );
  }
}
