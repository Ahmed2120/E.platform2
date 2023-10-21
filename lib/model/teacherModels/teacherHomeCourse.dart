import '../../session/userSession.dart';

class TeacherHomeCourse{
    int CourseId ;
    String CourseName;
    String SubjectPicture;
    double Rate;

    TeacherHomeCourse({required
      this.CourseId,required this.CourseName,required this.SubjectPicture,required this.Rate });
    factory  TeacherHomeCourse.fromJson(Map<String, dynamic> json)=>
        TeacherHomeCourse(
            CourseId:json['CourseId'],
            CourseName:json['CourseName'],
            SubjectPicture:UserSession.getURL() +json['SubjectPicture'],
            Rate:json['Rate']);
}