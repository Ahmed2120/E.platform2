import 'dart:convert';

import 'package:eplatform/model/courses/course.dart';
import 'package:eplatform/model/group/group.dart';
import 'package:eplatform/model/teacherModels/teacherHomeCourse.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../api/api.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'teacherGroup.dart';

mixin TeacherHomeModel on Model{

  //-------------- Groups and courses----------------
  bool _c_Loading = false;
  bool get   homeTeacherCoursesLoading => _c_Loading;

  bool _g_Loading=false;
  bool get   teacherHomeGroupLoading => _g_Loading;

  List<TeacherHomeCourse> _homeCourseList= [];
  List<TeacherHomeCourse> get teacherHomeCourseList => _homeCourseList;

  List<TeacherGroup> _homeGroupList= [];
  List<TeacherGroup> get teacherHomeGroupList => _homeGroupList;

  //-------------------GetLatestBlog------------------
  bool _blogLoading = false;
  bool get  allBlogLoading => _blogLoading;


  Future fetchTeacherHomeGroups () async{
    _g_Loading=true;
    notifyListeners();

    try {
      var response = await CallApi().getData("/api/Home/GetHomeTeacherGroups", 1);
     // print ("groups "+response.body);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);

        _homeGroupList = body.map((e) => TeacherGroup.fromJson(e)).toList();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _g_Loading=false;
      notifyListeners();
    }
    catch(e){
      _g_Loading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }

  Future fetchTeacherHomeCourses () async{
    _c_Loading=true;
    notifyListeners();

    try {
      var response = await CallApi().getData("/api/Home/GetHomeTeacherCourses", 1);
     // print ("Courses "+response.body);

      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _homeCourseList = body.map((e) => TeacherHomeCourse.fromJson(e)).toList();
        notifyListeners();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _c_Loading=false;
      notifyListeners();
    }
    catch(e){
      _c_Loading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }





}