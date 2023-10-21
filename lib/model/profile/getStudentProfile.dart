
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../session/userSession.dart';
import '../../widgets/dialogs/alertMsg.dart';

mixin GetStudentProfile on Model{

  bool _loading=false;
  bool get studentProfileLoading =>_loading;

  Future fetchStudentProfile ()async{
    _loading=true;
    Map session=await UserSession.GetData();
    notifyListeners();

      Map data={'userId':session['userId']};

    try {
      var response = await CallApi().getWithBody(data ,
          "/api/Student/GetStudentProfile", 1);
      //   print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);

      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }

    }
    catch(e){

      print('ee '+e.toString());
    }
    _loading=false;
    notifyListeners();
  }

}