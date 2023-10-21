
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';

import '../api/api.dart';
import '../core/utility/global_methods.dart';
import '../main.dart';
import '../pages/btm_bar_screen.dart';
import '../parent/rootParentpag.dart';
import '../session/userSession.dart';
import '../teacher/pages/teacher_btm_bar_page.dart';
import '../widgets/dialogs/alertMsg.dart';

mixin LoginModel on Model{
  bool _login_loading = false;
  bool get  loginLoading => _login_loading;

  bool _hidePassword = true;
  bool get  hidePassword => _hidePassword;



  Future login (data) async{
    _login_loading=true;
    notifyListeners();

    try {
      var response = await CallApi().postData(data,"/Token",0);

      var body = json.decode(response.body);
       //   print(body.toString());
      if (response != null && response.statusCode == 200) {

        UserSession.CreateSession (
            body['access_token'],
            body['token_type'],
            body['expires_in'],
            body['phoneNumber'],
            body['userId'],
            body['name'],
            body['profilePicture'],
            body["userRole"],
            body['.issued'],
            body['.expires'],
            body['wallet'],
            body['priviliges'],
        );

        Map session=await UserSession.GetData();
        final userRole = session["userRole"];

        if(session['access_token'] !=null  &&  session['userId'] !=null ){
          if(userRole == "1") {
            GlobalMethods.navigateReplaceALL(
                navigatorKey.currentContext!, const BottomBarScreen());
          }
          if(userRole == "2" || userRole == "6") {
            GlobalMethods.navigateReplaceALL(
                navigatorKey.currentContext!, const TeacherBottomBarScreen());
          }
          if(userRole == "3") {
            GlobalMethods.navigateReplaceALL(
                navigatorKey.currentContext!, const BottomBarParentsScreen());
          }
        }

      }
      else{
        ShowMyDialog.showMsg(body['error_description']);
      }
    }
    catch(e){
      print('ee '+e.toString());
    }
    _login_loading=false;
    notifyListeners();

  }

  void togglePass(){
    _hidePassword = !_hidePassword;
    notifyListeners();
  }

}