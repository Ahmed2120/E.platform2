import '../../session/userSession.dart';

class Course{
  int CourseId;
  int TeacherId;
  String ? TeacherName;
  String ? TeacherPicture;
  int SubjectId;
  String SubjectName;


  Course({required this.CourseId,required this.TeacherId,required this.TeacherName,
    required this.TeacherPicture,
    required this.SubjectId, required this.SubjectName});

  factory  Course.fromJson(Map<String, dynamic> json)=>
      Course (
        CourseId :json['CourseId'] ==null ? 0 : json['CourseId'],
        TeacherId : json['TeacherId'],
        TeacherName : json['TeacherName']==null ?'': json['TeacherName'],
        TeacherPicture: json['TeacherPicture'] ==null?'':
        UserSession.getURL()+json['TeacherPicture'],
        SubjectId : json['SubjectId'],
        SubjectName : json['SubjectName'],
      );


}