import 'courses/lessonCourseVideos.dart';

class CourseContent{
  String Title;
   int LessonsCount;
     var Price ;
     List<LessonCourseVideo>CourseVideos;

  CourseContent({ required this.Title,required this.LessonsCount,
    required this.Price,required this.CourseVideos});

  factory  CourseContent.fromJson(Map<String, dynamic> json){
     List v=json['CourseVideos'];
    return CourseContent(
        Title: json['Title'],
        LessonsCount: json['LessonsCount'],
        Price: json['Price'],
        CourseVideos: v.map((e) => LessonCourseVideo.fromJson(e)).toList()
    );
  }
}