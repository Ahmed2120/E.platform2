

import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'singleChatMessage.dart';

mixin SingleChatMessagesModel on Model{

  //////// online teachers ///////////
  bool _loading=false;
  bool get SingleChatMessageLoading =>_loading;

  List <SingleChatMessage> _list=[];
  List <SingleChatMessage>  get SingleChatMessageList =>_list;

  List <SingleChatMessage> _all_list=[];
  List <SingleChatMessage>  get AllSingleChatMessageList =>_all_list;

  bool _moreLoading=false;
  bool get moreSingleChatMessageLoading =>_moreLoading;

  //////////////////send msg///////////////////////////
  bool _msg_loading=false;
  bool get MsgLoading =>_msg_loading;


  Future fetchSingleChatMessages (String teacherUserId,int pageIndex,int pageSize ) async{

    if(pageIndex==0){
    _loading=true;
    _all_list=[];
    }

    if(pageIndex >0){
      _moreLoading=true;
      notifyListeners();
    }
    Map <String,dynamic> data={
      'teacherUserId':teacherUserId,
      'pageIndex':pageIndex.toString(),
      'pageSize':pageSize.toString()
    };
    notifyListeners();


    try {
      var response = await CallApi().getWithBody(data,"/api/Chat/GetSingleChatMessages", 1);

      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _list=body.map((e) => SingleChatMessage.fromJson(e)).toList();

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

  Future seenSingleChatMessage (String teacherUserId) async{

    Map <String,dynamic> data={
      'teacherUserId':teacherUserId,
    };
    notifyListeners();


    try {
      var response = await CallApi().postWithBody(data,"/api/Chat/SeenSingleChatMessage", 1);

      if (response != null && response.statusCode == 200) {
        return true;

      }
    }
    catch(e){
      print('ee '+e.toString());
    }

  }

  Future seenChatGroupMessage (int chatGroupId) async{

    Map <String,dynamic> data={
      'ChatGroupId':chatGroupId.toString(),
    };
    notifyListeners();


    try {
      var response = await CallApi().postWithBody(data,"/api/Chat/SeenChatGroupMessage", 1);

      if (response != null && response.statusCode == 200) {
        return true;

      }
    }
    catch(e){
      print('ee '+e.toString());
    }

  }

  Future sendSingleChatMessages (String SentToId,String Text, controller) async{
    _msg_loading=true;
    Map <String,dynamic> data={
      'SentToId':SentToId,
      'Text':Text.toString(),
    };
    notifyListeners();
    try {
      var response = await CallApi().postData(data,"/api/Chat/SendSingleChatMessage", 1);
    //  print(json.decode(response.body));
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        fetchSingleChatMessages(SentToId,0,10,);
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