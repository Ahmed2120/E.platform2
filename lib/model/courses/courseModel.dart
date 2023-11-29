import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../api/api.dart';
import '../../session/userSession.dart';
import '../../widgets/dialogs/alertMsg.dart';
import '../courseContent.dart';
import 'course.dart';
import 'courseVideoAttachments.dart';
import 'courseVideoComments.dart';
import 'lessonCourseVideos.dart';
import 'teacherCourses.dart';




mixin CourseModel on Model{

  /////////////////////course
  bool _courseLoading = false;
  bool get   courseLoading => _courseLoading;

  List<Course> _courses = [];
  List<Course> get allCourses => _courses;

///////////////cousrse content
  bool _courseContentLoading = false;
  bool get   courseContentLoading => _courseContentLoading;


  String  _content_TeacherName='';
  String get ContentTeacherName=>_content_TeacherName ;

  String _content_GradeName='';
  String get ContentGradeName=>_content_GradeName;

  String _content_SubjectName='';
  String get ContentSubjectName=>_content_SubjectName;

//////////////////////////Teacher Courses

  bool _teacherCoursesLoading = false;
  bool get   teacherCourseLoading => _teacherCoursesLoading;

  List<TeacherCourses> _teacherCourses = [];
  List<TeacherCourses> get allTeacherCourses => _teacherCourses;


  /////////////////////////

  bool _courseLessonDetailsLoading = false;
  bool get   CourseLessonDetailsLoading => _courseLessonDetailsLoading;

  List<LessonCourseVideo> _courseLessonDetails = [];
  List<LessonCourseVideo> get allCourseLessonDetails => _courseLessonDetails;

  //////////////////////////////GetCourseLessonDetails
  String _LessonTitle='';
  String get LessonTitle =>_LessonTitle;

  String _LessonSubjectName='' ;
  String get LessonSubjectName=>_LessonSubjectName;

  String _FirstLessonVideoUrl='';
  String get FirstLessonVideoUrl=>_FirstLessonVideoUrl;

  List<CourseVideoComments>_FirstLessonVideoComments=[];
  List<CourseVideoComments> get  FirstLessonVideoComments =>_FirstLessonVideoComments;

  List<CourseVideoAttachments>_FirstLessonVideoAttachments=[];
  List<CourseVideoAttachments> get  FirstLessonVideoAttachments =>_FirstLessonVideoAttachments;

  String _firstVideoTitle='';
  String get FirstVideoTitle=>_firstVideoTitle;


  ///-------------------------------------------------------------------------------------------

  bool _Loading=false;
  bool get  courseVideoAttachmentsLoading=>_Loading;

  /////////////////////////attachment
  List <CourseVideoAttachments> _courseVideoAttachments=[];
  List <CourseVideoAttachments> get CourseVideoAttachmentsList=>_courseVideoAttachments;

  //////////////////////////comment
  List <CourseVideoComments> _courseVideoComments=[];
  List <CourseVideoComments> get CourseVideoCommentsList=>_courseVideoComments;



  //////////////////////add comment
  bool _comment_Loading=false;
  bool get AddCourseCommentLoading =>_comment_Loading;

  //-------------------------add rate-------------------------------------
  bool _rate_Loading=false;
  bool get AddCourseRateLoading1 =>_rate_Loading;

  //-------------------------Subscribe Course-------------------------------------
  bool _subscribeCourse_loading=false;
  bool get subscribeCourse_loading =>_subscribeCourse_loading;

  //-------------------------Subscribe Lesson-------------------------------------
  bool _subscribeLesson_loading=false;
  bool get subscribeLesson_loading =>_subscribeLesson_loading;


  Future  fetchCourses(int ? subject_id , String? TeacherName)  async{

    Map<String,dynamic> data={'subjectId' : subject_id.toString()};


    _courseLoading=true;
    notifyListeners();

    try {
      var response = await CallApi().getWithBody(data,
          "/api/Course/GetCourses" ,1);

      //  print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _courses=body.map((e) => Course.fromJson(e)).toList();
        // print("sub  "+_subjects[0].Name);
      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }

      _courseLoading=false;
      notifyListeners();
    }
    catch(e){

      _courseLoading=false;
      notifyListeners();

      print('ee '+e.toString());
    }
  }

  Future  fetchTeacherCourses(int teacherId , int? subjectId)  async{

    Map<String,dynamic> data={
      'teacherId' : teacherId.toString(),
      'subjectId':subjectId.toString()
    };
    _teacherCoursesLoading=true;
    notifyListeners();

    try {
      var response = await CallApi().getWithBody(data, "/api/Course/GetTeacherCourses",1);

       print(json.decode(response.body));
      List body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {

        List c=body[0]['TeacherCourses'];
        _teacherCourses=c.map((e) => TeacherCourses.fromJson(e)).toList();

        _content_TeacherName=body[0]['TeacherName'];
        _content_GradeName=body[0]['GradeName'];
        _content_SubjectName=body[0]['SubjectName'];
        notifyListeners();
        print("video  "+c.length.toString());
      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _teacherCoursesLoading=false;
      notifyListeners();
    }
    catch(e){
      _teacherCoursesLoading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }

  Future  fetchCourseLessonDetails(int courseLessonId)  async{

    Map<String,dynamic> data={
      'courseLessonId' : courseLessonId.toString(),
    };
    _courseLessonDetailsLoading=true;
    notifyListeners();

    try {
      var response = await CallApi().getWithBody(data, "/api/Course/GetCourseLessonDetails",1);

     print('ooooooooooooooooooo----------oooooooooooooooo');
     print(json.decode(response.body));
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {

        _LessonTitle=body['LessonTitle'];
        _LessonSubjectName=body['SubjectName'];

       _FirstLessonVideoUrl= UserSession.getURL()+body['FirstLessonVideoUrl'];
       print('lllllllllll: $_FirstLessonVideoUrl');
        notifyListeners();

        print(_FirstLessonVideoUrl);

        List videos=body['CourseVideos'];
        _courseLessonDetails=videos.map((e) => LessonCourseVideo.fromJson(e)).toList();

        List comments=body['FirstLessonVideoComments'];
        _FirstLessonVideoComments=comments.map((e) => CourseVideoComments.fromJson(e)).toList();

        List attach=body['FirstLessonVideoAttachments'];
        _FirstLessonVideoAttachments=attach.map((e) => CourseVideoAttachments.fromJson(e)).toList();
        notifyListeners();

      if(_courseLessonDetails.length >0){

        fetchCourseVideo_Attachments_AND_Comments(_courseLessonDetails[0].CourseVideoId);
        _firstVideoTitle=_courseLessonDetails[0].Title!;

        notifyListeners();
      }

      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _courseLessonDetailsLoading=false;
      notifyListeners();
    }
    catch(e){
      _courseLessonDetailsLoading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }

  Future fetchCourseVideo_Attachments_AND_Comments (int courseVideoId, ) async{
    _Loading=true;
    _courseVideoComments=[];
    _courseVideoAttachments=[];
    notifyListeners();
    Map <String,dynamic>  data ={
      'courseVideoId':courseVideoId.toString(),
    };
    try {
      var response = await CallApi().getWithBody(data, "/api/CourseVideo/GetCourseVideoDetails", 1);
      if (response != null && response.statusCode == 200) {
        var body = json.decode(response.body);

         // print('comments   '+body.toString());

      /*  _courseVideoURL=body['VideoUrl'] ==null ?
        'https://videos.pond5.com/abstract-aerial-sea-summer-ocean-footage-194530000_main_xxl.mp4':
           UserSession.getURL()+body['VideoUrl'] ;*/

        List attach=body['CourseVideoAttachments'];
        List comm=body['CourseVideoComments'];

        _courseVideoAttachments=attach.map((e) => CourseVideoAttachments.fromJson(e)).toList();
        _courseVideoComments=comm.map((e) => CourseVideoComments.fromJson(e)).toList();
        notifyListeners();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _Loading=false;
      notifyListeners();
    }
    catch(e){
      _Loading=false;
      notifyListeners();
      print('ee '+e.toString());
    }

  }

  Future addCourseVideoComment (int CourseVideoId,String Comment,controller ) async{
    _comment_Loading=true;
    Map session = await UserSession.GetData();
    notifyListeners();

    Map  data ={
      'CourseVideoId':CourseVideoId.toString(),
      'Comment':Comment
    };

    try {
      var response = await CallApi().
      postData(data, "/api/CourseVideo/AddCourseVideoComment", 1);
      //   print(json.decode(response.body));
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        if(body['Succeeded']==true){
          print (body.toString());

          _courseVideoComments.add(new  CourseVideoComments(
              Id: body['Id'],
              Comment: Comment, CreatedAt: '',
              CreatedById: 'CreatedById',
              UserName:session['name']
          ),
          );
          // ShowMyDialog.showMsg('تم اضافة التعليق بنجاح',
          // );
          controller.text="";
          notifyListeners();

        }
      }
      else {
        ShowMyDialog.showMsg(body['Message']);
      }
      _comment_Loading=false;
      notifyListeners();
    }
    catch(e){
      _comment_Loading=false;
      notifyListeners();
      print('ee '+e.toString());
    }

  }

  Future addCourseVideoRate (int CourseVideoId ,int Rate , context) async{

    Map <String,dynamic> data ={
      'CourseVideoId':CourseVideoId.toString(),
      'Rate':Rate.toString()
    };
    _rate_Loading=true;
    notifyListeners();
    try {
      var response = await CallApi().postData(data, "/api/CourseVideo/AddCourseVideoRate", 1);
      print(json.decode(response.body));
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {

        _rate_Loading=false;
        notifyListeners();

        if(body['Succeeded']==true){
          Navigator.of(context).pop();

          ShowMyDialog.showMsg('تم التقييم بنجاح');
        }

      }
      else {
        ShowMyDialog.showMsg(body['Message']);
      }
      _rate_Loading=false;
      notifyListeners();
    }
    catch(e){
      _rate_Loading=false;
      notifyListeners();
      print('ee '+e.toString());
    }

  }

  Future subscribeCourse (int courseId , context,index) async{

    Map <String,dynamic> data ={
      'courseId': courseId.toString(),
    };
    _subscribeCourse_loading=true;
    notifyListeners();
    try {
      var response = await CallApi().postWithBody(data, "/api/Course/SubscribeCourse", 1);
      print(json.decode(response.body));
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {

        _subscribeCourse_loading=false;
        notifyListeners();
        if(body['Success']){

          ShowMyDialog.showMsg('تم الإشتراك بنجاح');
          _teacherCourses[index].IsSubscribed=true;
          notifyListeners();

        }


      }
      else {
        ShowMyDialog.showMsg(body['Message']);
      }
      _subscribeCourse_loading=false;
      notifyListeners();
    }
    catch(e){
      _subscribeCourse_loading=false;
      notifyListeners();
      print('ee '+e.toString());
      ShowMyDialog.showMsg(e.toString());
    }

  }

  Future subscribeLesson (int courseId , context,index, {int? courseLessonId}) async{

    Map <String,dynamic> data ={
      'courseId': courseId.toString(),
      'courseLessonId': courseLessonId.toString(),
    };
    _subscribeLesson_loading=true;
    notifyListeners();
    try {
      var response = await CallApi().postWithBody(data, "/api/Course/SubscribeCourse", 1);
      print(json.decode(response.body));
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {

        _subscribeLesson_loading=false;
        notifyListeners();
        if(body['Success']){


          final course = _teacherCourses.firstWhere((element) => element.CourseId == courseId);
          course.courseLessons.firstWhere((element) => element.LessonId == courseLessonId).IsSubscribed = true;

          ShowMyDialog.showSnack(context, 'تم الإشتراك بنجاح');
          _teacherCourses[index].IsSubscribed=true;
          notifyListeners();

        }


      }
      else {
        ShowMyDialog.showMsg(body['Message']);
      }
      _subscribeLesson_loading=false;
      notifyListeners();
    }
    catch(e){
      _subscribeLesson_loading=false;
      notifyListeners();
      print('ee '+e.toString());
      ShowMyDialog.showMsg(e.toString());
    }

  }

}