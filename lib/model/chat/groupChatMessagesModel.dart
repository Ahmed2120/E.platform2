
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'chatGroupMessages.dart';


mixin GroupChatMessagesModel on Model{

  //---------- online teachers -----------------
  bool _loading=false;
  bool get  groupeChatMessageLoading =>_loading;

  List <ChatGroupMessage> _list=[];
  List <ChatGroupMessage>  get  groupChatMessageList =>_list;


  //----------------send msg--------------------------
  bool _msg_loading=false;
  bool get SendGroupMsgLoading =>_msg_loading;


  bool _moreLoading=false;
  bool get moreGroupChatMessageLoading =>_moreLoading;

  List <ChatGroupMessage> _all_list=[];
  List <ChatGroupMessage>  get AllGroupChatMessageList =>_all_list;

  Future fetchgroupChatMessages (int chatGroupId,int pageIndex,int pageSize) async{

    if(pageIndex==0){
      _loading=true;
      _all_list=[];
    }

    if(pageIndex >0){
      _moreLoading=true;
      notifyListeners();
    }

   //  print('page '+pageIndex.toString());

    Map <String,dynamic> data={
      'chatGroupId':chatGroupId.toString(),
      'pageIndex':pageIndex.toString(),
      'pageSize':pageSize.toString()
    };
        notifyListeners();
    try {
      var response = await CallApi().getWithBody(data,"/api/Chat/GetChatGroupMessages", 1);
      //  print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _list=body.map((e) => ChatGroupMessage.fromJson(e)).toList();

        if(pageIndex==0) {
          _all_list=_list;
          _loading=false;
          notifyListeners();
        }
        else {
          _all_list.addAll(_list.toList());
          notifyListeners();
        }
        if(_list.length < pageSize){
          _moreLoading=false;
          notifyListeners();
        }
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _loading=false;
      _moreLoading=false;
      notifyListeners();
    }
    catch(e){
      _loading=false;
      _moreLoading=false;
      notifyListeners();
      print('ee '+e.toString());
    }

  }

  Future sendGroupSingleChatMessages (int  ChatGroupId,String Text, controller) async{

    _msg_loading=true;
    Map <String,dynamic> data={
      'ChatGroupId':ChatGroupId.toString(),
      'Text':Text.toString(),
    };
    notifyListeners();

    try {
      var response = await CallApi().postData(data,"/api/Chat/SendChatGroupMessage", 1);
  //    print(json.decode(response.body));
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {

        fetchgroupChatMessages(ChatGroupId,0,10);
        if(body['Success']==true) {
          controller.text='';
          notifyListeners();

        }
      }
      else {
        ShowMyDialog.showMsg(body['Message']);
      }
      _msg_loading=false;
      notifyListeners();
    }
    catch(e){
      _msg_loading=false;
      notifyListeners();
      print('ee '+e.toString());
    }

  }



}