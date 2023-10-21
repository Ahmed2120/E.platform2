import 'lessonCourseVideos.dart';

class CourseDetails{
  String ?TeacherName;
  String ?GradeName;
  String ?SubjectName;
  String ?SubjectBranchName;
  bool ?IsSubscribed;
  List <LessonCourseVideo> ? CourseVideos;

  CourseDetails({this.TeacherName, this.GradeName, this.SubjectName,
      this.SubjectBranchName, this.IsSubscribed, this.CourseVideos });

  factory  CourseDetails.fromJson(Map<String, dynamic> json)=>
      CourseDetails (
        TeacherName :json['TeacherName'] ,
        GradeName : json['GradeName'],
        SubjectName : json['SubjectName'],
        SubjectBranchName : json['SubjectBranchName'],
        IsSubscribed : json['IsSubscribed'],
        CourseVideos: json['CourseVideos'].map((e) =>LessonCourseVideo.fromJson(e)).toList()

      );
}