import 'courseLessons.dart';

class TeacherCourses{
  int CourseId;
  String Title;
  double Price;
  var Duration;
  var TotalLessonsPrice;
  int LessonsCount;
  bool IsSubscribed;
  List<CourseLessons> courseLessons;


  TeacherCourses({ required this.CourseId,required this.Title,
    required this.Duration,required this.Price,required this.TotalLessonsPrice ,
    required this.LessonsCount,required this.IsSubscribed,
    required this.courseLessons });

  factory  TeacherCourses.fromJson(Map<String, dynamic> json){
    List c=json['CourseLessons'];
    return  TeacherCourses(
        CourseId: json['CourseId'],
          Title: json['Title'],
          Duration: json['Duration'],
          Price: json['Price'],
          TotalLessonsPrice:json['TotalLessonsPrice'],
          LessonsCount:json['LessonsCount'],
          IsSubscribed:json['IsSubscribed'] ,
          courseLessons :c.map((e) => CourseLessons.fromJson(e)).toList()
    );

      }





}