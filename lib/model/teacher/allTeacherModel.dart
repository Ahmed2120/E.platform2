import 'dart:convert';

import 'package:eplatform/model/teacher/teacher.dart';
import 'package:eplatform/session/userSession.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../widgets/dialogs/alertMsg.dart';

mixin AllTeacherModel on Model{

  //---------------------------------teachers---------
  bool _Loading = false;
  bool get  allTecherLoading => _Loading;

  List<Teachers> _teachers = [];
  List<Teachers> _mainTeachersList = [];
  List<Teachers> get allTeachers => _teachers;

  //----------------------teacher Details
  bool _d_Loading = false;
  bool get  allTecherDetailsLoading => _d_Loading;

  String _teacherDetailsName='';
  String get  teacherDetailsName =>_teacherDetailsName;

  String _teacherDetailsProfilePicture='';
  String get teacherDetailsProfilePicture=>_teacherDetailsProfilePicture;

  double _teacherDetailsRate=0.0;
  double get teacherDetailsRate=>_teacherDetailsRate;

  int _teacherDetailsFollowersCount=0;
  int get teacherDetailsFollowersCount =>_teacherDetailsFollowersCount;

  int _teacherDetailsReviewersCount=0;
  int get teacherDetailsReviewersCount=>_teacherDetailsReviewersCount;

  String _teacherDetailsSubjects='';
  String  get teacherDetailsSubjects =>_teacherDetailsSubjects;

  String _teacherDetailsGrades='';
  String get teacherDetailsGrades=>_teacherDetailsGrades;

  String _teacherDetailsEducationTypes='';
  String get teacherDetailsEducationTypes=>_teacherDetailsEducationTypes;

  int _teacherDetailsCoursesCount=0;
  int get teacherDetailsCoursesCount=>_teacherDetailsCoursesCount;

  int _teacherDetailsGroupsCount=0;
  int get teacherDetailsGroupsCount=>_teacherDetailsGroupsCount;

  double _teacherDetailsWorkingHours=0.0;
  double get teacherDetailsWorkingHours=>_teacherDetailsWorkingHours;

  int _teacherDetailsSubscribersCount=0;
  int get teacherDetailsSubscribersCount=>_teacherDetailsSubscribersCount;




  Future fetchAllTeachers (int ? subjectId,String ? teacherName) async{
    _Loading=true;
    notifyListeners();

    Map <String , dynamic>data ={
      "subjectId":subjectId.toString(),
      'teacherName':teacherName
    };
   print('data '+data.toString());
    try {
      var response = await CallApi().getWithBody(data, "/api/Teacher/GetTeachers", 1);
      //   print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _teachers = body.map((e) => Teachers.fromJson(e)).toList();
        _mainTeachersList = _teachers;
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

  Future fetchTeacherDetails (int teacherId) async{
    _d_Loading=true;
    notifyListeners();

    Map<String,dynamic> data={ 'teacherId':teacherId.toString() };
    try {
      var response = await CallApi().getWithBody(data, "/api/Teacher/GetTeacherDetails", 1);
      if (response != null && response.statusCode == 200) {
        var body = json.decode(response.body);
      //   print (body.toString());
        _teacherDetailsName=body['TeacherName'];
        _teacherDetailsProfilePicture=body['ProfileImage']==null?'':
                                      UserSession.getURL()+body['ProfileImage'];
         _teacherDetailsRate=body['Rate'];
         _teacherDetailsFollowersCount=body['FollowersCount'];
        _teacherDetailsReviewersCount=body['ReviewersCount'];
        _teacherDetailsSubjects=body['Subjects'];
        _teacherDetailsGrades=body['Grades'];
         _teacherDetailsEducationTypes=body['EducationTypes'];
         _teacherDetailsCoursesCount=body['CoursesCount'];
         _teacherDetailsGroupsCount=body['GroupsCount'];
        _teacherDetailsWorkingHours =body['WorkingHours'];
      _teacherDetailsSubscribersCount =body['SubscribersCount'];
      notifyListeners();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _d_Loading=false;
      notifyListeners();
    }
    catch(e){
      _d_Loading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }

  void searchTeachers(String txt){
    _teachers = [];
    if(txt.isEmpty){
      _teachers = _mainTeachersList;
    }else{
      for(var teacher in _mainTeachersList){
        if(teacher.Name.toLowerCase().contains(txt.toLowerCase()) || teacher.Subjects.toLowerCase().contains(txt.toLowerCase())){
          _teachers.add(teacher);
        }
      }
    }
    notifyListeners();
  }


}