class Schedule{
  int GroupId;
  int TeacherId;
  int Day;
  int SubjectId;
  String TeacherName;
  String SubjectName;
  String FromTime;
  String ToTime;

  Schedule({required this.GroupId, required this.TeacherId, required this.Day,required this.SubjectId,
    required this.TeacherName, required this.SubjectName, required this.FromTime, required this.ToTime, });
  factory  Schedule.fromJson(Map<String, dynamic> json)=>
      Schedule (
          GroupId :json['GroupId'] ,
          TeacherId :json['Group'] ['TeacherId'] ,
          TeacherName : json['Group']['TeacherName'],
          SubjectId:json['Group']['SubjectId'],
          SubjectName : json['Group']['SubjectName'],
          Day:json['Day'],
          FromTime:json['FromTime'],
        ToTime:json['ToTime'],


      );
}