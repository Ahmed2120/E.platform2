
import 'dart:convert';

import 'package:eplatform/api/api.dart';
import 'package:eplatform/widgets/dialogs/alertMsg.dart';
import 'package:scoped_model/scoped_model.dart';

import 'teacherGroupSessions.dart';

mixin TeacherGroupSessionsANDStudentModel on Model{
  //------------------Group Session------------------
  bool _loading = false;
  bool get   teacherGroupSessionsLoading => _loading;

  List<TeacherGroupSessions> _teacherSessionList= [];
  List<TeacherGroupSessions> get allTeacherGroupSessions => _teacherSessionList;

  //--------------------Group Student------------------

  bool _StudentLoading = false;
  bool get   teacherGroupStudentsLoading => _StudentLoading;

  List _teacherStudentsList= [];
  List get allTeacherGroupStudents => _teacherStudentsList;

  Future fetchTeacherGroupSessions  (int ? groupId) async{
    _loading=true;
    notifyListeners();
    Map <String,dynamic>data={
      'groupId':groupId.toString()
    };
    try {
      var response = await CallApi().getWithBody(data,"/api/GroupVideo/GetGroupSessions", 1);
      //  print ("notes   "+response.body);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _teacherSessionList = body.map((e) => TeacherGroupSessions.fromJson(e)).toList();
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

  Future fetchTeacherGroupStudents  (int ? groupId) async{
    _StudentLoading=true;
    notifyListeners();
    Map <String,dynamic>data={
      'groupId':groupId.toString()
    };
    try {
      var response = await CallApi().getWithBody(data,"/api/Group/GetGroupStudents", 1);
      //  print ("notes   "+response.body);
      if (response != null && response.statusCode == 200) {
        _teacherStudentsList = json.decode(response.body);
     //   _teacherSessionList = body.map((e) => TeacherGroupSessions.fromJson(e)).toList();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _StudentLoading=false;
      notifyListeners();
    }
    catch(e){
      _StudentLoading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }






}