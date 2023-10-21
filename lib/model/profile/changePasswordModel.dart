
import 'dart:convert';

import 'package:eplatform/pages/login_page/login_page.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../core/utility/global_methods.dart';
import '../../main.dart';
import '../../pages/btm_bar_screen.dart';
import '../../session/userSession.dart';
import '../../widgets/dialogs/alertMsg.dart';
mixin ChangePasswordModel on Model{
  bool _password_loading = false;
  bool _showPassword_loading = false;
  bool get  passwordLoading => _password_loading;
  bool get  showPasswordLoading => _showPassword_loading;

  Future changePassword (data) async{
    _password_loading=true;
    notifyListeners();
    try {
      var response = await CallApi().postData(data,"/api/Account/ResetPassword",0);
      var body = json.decode(response.body);
      print(body.toString());
      if (response != null && response.statusCode == 200) {

        if(body["Success"]){
          GlobalMethods.navigateReplaceALL(navigatorKey.currentContext!, LoginPage());
        }else{
          ShowMyDialog.showMsg(body['Message']);
        }
      }
      else{
        ShowMyDialog.showMsg(body['error_description']);
      }
    }
    catch(e){
      print('ee '+e.toString());
    }
    _password_loading=false;
    notifyListeners();

  }

  // toggleShowPassword(){
  //   _showPassword_loading = !_showPassword_loading;
  //   notifyListeners();
  // }

}