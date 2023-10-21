
import 'dart:convert';
import 'package:eplatform/model/customModel.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../api/api.dart';
import '../../session/userSession.dart';
import '../../widgets/dialogs/alertMsg.dart';


mixin TeacherSubModel on Model{

  //---------------subject----------------
  bool _subLoading = false;
  bool get  teacherSubLoading => _subLoading;

  List<CustomModel> _subjects = [];
  List<CustomModel> get allTeacherSubjects => _subjects;


  Future fetchTeacherSub () async{
    _subLoading=true;
    Map session=await UserSession.GetData();
    notifyListeners();

    try {
      var response = await CallApi().getData("/api/Teacher/GetTeacherSubjects", 1);
        print('-------------------');
        print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _subjects = body.map((e) => CustomModel.fromJson(e)).toList();
        notifyListeners();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _subLoading=false;
      notifyListeners();
    }
    catch(e){
     _subLoading=false;
     notifyListeners();
     print('ee '+e.toString());
    }
  }









}