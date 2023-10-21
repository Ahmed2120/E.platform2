
  import 'dart:convert';

import 'package:eplatform/model/privateGroup/PrivateGroup.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../widgets/dialogs/alertMsg.dart';

mixin PrivateGroupModel on Model{

  //////////////////////////Privategroup
  bool _Loading=false;
  bool get privateGroupLoading=>_Loading;

  List<PrivateGroup> _PrivateGroupList=[];
  List<PrivateGroup> get PrivateGroupList => _PrivateGroupList;


  /////////////////TeacherPrivateGroups

  bool _teacherLoading1=false;
  bool get teacherPrivateGroupLoading=>_teacherLoading1;

  List<PrivateGroup> _TeacherPrivateGroupList=[];
  List<PrivateGroup> get TeacherPrivateGroupList => _TeacherPrivateGroupList;

  Future fetchPrivateGroup (int ? subjectId,String ? teacherName) async{
    _Loading=true;
    notifyListeners();

    Map <String,dynamic> data ={
      'subjectId':subjectId.toString(),
      'teacherName':teacherName,
    };
    try {
      var response = await CallApi().getWithBody(data, "/api/Group/GetPrivateGroups", 1);
      //   print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _PrivateGroupList=body.map((e) => PrivateGroup.fromJson(e)).toList();

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


  Future   FetchTeachersPrivateGroup (int teacherId) async{
    _teacherLoading1=true;
    notifyListeners();
     Map <String,dynamic> data ={
      'teacherId':teacherId.toString(),
    };
    try {
      var response = await CallApi().getWithBody(data, "/api/Group/GetTeachersPrivateGroups", 1);

      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _TeacherPrivateGroupList=body.map((e) => PrivateGroup.fromJson(e)).toList();
        print("Teacher  "+_TeacherPrivateGroupList[0].TeacherName);

      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);

      }

      _teacherLoading1=false;
      print("finish");
      notifyListeners();
    }
    catch(e){
      _teacherLoading1=false;
      notifyListeners();
      print('ee '+e.toString());
    }

  }





}