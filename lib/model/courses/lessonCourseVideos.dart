 import 'package:eplatform/session/userSession.dart';

class LessonCourseVideo{
     int CourseVideoId;
     String ? Title;
     String ? VideoUrl;
      var   Duration;
      String videoImg;

   LessonCourseVideo({ required this.CourseVideoId,required this.Title,required this.VideoUrl,
   required this.Duration ,required this.videoImg});

   factory  LessonCourseVideo.fromJson(Map<String, dynamic> json)=>
       LessonCourseVideo(
           CourseVideoId: json['CourseVideoId'],
           Title:json['Title'],
           VideoUrl: UserSession.getURL()+json['VideoUrl'],
           Duration:json['Duration'],
           videoImg:json['videoImg']==null ?
           'https://images.pexels.com/photos/1055613/pexels-photo-1055613.jpeg?auto=compress&cs=tinysrgb&w=1600'
               :'http://asmaareham-001-site1.itempurl.com/'+
               UserSession.getURL()+json['videoImg']

       );

 }