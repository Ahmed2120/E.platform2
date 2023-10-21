
import 'dart:convert';

import 'package:eplatform/api/api.dart';
import 'package:eplatform/widgets/dialogs/alertMsg.dart';
import 'package:scoped_model/scoped_model.dart';

import 'teacherCourseForAll.dart';
import 'teacherCourseLessonDetails.dart';

mixin CreatedTeacherCoursesModel on Model{
//-----------courses------------------------
  bool _Loading=false;
  bool get  showAllTeacherCreatedCourseLoading=>_Loading;

  List<TeacherCourseForAll>_list=[];
  List<TeacherCourseForAll> get allTeacherCreatedCourses=>_list;

  //-----------lesson------------------------
  bool _lessonLoading=false;
  bool get  lessonLoading=>_lessonLoading;

  TeacherCourseLessonDetails? _teacherCourseLessonDetails;
  TeacherCourseLessonDetails? get teacherCourseLessonDetails=>_teacherCourseLessonDetails;

  //---------- delete--------------
  bool _deleteLoading=false;
  bool get  deleteTeacherCreatedCourseLoading=>_deleteLoading;

  fetchAllTeacherCreatedCourses(int ? subjectId ,int ? educationTypeId,int ? gradeId ,int ? ProgramTypeId ) async{

    _Loading=true;
    notifyListeners();

    Map<String,dynamic> data={
      'subjectId':subjectId.toString(),
      'educationTypeId':educationTypeId.toString(),
      'gradeId':gradeId.toString(),
      'ProgramTypeId':ProgramTypeId.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,"/api/Course/ShowTeacherAllCourses", 1);
    //   print ("courses "+response.body);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);

        _list = body.map((e) => TeacherCourseForAll.fromJson(e)).toList();
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
      print('courses ee '+e.toString());
    }




  }

  fetchTeacherCourseLessonDetails(int ? courseLessonId ) async{

    _lessonLoading=true;
    notifyListeners();

    Map<String,dynamic> data={
      'courseLessonId':courseLessonId.toString(),
    };

    try {
      var response = await CallApi().getWithBody(data,"/api/Course/GetCourseLessonDetails", 1);
    //   print ("courses "+response.body);
      if (response != null && response.statusCode == 200) {
        final body = json.decode(response.body);

        _teacherCourseLessonDetails = TeacherCourseLessonDetails.fromJson(body);
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _lessonLoading=false;
      notifyListeners();
    }
    catch(e){
      _lessonLoading=false;
      notifyListeners();
      print('courses ee '+e.toString());
    }




  }

  deleteTeacherCreatedCourseLesson(int ? courseId ,int index,int index1 ) async{
    _deleteLoading=true;
    notifyListeners();

    try {
      var response = await CallApi().delete(null,"/api/Course/DeleteCourseLesson?courseLessonId="+courseId.toString(),
          1);
     print ("delete  "+response.body);

      var body = json.decode(response.body);

      if (response != null && response.statusCode == 200) {
        _list[index].CourseLessonDetails.removeAt(index1);

        _deleteLoading=false;
        notifyListeners();
        ShowMyDialog.showMsg('تم حذف الدرس بنجاح');

      }else{
        ShowMyDialog.showMsg(body['Message']);
      }

      _deleteLoading=false;
      notifyListeners();
    }
    catch(e){
      _deleteLoading=false;
      notifyListeners();
      print('ee '+e.toString());
    }




  }


}