import 'dart:convert';

import 'package:eplatform/model/courses/course.dart';
import 'package:eplatform/model/group/group.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'customHome.dart';

mixin HomeModel on Model{

  //--------------------Home Schools---------------------------
  bool _Loading = false;
  bool get   homeSchoolLoading => _Loading;

  List<CustomHome> _homeSchoolList= [];
  List<CustomHome> get homeSchoolList => _homeSchoolList;

  //-------------- Groups and courses----------------
  bool _courses_Loading = false;
  bool get   homeCoursesLoading => _courses_Loading;

  List<Course> _homeCourseList= [];
  List<Course> get homeCourseList => _homeCourseList;

  List<Group> _homeGroupList= [];
  List<Group> get homeGroupList => _homeGroupList;

  //-------------------GetLatestBlog------------------
  bool _blogLoading = false;
  bool get  allBlogLoading => _blogLoading;

  List<CustomHome> _homeBlogs= [];
  List<CustomHome> get homeBloglList => _homeBlogs;



  Future fetchHomeSchools () async{
    _Loading=true;
    notifyListeners();

    try {
      var response = await CallApi().getData("/api/School/GetSchools", 1);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _homeSchoolList = body.map((e) => CustomHome.fromJson(e)).toList();
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

  Future fetchHomeCourses_AND_Groups () async{
    _courses_Loading=true;
    notifyListeners();

    try {
      var response = await CallApi().getData("/api/Home/GetCoursesAndGroups", 1);
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        List c=body['Courses'];
        List g=body['Groups'];
        _homeCourseList = c.map((e) => Course.fromJson(e)).toList();
        _homeGroupList = g.map((e) => Group.fromJson(e)).toList();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _courses_Loading=false;
      notifyListeners();
    }
    catch(e){
      _courses_Loading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }

  Future  fetchLatestBlog () async{
    _blogLoading=true;
    notifyListeners();

    try {
      var response = await CallApi().getData( "/api/Blog/GetLatestBlog", 1);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
       print('-----------------0000000000--------------------');
       print('object '+body.toString());
        _homeBlogs = body.map((e) => CustomHome.fromJson(e)).toList();
        notifyListeners();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _blogLoading=false;
      notifyListeners();
    }
    catch(e){
      _blogLoading=false;
      notifyListeners();
      print('home  ee '+e.toString());
    }
  }





}