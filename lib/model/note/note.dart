class Note{
  int TeacherId;
  String TeacherName;
  int SubjectId;
  String SubjectName;
  double Rate;
  int FollowersCount;

  Note({required this.TeacherId, required this.TeacherName,required this.SubjectId,
    required this.SubjectName ,required this.Rate,required this.FollowersCount});

  factory  Note.fromJson(Map<String, dynamic> json)=>
      Note (
        TeacherId :json['TeacherId'] ,
        TeacherName : json['TeacherName'],
        SubjectId:json['SubjectId'],
        SubjectName : json['SubjectName'],
        Rate:json['Rate'],
        FollowersCount:json['FollowersCount']


      );
}