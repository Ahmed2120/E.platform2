class TeacherExam{
   int  ExamId ;
   String Title;
   int SubjectId;
    String SubjectName ;

   TeacherExam({required this.ExamId,required this.Title,required this.SubjectId,required this.SubjectName});
   factory  TeacherExam.fromJson(Map<String, dynamic> json)=>
       TeacherExam(
           ExamId: json['ExamId'],
           Title: json['Title'],
           SubjectId: json['SubjectId']==null?0:json['SubjectId'],
           SubjectName: json['SubjectName']??'');
}