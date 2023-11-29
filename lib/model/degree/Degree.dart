class Degree{
  int Id ;
  String SubjectName;
  String ExamTitle ;
  double ExamDegree ;
  String SubjectImage;
  double StudentDegree;
  bool Passed ;
  String StudentExamAnswers ;

  Degree({
    required  this.Id,
    required this.SubjectName,
    required  this.ExamTitle,
    required this.ExamDegree,
    required  this.SubjectImage,
    required  this.StudentDegree,
    required  this.Passed,
    required this.StudentExamAnswers });

  factory  Degree.fromJson(Map<String, dynamic> json)=>
      Degree (
        Id :json['Id'] ,
        SubjectName : json['SubjectName']??'',
        ExamTitle : json['ExamTitle'],
        ExamDegree : json['ExamDegree'],
        SubjectImage : json['SubjectImage'] ==null ? 'assets/images/english.png'  :
        json['SubjectImage'],
          StudentDegree : json['StudentDegree'],
          Passed : json['Passed'],
          StudentExamAnswers : json['StudentExamAnswers']==null ?'' :json['StudentExamAnswers']
      );
}