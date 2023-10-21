
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';

import '../api/api.dart';
import '../core/utility/global_methods.dart';
import '../main.dart';
import '../pages/btm_bar_screen.dart';
import '../session/userSession.dart';
import '../widgets/dialogs/alertMsg.dart';

mixin UpdateProfileModel on Model{
  bool _update_loading = false;
  bool get  updateLoading => _update_loading;

  Future<bool> update (data) async{
    _update_loading=true;
    notifyListeners();

    try {
      var response = await CallApi().postData(data,"/api/Student/UpdateStudentProfile",1);

      var body = json.decode(response.body);
       //   print(body.toString());
      if (response != null && response.statusCode == 200) {

          return true;
        }
      else{
        throw body['Message'];
      }
    }
    catch(e){
      print('ee '+e.toString());
      _update_loading=false;
      notifyListeners();
      rethrow;
    }

  }

}