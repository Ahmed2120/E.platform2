class PassedExam{
    int ExamId ;
    String Title;
    String SubjectName;
    String EndDate;
    double Degree;
    double MaxDegree;
    bool Passed;
    bool Corrected ;

    PassedExam({ required  this.ExamId,required this.Title,required this.SubjectName,
      required this.EndDate,required this.Degree,required this.MaxDegree,
      required this.Passed,required this.Corrected });
     factory  PassedExam.fromJson(Map<String, dynamic> json)=>
        PassedExam(
            ExamId: json['ExamId'],
            Title: json['Title'],
            SubjectName:json['SubjectName']==null?'الماده':json['SubjectName'],
            EndDate: json['EndDate'],
            Degree: json['Degree'],
            MaxDegree: json['MaxDegree'],
            Passed: json['Passed'],
            Corrected: json['Corrected']
        );
}