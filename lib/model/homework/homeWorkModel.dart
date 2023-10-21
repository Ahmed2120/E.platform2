
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'homeWork.dart';
import 'notDeliveredHomeWork.dart';

mixin HomeWorkModel on Model{

  bool  _loading=false;
  bool get  homeWorkLoading1=> _loading;

  List <HomeWork>_deliveredHomeworks=[];
  List <HomeWork> get allDeliveredHomeworks=>_deliveredHomeworks;

  List <NotDeliveredHomework>_notdeliveredHomeworks=[];
  List <NotDeliveredHomework> get allNotDeliveredHomeworks=>_notdeliveredHomeworks;

  Future fetchHomeWork(int subjectId) async{
     _loading=true;
     notifyListeners();
    Map<String,dynamic> data={'subjectId':subjectId.toString()};
    try {
      var response = await CallApi().getWithBody(data, "/api/Homework/GetHomeworks",1);
       //  print("body  "+json.decode(response.body).toString());
      if (response != null && response.statusCode == 200) {
        var body = json.decode(response.body);
        List d=body['DeliveredHomeworks'];
        List not=body['NotDeliveredHomeworks'];
        _deliveredHomeworks=d.map((e) => HomeWork.fromJson(e)).toList();
        _notdeliveredHomeworks=not.map((e) => NotDeliveredHomework.fromJson(e)).toList();
      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }

      _loading=false;
      notifyListeners();
    }
    catch(e){

      _loading=false;
      notifyListeners();
      print("homework  ee "+e.toString());
    }



  }

}