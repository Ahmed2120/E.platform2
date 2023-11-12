import 'dart:convert';

import 'package:eplatform/model/question/custom_question.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../api/api.dart';

import '../../api/teacherCall.dart';
import '../../widgets/dialogs/alertMsg.dart';
import '../teacher/teacher.dart';
import 'assistant.dart';
import 'assistantRequest.dart';
import 'teacherAssistant.dart';

mixin AssistantModel on Model{

  bool _assist_loading=false;
  bool get assistLoading=>_assist_loading;

  bool _add_loading=false;
  bool get addPriviligeLoading => _add_loading;

  bool _accept_loading=false;
  bool get acceptLoading => _accept_loading;

  bool _reject_loading=false;
  bool get rejectLoading => _reject_loading;

  bool _addRequest_loading=false;
  bool get addRequest_loading => _addRequest_loading;

  bool _assistTeacher_loading=false;
  bool get assistTeacher_loading => _assistTeacher_loading;

  List<Assistant>_assistantList=[];
  List<Assistant> get assistantList=>_assistantList;

  List<AssistantTeachers>_assistantTeachers=[];
  List<AssistantTeachers> get assistantTeachers=>_assistantTeachers;

  List<AssistantRequest>_assistantRequestList=[];
  List<AssistantRequest> get assistantRequestList=>_assistantRequestList;

  bool _assistRequest_loading=false;
  bool get assistRequest_loading=>_assistRequest_loading;


  void fetchAssistants()  async{
_assist_loading=true;
    notifyListeners();

    try {
      var response = await CallApi().getData("/api/TeacherAssistant/GetTeacherAssistants", 1);
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _assistantList= body.map((e) => Assistant.fromJson(e)).toList();

        _assist_loading=false;
        notifyListeners();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }

      _assist_loading=false;
      notifyListeners();
    }
    catch(e){

      _assist_loading=false;
      notifyListeners();
      print(' sub  ee '+e.toString());
    }
  }

  void fetchAssistantTeachers()  async{
    _assistTeacher_loading=true;
    notifyListeners();

    // try {
      var response = await CallApi().getData("/api/Teacher/GetAssistantTeachers", 1);
      print('----------------------------');
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _assistantTeachers= body.map((e) => AssistantTeachers.fromJson(e)).toList();

        _assistTeacher_loading=false;
        notifyListeners();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }

      _assistTeacher_loading=false;
      notifyListeners();
    // }
    // catch(e){
    //
    //   _assist_loading=false;
    //   notifyListeners();
    //   print(' sub  ee '+e.toString());
    // }
  }

  void fetchAssistantRequests()  async{
    _assistRequest_loading=true;
    notifyListeners();

    try {
      var response = await CallApi().getData("/api/AssistantRequest/GetAssistantRequest", 1);
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        print('GetAllAssistantRequest------------');
        print(body);
        _assistantRequestList= body.map((e) => AssistantRequest.fromJson(e)).toList();

        _assistRequest_loading=false;
        notifyListeners();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }

      _assistRequest_loading=false;
      notifyListeners();
    }
    catch(e){

      _assistRequest_loading=false;
      notifyListeners();
      print(' sub  ee '+e.toString());
    }
  }

  // void fetchAssistantRequestsDetails(int assistantId)  async{
  //   _assistRequest_loading=true;
  //   notifyListeners();
  //
  //   try {
  //     final data = {
  //       "assistantId": assistantId.toString()
  //     };
  //     var response = await CallApi().getWithBody(data, "api/TeacherAssistant/GetAssistantRequestDetails", 1);
  //     print(json.decode(response.body));
  //     if (response != null && response.statusCode == 200) {
  //       List body = json.decode(response.body);
  //       _assistantRequestList= body.map((e) => Assistant.fromJson(e)).toList();
  //
  //       _assistRequest_loading=false;
  //       notifyListeners();
  //     }
  //     else {
  //       ShowMyDialog.showMsg(json.decode(response.body)['Message']);
  //     }
  //
  //     _assistRequest_loading=false;
  //     notifyListeners();
  //   }
  //   catch(e){
  //
  //     _assistRequest_loading=false;
  //     notifyListeners();
  //     print(' sub  ee '+e.toString());
  //   }
  // }

  void addTeacherAssistantPrivilige({required int assistantId, required List priviliges, })  async{

      _add_loading=true;
notifyListeners();

    Map<String, String> data={
      "AssistantId": assistantId.toString(),
      "Priviliges": jsonEncode(priviliges)
    };
    //  print(' lesson data   '+data.toString());

    try {
      var response =await CallApi().postDataANDFile(data,null,  "/api/TeacherAssistant/AddTeacherAssistantPrivilige", 1);

      if (response != null && response.statusCode == 200) {
        ShowMyDialog.showMsg("تم إضافة المساعد بنجاح");
      }
      else {
        ShowMyDialog.showMsg(response.reasonPhrase);
      }

      _add_loading=false;
      notifyListeners();
    }
    catch(e){
      _add_loading=false;
      notifyListeners();
      ShowMyDialog.showMsg(e.toString());
      print(' add '+e.toString());
    }
  }

  void acceptAssistantRequest({required int assistantId})  async{

    _accept_loading=true;
notifyListeners();

    Map<String, String> data={
      "assistantId": assistantId.toString(),
    };
    //  print(' lesson data   '+data.toString());

    try {
      var response =await CallApi().postWithBody(data, "/api/AssistantRequest/AcceptAssistantRequest", 1);

      print(response.body);
      if (response != null && response.statusCode == 200) {
        ShowMyDialog.showMsg("تم إضافة المساعد بنجاح");
      }
      else {
        ShowMyDialog.showMsg(response.reasonPhrase);
      }

      _accept_loading=false;
      notifyListeners();
    }
    catch(e){
      _accept_loading=false;
      notifyListeners();
      ShowMyDialog.showMsg(e.toString());
      print(' add '+e.toString());
    }
  }

  void rejectAssistantRequest({required int assistantId})  async{

    _reject_loading=true;
notifyListeners();

    Map<String, String> data={
      "assistantId": assistantId.toString(),
    };
     print(' lesson data   '+data.toString());

    try {
      var response =await CallApi().postWithBody(data,  "/api/AssistantRequest/RejectAssistantRequest", 1);

      if (response != null && response.statusCode == 200) {
        ShowMyDialog.showMsg("تم رفض الطلب");
      }
      else {
        ShowMyDialog.showMsg(response.reasonPhrase);
      }

      _reject_loading=false;
      notifyListeners();
    }
    catch(e){
      _reject_loading=false;
      notifyListeners();
      ShowMyDialog.showMsg(e.toString());
      print(' add '+e.toString());
    }
  }

  void addAssistantRequest({required int teacherId})  async{

    _addRequest_loading=true;
notifyListeners();

    Map<String, String> data={
      "teacherId": teacherId.toString(),
    };
    //  print(' lesson data   '+data.toString());

    try {
      var response =await CallApi().postWithBody(data,  "/api/AssistantRequest/AddAssistantRequest", 1);

      if (response != null && response.statusCode == 200) {
        ShowMyDialog.showMsg("تم ارسال الطلب");
      }
      else {
        ShowMyDialog.showMsg(response.reasonPhrase);
      }

      _addRequest_loading=false;
      notifyListeners();
    }
    catch(e){
      _addRequest_loading=false;
      notifyListeners();
      ShowMyDialog.showMsg(e.toString());
      print(' add '+e.toString());
    }
  }


}