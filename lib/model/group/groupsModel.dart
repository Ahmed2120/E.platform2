
import 'dart:convert';

import 'package:eplatform/main.dart';
import 'package:eplatform/model/group/teacherGroups.dart';
import 'package:eplatform/session/userSession.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'group.dart';
import 'groupVideo.dart';

mixin TeacherGroupsModel on Model{

  //------------------group----------------------------
  bool _groupLoading = false;
  bool get   groupLoading => _groupLoading;

  List<Group> _groups = [];
  List<Group> get allGroups => _groups;

//_________________________teacher groups____________________________

  bool _loading=false;
  bool get TeacherGroupsLoading=>_loading;

  List <TeacherGroups>_teacherGroupslist=[];
  List <TeacherGroups> get TeacherGroupsList=>_teacherGroupslist;

  String _TeacherName='';
  String get groupTeacherName=>_TeacherName;

  String _GradeName='';
  String get groupGradeName=>_GradeName;

  String _SubjectName='';
  String get groupSubjectName=>_SubjectName;

  //--------------Subscribe Group--------------
  bool _subscribeloading=false;
  bool get  subscribeGroupsLoading=>_subscribeloading;


  //----------Group Detailsss----------------

  bool _GroupDetailsloading=false;
  bool get GroupDetailsLoading=>_GroupDetailsloading;

  String   _groupDetailsTeacherName='' ;
  String get GroupDetailsTeacherName=>_groupDetailsTeacherName;

  String   _gradeName='';
  String get GroupDetailsGradeName=>_gradeName!;

  late String   _GroupDetailsloadingSubjectName='';
  String get  GroupDetailsSubjectName=>_GroupDetailsloadingSubjectName;

  late  double  _Price;
  double get GroupDetailsPrice=>_Price;

  String  _StartDate='';
  String get GroupDetailsStartDate=>_StartDate!;

  int  _SessionsCount=0;
  int get GroupDetailsSessionsCount =>_SessionsCount!;

  String  _Days='';
  String get GroupDetailsDays =>_Days! ;

  String ? _groupPeriod='';
  String get  GroupDetailsGroupPeriod =>_groupPeriod!;

  String  _groupDetailsIntroVideoURL='';
  String get GroupDetailsIntroVideoURL =>_groupDetailsIntroVideoURL;

  String _groupDescription='';
  String get  GroupDetailsDescription =>_groupDescription;


  List <GroupVideo>  _groupDetailsGroupVideo=[];
  List<GroupVideo> get  allGroupDetailsGroupVideo=>_groupDetailsGroupVideo;

  //----------Group Video----------------

  bool _oldOrNewClassesloading=false;
  bool get oldOrNewClassesloading=>_oldOrNewClassesloading;

  List <GroupVideo>  _oldClasses=[];
  List<GroupVideo> get  allOldClasses=>_oldClasses;

  List <GroupVideo>  _newClasses=[];
  List<GroupVideo> get  allNewClasses=>_newClasses;



  Future  fetchgroups(int ? subject_id , String  ? TeacherName)  async{

    Map<String,dynamic> data={'subjectId' : subject_id.toString()};

    _groupLoading=true;
    notifyListeners();
    try {
      var response = await CallApi().getWithBody(data, "/api/Group/GetGroups",1);

      //  print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _groups=body.map((e) =>Group.fromJson(e)).toList();
        // print("sub  "+_subjects[0].Name);
      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _groupLoading=false;
      notifyListeners();
    }
    catch(e){
      _groupLoading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }

  Future fetchTeacherGroup (int teacherId ,int? subjectId) async{
    _loading=true;
    Map <String,dynamic> data ={
      'teacherId':teacherId.toString(),
      'subjectId':subjectId.toString()
    };
    print(data.toString());
    notifyListeners();
    try {
      var response = await CallApi().getWithBody(data, "/api/Group/GetTeacherGroups", 1);

      var body = json.decode(response.body);
       print(body.toString());
      if (response != null && response.statusCode == 200) {

        List teacher=body[0]['TeacherGroups'];

         _TeacherName=body[0]['TeacherName'];
        _GradeName=body[0]['GradeName'];
        _SubjectName=body[0]['SubjectName'];
        _teacherGroupslist=teacher.map((e) => TeacherGroups.fromJson(e)).toList();


      }
      else {
        ShowMyDialog.showMsg(body['Message'].toString());
      }
      _loading=false;
      notifyListeners();
    }
    catch(e){
      _loading=false;
      notifyListeners();
      print('eeee '+e.toString());
    }

  }

  Future fetchGroupVideoClasses (int groupId ) async{
    _oldOrNewClassesloading=true;
    Map <String,dynamic> data ={
      'groupId':groupId.toString(),
    };
    print(data.toString());
    notifyListeners();
    try {
      var response = await CallApi().getWithBody(data, "/api/GroupVideo/GetStudentGroupSessions", 1);

      var body = json.decode(response.body);
       print(body.toString());
      if (response != null && response.statusCode == 200) {

        // List classes=body;
        List<GroupVideo> classes=body.map((e) => GroupVideo.fromJson(e)).toList();

        for(var i in classes){
          final dateToCheck = DateTime.parse(i.ClassAt);
          final date = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
          if(date.isBefore(DateTime.now())){
            _oldClasses.add(i);
          }else{
            _newClasses.add(i);
          }
        }

      }
      else {
        ShowMyDialog.showMsg(body['Message'].toString());
      }
      _oldOrNewClassesloading=false;
      notifyListeners();
    }
    catch(e){
      _oldOrNewClassesloading=false;
      notifyListeners();
      print('eeee '+e.toString());
    }

  }

  Future subscribeGroup (int groupId,context,index) async{
    _subscribeloading=true;
    notifyListeners();
    try {
      var response = await CallApi().postData(null, "/api/Group/SubscribeGroup?groupId="+groupId.toString(), 1);

      var body = json.decode(response.body);
      print(body.toString());
      if (response != null && response.statusCode == 200) {
         _teacherGroupslist[index].IsSubscribed=true;
         notifyListeners();
        ShowMyDialog.showMsg('تم الاشتراك في المجموعة بنجاح');

      }
      else {
        ShowMyDialog.showMsg(body['Message'].toString());
      }
      _subscribeloading=false;
      notifyListeners();
    }
    catch(e){
      _subscribeloading=false;
      notifyListeners();
      print('eeee '+e.toString());
    }

  }


  Future fetchGroupDetails (int groupId  ) async
  {
    _GroupDetailsloading=true;
    Map <String,dynamic> data ={
      'groupId':groupId.toString(),
    };
    notifyListeners();
    try {
      var response = await CallApi().getWithBody(data, "/api/Group/GetGroupDetails", 1);

      var body = json.decode(response.body);

      if (response != null && response.statusCode == 200) {
        _groupDetailsTeacherName=body['TeacherName'];
        _gradeName=body['GradeName'];
        _GroupDetailsloadingSubjectName=body['SubjectName'];
        _Price=body['Price'];
        _StartDate=body['StartDate'];
        _SessionsCount=body['SessionsCount'];
        _Days=body['Days'];
        _groupPeriod=body['GroupPeriod'];
        _groupDescription=body['Description']==null?'':body['Description'];
        _groupDetailsIntroVideoURL=UserSession.getURL()+body['IntroVideoURL'];
        notifyListeners();
        print('Video     '+_groupDetailsIntroVideoURL.toString());

        List videos=body['GroupVideos'];

        _groupDetailsGroupVideo=videos.map((e) => GroupVideo.fromJson(e)).toList();
      }
      else {
        ShowMyDialog.showMsg(body['Message'].toString());
      }
      _GroupDetailsloading=false;
      notifyListeners();
    }
    catch(e){
      _GroupDetailsloading=false;
      notifyListeners();
      print('eeee '+e.toString());
    }

  }




}