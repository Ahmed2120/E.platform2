
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../session/userSession.dart';
import '../widgets/dialogs/alertMsg.dart';
class TeacherCall{
  final String _url='http://educationteach-001-site1.etempurl.com';
  String msg='' ;
  postData(data,apiUrl,int x) async {

    try {
      msg='';
      var fullUrl = _url + apiUrl;
      String token='';

      try {
        Map session = await UserSession.GetData();
        token= session == null ? '' : session['access_token'];
      }catch(e){
        print("null error "+e.toString());
      }

      return await http.post(
          Uri.parse(fullUrl),
          body: (data),
          encoding: Encoding.getByName("utf-8"),
          headers:x==0 ?_setHeaders():_setTokenHeaders(token)
      );


    }on IOException catch(e) {
      msg='No Internet Connection!';
      print('Socket Error: $e');
      //  msg='Socket Error: $e';

    }
    on Error catch (e) {

      print('General Error: $e');
      msg='General Error: $e';
    }
    on TimeoutException catch (e) {

      print('Timeout Error: $e');
      msg='Timeout Error: $e';
    }
    on FormatException catch(e){

      print('Timeout Error: $e');
      msg='Timeout Error: $e';
    }

    if(msg !=''){
      ShowMyDialog.showMsg(msg);

    }

  }

  putData(data,apiUrl,int x) async {

    try {
      msg='';
      var fullUrl = _url + apiUrl;
      String token='';

      try {
        Map session = await UserSession.GetData();
        token= session == null ? '' : session['access_token'];
      }catch(e){
        print("null error "+e.toString());
      }

      return await http.put(
          Uri.parse(fullUrl),
          headers:x==0 ?_setHeaders():_setTokenHeaders(token),
          body: (data),
          encoding: Encoding.getByName("utf-8"),

      );


    }on IOException catch(e) {
      msg='No Internet Connection!';
      print('Socket Error: $e');
      //  msg='Socket Error: $e';

    }
    on Error catch (e) {

      print('General Error: $e');
      msg='General Error: $e';
    }
    on TimeoutException catch (e) {

      print('Timeout Error: $e');
      msg='Timeout Error: $e';
    }
    on FormatException catch(e){

      print('Timeout Error: $e');
      msg='Timeout Error: $e';
    }

    if(msg !=''){
      ShowMyDialog.showMsg(msg);

    }

  }


  _setHeaders() =>
      {
           'Content-type': 'application/json',
      };

  _setTokenHeaders(Token) =>
      {
        'Content-type': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $Token"
      };

}