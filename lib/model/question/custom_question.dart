class CustomQuestion {
  int QuestionId;
  int? Degree;
  int? QuestionType;
  String? Text;
  String? CorrectAnswer;
  String? Image;
  List<CustomAnswer> Choices;
  bool Selected = false;

  CustomQuestion({
    required this.QuestionId,
    required this.Degree,
    required this.QuestionType,
    required this.Text,
    required this.CorrectAnswer,
    required this.Image,
    required this.Choices,
  });

  factory CustomQuestion.fromJson(Map<String, dynamic> json) =>
      CustomQuestion(
        QuestionId: json['QuestionId'],
          Degree: json['Degree'],
        QuestionType: json['QuestionType'],
        Text: json['Text'],
        CorrectAnswer: json['CorrectAnswer'],
        Image: json['Image'],
        Choices: json['Choices'].map<CustomAnswer>((e)=> CustomAnswer.fromJson(e)).toList(),
      );
}

class CustomAnswer {
  int? Id;
  int? QuestionId;
  String? Question;
  String? ChoiceText;

  CustomAnswer({
    required this.Id,
    required this.QuestionId,
    required this.Question,
    required this.ChoiceText,
  });

  factory CustomAnswer.fromJson(Map<String, dynamic> json) =>
      CustomAnswer(
        Id: json['Id'],
        QuestionId: json['QuestionId'],
        Question: json['Question'],
        ChoiceText: json['ChoiceText'],
      );
}
