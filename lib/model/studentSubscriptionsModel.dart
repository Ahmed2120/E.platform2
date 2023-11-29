
import 'dart:convert';

import 'package:eplatform/model/group/group.dart';
import 'package:scoped_model/scoped_model.dart';

import '../api/api.dart';
import '../widgets/dialogs/alertMsg.dart';
import 'courses/course.dart';

mixin StudentSubscriptionsModel  on Model{

  bool _loading=false;
  bool get StudentSubscriptionsLoading =>_loading;
  //////////////////courses
  List <Course> _courses=[];
  List <Course> get StudentSubscriptionsCoursesList=>_courses;

  ////////////////groups
  List <Group> _groups=[];
  List <Group> get StudentSubscriptionsGroupsList=>_groups;


  Future fetchStudentSubscriptions (int ? subject_id ) async{

    Map<String,dynamic> data={'subjectId' : subject_id.toString()};

    _loading=true;

    notifyListeners();

    try {
      var response = await CallApi().getWithBody(data, "/api/Student/GetStudentSubscriptions", 1);
        print('(((((((((((((((((())))))))))))))))))');
        print(json.decode(response.body));
        var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        List courses=body['Courses'];
        List groups=body['Groups'];
        _courses=courses.map((e) => Course.fromJson(e)).toList();
        _groups=groups.map((e) => Group.fromJson(e)).toList();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _loading=false;
      notifyListeners();
    }
    catch(e){
      _loading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }

}