import 'package:eplatform/session/userSession.dart';

class TeacherCourseLessonDetails{
   int LessonId;
   String  LessonTitle;
   int SubjectId;
   String SubjectName;
   String FirstLessonVideoUrl;
   double LessonPrice;
   List  CourseVideos;

   TeacherCourseLessonDetails({required this.LessonId,required this.LessonTitle,required this.SubjectId,
     required this.SubjectName,required this.FirstLessonVideoUrl,
      required this.LessonPrice,required this.CourseVideos});

   factory TeacherCourseLessonDetails.fromJson(Map<String,dynamic>json)=>
       TeacherCourseLessonDetails(
           LessonId: json['LessonId'],
           LessonTitle: json['LessonTitle'],
           SubjectId: json['SubjectId'],
           SubjectName: json['SubjectName']??'',
           FirstLessonVideoUrl: json['FirstLessonVideoUrl']==null?'':
          UserSession.getURL()+json['FirstLessonVideoUrl'],
           LessonPrice:json['LessonPrice']==null?0.0:json['LessonPrice'],
           CourseVideos:json['CourseVideos']
       );
}