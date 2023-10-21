import '../question/custom_question.dart';

class TeacherExamDetails {
  int? examId;
  String? title;
  int? educationTypeId;
  String? educationTypeName;
  int? programTypeId;
  String? programTypeName;
  int? gradeId;
  String? gradeName;
  int? subjectId;
  String? subjectName;
  int? teacherId;
  String? teacherName;
  String? startDate;
  String? endDate;
  bool? hasTimer;
  var examTime;
  var examDegree;
  var passDegree;
  bool? free;
  int? examType;
  int? groupId;
  int? groupName;
  int? courseId;
  String? courseName;
  List<ExamQuestion>? examQuestions;
  List<ExamCountries>? examCountries;
  List<ExamPrices>? examPrices;

  TeacherExamDetails({this.examId,
    this.title,
    this.educationTypeId,
    this.educationTypeName,
    this.programTypeId,
    this.programTypeName,
    this.gradeId,
    this.gradeName,
    this.subjectId,
    this.subjectName,
    this.teacherId,
    this.teacherName,
    this.startDate,
    this.endDate,
    this.hasTimer,
    this.examTime,
    this.examDegree,
    this.passDegree,
    this.free,
    this.examType,
    this.groupId,
    this.groupName,
    this.courseId,
    this.courseName,
    this.examQuestions,
    this.examCountries,
    this.examPrices});

  factory TeacherExamDetails.fromJson(Map<String, dynamic> json) =>
      TeacherExamDetails(
    examId : json['ExamId'],
    title : json['Title'],
    educationTypeId : json['EducationTypeId'],
    educationTypeName : json['EducationTypeName'],
    programTypeId : json['ProgramTypeId'],
    programTypeName : json['ProgramTypeName'],
    gradeId : json['GradeId'],
    gradeName : json['GradeName'],
    subjectId : json['SubjectId'],
    subjectName : json['SubjectName'],
    teacherId : json['TeacherId'],
    teacherName : json['TeacherName'],
    startDate : json['StartDate'],
    endDate : json['EndDate'],
    hasTimer : json['HasTimer'],
    examTime : json['ExamTime'],
    examDegree : json['ExamDegree'],
    passDegree : json['PassDegree'],
    free : json['Free'],
    examType : json['ExamType'],
    groupId : json['GroupId'],
    groupName : json['GroupName'],
    courseId : json['CourseId'],
    courseName : json['CourseName'],
  examQuestions: json['ExamQuestions'].map<ExamQuestion>((e)=> ExamQuestion.fromJson(e)).toList(),
  examCountries: json['ExamCountries'].map<ExamCountries>((e)=> ExamCountries.fromJson(e)).toList(),
  examPrices: json['ExamPrices'].map<ExamPrices>((e)=> ExamPrices.fromJson(e)).toList(),

  );
}

class ExamCountries {
  int? countryId;
  String? countryName;

  ExamCountries({this.countryId, this.countryName});

  ExamCountries.fromJson(Map<String, dynamic> json) {
    countryId = json['CountryId'];
    countryName = json['CountryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CountryId'] = this.countryId;
    data['CountryName'] = this.countryName;
    return data;
  }
}

class ExamPrices {
  int? currencyId;
  String? currencyName;
  var price;

  ExamPrices({this.currencyId, this.currencyName, this.price});

  ExamPrices.fromJson(Map<String, dynamic> json) {
    currencyId = json['CurrencyId'];
    currencyName = json['CurrencyName'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CurrencyId'] = this.currencyId;
    data['CurrencyName'] = this.currencyName;
    data['Price'] = this.price;
    return data;
  }
}

class ExamQuestion {
  int QuestionId;
  int? Degree;
  int? QuestionType;
  String? Text;
  String? CorrectAnswer;
  String? Image;
  List<CustomAnswer> Choices;
  bool Selected = false;

  ExamQuestion({
    required this.QuestionId,
    required this.Degree,
    required this.QuestionType,
    required this.Text,
    required this.CorrectAnswer,
    required this.Image,
    required this.Choices,
  });

  factory ExamQuestion.fromJson(Map<String, dynamic> json) =>
      ExamQuestion(
        QuestionId: json['QuestionId'],
        Degree: json['Degree'],
        QuestionType: json['Order'],
        Text: json['QuestionText'],
        CorrectAnswer: json['CorrectAnswer'],
        Image: json['Image'],
        Choices: json['Choices'].map<CustomAnswer>((e)=> CustomAnswer.fromJson(e)).toList(),
      );
}
