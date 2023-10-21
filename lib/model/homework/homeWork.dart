class HomeWork{
      int HomeworkId ;
      String Title ;
      String EndDate;
      double Degree;
      double MaxDegree;
      bool Passed;
      bool Corrected;

      HomeWork({required this.HomeworkId,required this.Title,required this.EndDate,required this.Degree,
        required this.MaxDegree,required this.Passed,required this.Corrected });
      factory HomeWork.fromJson (Map<String,dynamic> json) =>
      HomeWork(
      HomeworkId: json['HomeworkId'],
      Title: json['Title'],
      EndDate: json['EndDate'],
      Degree: json['Degree'],
      MaxDegree: json['MaxDegree'],
      Passed: json['Passed'] ,
      Corrected: json['Corrected']);
}