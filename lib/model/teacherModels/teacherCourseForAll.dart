 import 'teacherCourseLessonDetails.dart';

class TeacherCourseForAll{

    int CourseId;
    String Title;
    String SubjectName;
    int StudentsCount;
    int SessionsCount;
    double Price;
    List<TeacherCourseLessonDetails>CourseLessonDetails;
    TeacherCourseForAll({required this.CourseId,required this.Title,required this.SubjectName,
      required this.StudentsCount,required this.SessionsCount,required this.Price,
        required this.CourseLessonDetails});

    factory  TeacherCourseForAll.fromJson(Map<String, dynamic> json){
        List cc=json['CourseLessonDetails'];

        return  TeacherCourseForAll(
            CourseId: json['CourseId'],
            Title: json['Title'],
            SubjectName: json['SubjectName'] ?? '',
            StudentsCount: json['StudentsCount'],
            SessionsCount: json['SessionsCount'],
            Price: json['Price']==null ?0.0 :json['Price'],
            CourseLessonDetails:cc.map((e) =>TeacherCourseLessonDetails.fromJson(e)).toList()
     ); }

}