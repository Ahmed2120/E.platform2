

import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../session/userSession.dart';
import '../../widgets/dialogs/alertMsg.dart';

mixin AddGroupVideoCommentModel on Model{

  bool _Loading=false;
  bool get AddGroupCommentLoading =>_Loading;

  Future addGroupVideoComment (int GroupVideoId,String Comment) async{
    _Loading=true;
    notifyListeners();
   Map  data ={
      'GroupVideoId':GroupVideoId,
        'Comment':Comment
    };
    try {
      var response = await CallApi().
      postData(data,
          "/api/GroupVideo/AddGroupVideoComment", 1);
      //   print(json.decode(response.body));
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {

        if(body['Succeeded']==true){

        }
      }
      else {
        ShowMyDialog.showMsg(body['Message']);
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

  Future addGroupVideoRate (int GroupVideoId ,int Rate) async{
    _Loading=true;
    Map session=await UserSession.GetData();
    notifyListeners();

    Map  data ={
      'CourseVideoId':GroupVideoId,
      'Rate':Rate
    };
    try {
      var response = await CallApi().postData(data,
          "api/GroupVideo/AddGroupVideoRate", 1);
      //   print(json.decode(response.body));
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {

        if(body['Succeeded']==true){

        }
      }
      else {
        ShowMyDialog.showMsg(body['Message']);
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


}