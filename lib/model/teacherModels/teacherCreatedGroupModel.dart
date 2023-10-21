import 'dart:convert';

import 'package:eplatform/api/api.dart';
import 'package:eplatform/widgets/dialogs/alertMsg.dart';
import 'package:scoped_model/scoped_model.dart';

import 'teacherCreatedGroup.dart';

mixin TeacherCreatedGroupModel on Model{

  bool _Loading=false;
  bool get  showAllTeacherCreatedGroupLoading=>_Loading;

  List<TeacherCreatedGroup>_list=[];
  List<TeacherCreatedGroup> get allTeacherCreatedGroups=>_list;

  //---------- delete--------------
  bool _deleteLoading=false;
  bool get  deleteTeacherCreatedGroupLoading=>_deleteLoading;

   fetchAllTeacherCreatedGroup(int ? subjectId ,int ? educationTypeId,int ? gradeId ) async{

     _Loading=true;
     notifyListeners();

     Map<String,dynamic> data={
       'subjectId':subjectId.toString(),
       'educationTypeId':educationTypeId.toString(),
       'gradeId':gradeId.toString()
     };

     try {
       var response = await CallApi().getWithBody(data,"/api/Group/ShowTeacherAllGroups", 1);
      //  print ("groups "+response.body);
       if (response != null && response.statusCode == 200) {
         List body = json.decode(response.body);
         _list = body.map((e) => TeacherCreatedGroup.fromJson(e)).toList();
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

  deleteTeacherCreatedGroup(int ? groupId ,int index ) async{
    _deleteLoading=true;
    notifyListeners();

    try {
      var response = await CallApi().delete(null,"/api/Group/DeleteGroup?groupId="+groupId.toString(), 1);
       print ("delete  "+response.body);

      var body = json.decode(response.body);

      if (response != null && response.statusCode == 200) {
        _list.removeAt(index);
        _deleteLoading=false;
        notifyListeners();

        ShowMyDialog.showMsg('تم حذف المجموعة بنجاح');

      }
      else{
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