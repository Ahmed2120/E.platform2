
import 'dart:convert';

import 'package:eplatform/model/chat/teachersToChat.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'chatGroups.dart';

mixin TeachersToChatModel on Model{

  //////// online teachers ///////////
  bool _loading=false;
  bool get TeachersToChatLoading =>_loading;

  List <TeachersToChat> _list=[];
  List <TeachersToChat>  get TeachersToChatList =>_list;

  ///////////////// online groups//////////
  bool _group_loading=false;
  bool get GroupChatLoading =>_group_loading;

  List <ChatGroup> _group_list=[];
  List <ChatGroup>  get ChatGroupsList =>_group_list;


  Future fetchTeachersToChat () async{
    _loading=true;
    notifyListeners();

    try {
      var response = await CallApi().getData("/api/Chat/GetTeachersToChat", 1);
        print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
      _list=body.map((e) => TeachersToChat.fromJson(e)).toList();
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

  Future fetchGetChatGroups () async{
    _group_loading=true;
    notifyListeners();

    try {
      var response = await CallApi().getData("/api/Chat/GetChatGroups", 1);
         print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _group_list=body.map((e) => ChatGroup.fromJson(e)).toList();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _group_loading=false;
      notifyListeners();
    }
    catch(e){
      _group_loading=false;
      notifyListeners();
      print('ee '+e.toString());
    }

  }




}