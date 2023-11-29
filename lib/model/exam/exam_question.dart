import '../customModel.dart';
import '../teacherModels/teacher_examDetails.dart';

class StudentExamQuestion{
  int? ExamId;
  int? TeacherId;
  int? CourseId;
  String Title ;
  String SubjectName;
  int? ExamDuration;
  double? ExamDegree;
  String? EndDate;
  List<ExamQuestion>? ExamQuestions;

  List<CustomModel>? EducationTypes;
  List<CustomModel>? ProgramTypes;
  List<CustomModel>? Grades;
  List<CustomModel>? ExamSubjects;

  StudentExamQuestion({ required this.ExamId,required this.Title,required this.SubjectName,
    required this.EndDate,required this.TeacherId,required this.CourseId,required
    this.ExamDuration,required this.ExamDegree,
    required this.EducationTypes, required this.ProgramTypes,
    required this.Grades, required this.ExamSubjects, required this.ExamQuestions, });

  factory  StudentExamQuestion.fromJson(Map<String, dynamic> json)=>
      StudentExamQuestion(
          ExamId: json['ExamId'],
        TeacherId: json['TeacherId'],
        CourseId: json['CourseId'],
          Title: json['Title'],
          SubjectName:json['SubjectName']==null?'الماده':json['SubjectName'],
          EndDate: json['EndDate'],
        ExamDuration: json['ExamDuration'],
        EducationTypes: json['EducationTypes']?.map<CustomModel>((e)=> CustomModel.fromJson(e)).toList(),
        ProgramTypes: json['ProgramTypes']?.map<CustomModel>((e)=> CustomModel.fromJson(e)).toList(),
        Grades: json['Grades']?.map<CustomModel>((e)=> CustomModel.fromJson(e)).toList(),
        ExamSubjects: null,
        // ExamSubjects: json['ExamSubjects']?.map<CustomModel>((e)=> CustomModel.fromJson(e)).toList(),
        ExamDegree: json['ExamDegree'],
        ExamQuestions: json['ExamQuestions']?.map<ExamQuestion>((e)=> ExamQuestion.fromJson(e)).toList(),
      );

}