class NotPassedExam{
   int ExamId;
    String Title ;
    String SubjectName;
   String EndDate;
    bool TimeIsUp;

   NotPassedExam({ required this.ExamId,required this.Title,required this.SubjectName,
     required this.EndDate,required this.TimeIsUp});
   factory  NotPassedExam.fromJson(Map<String, dynamic> json)=>
       NotPassedExam(
           ExamId: json['ExamId'],
           Title: json['Title'],
           SubjectName:json['SubjectName']==null?'الماده':json['SubjectName'],
           EndDate: json['EndDate'],
           TimeIsUp: json['TimeIsUp']);

}