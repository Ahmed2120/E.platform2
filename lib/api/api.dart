import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import '../session/userSession.dart';
import '../widgets/dialogs/alertMsg.dart';

class CallApi{

  final String _url='http://educationteach-001-site1.etempurl.com';
    String msg='' ;

  postData(data,apiUrl ,x  ) async {
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

  postFile(File file,apiUrl ,x  ) async {
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

      var request = http.MultipartRequest('POST', Uri.parse(fullUrl));
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.headers.addAll(x==0 ?_setHeaders():_setTokenHeaders(token));

      return await request.send();

      // return await http.post(
      //     Uri.parse(fullUrl),
      //     body: (data),
      //     encoding: Encoding.getByName("utf-8"),
      //     headers:x==0 ?_setHeaders():_setTokenHeaders(token)
      // );


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

  postWithBody(data,apiUrl ,x  ) async {
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
      final uri = Uri.parse(_url+apiUrl);
      final newURI = uri.replace(queryParameters: data);

      return await http.post(
          newURI,
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

  postJsonAndFile(Map<String, String>data, List<Map> files,apiUrl ,x , {Map<String, String>? parameters}) async {
    try {
      msg='';
      // var fullUrl = _url + apiUrl;
      final uri = Uri.parse(_url+apiUrl);
      final newURI = uri.replace(queryParameters: parameters);
      String token='';

      try {
        Map session = await UserSession.GetData();
        token= session == null ? '' : session['access_token'];
      }catch(e){
        print("null error "+e.toString());
      }

      var request = http.MultipartRequest('POST', newURI);

      request.fields.addAll(data);

      for(int i = 0; i< files.length; i++){

        if(files[i] != null && files[i]['file'] !=null){
        //  String cleanPath = removeAllSpecialCharactersAndSpaces();
          request.files.add(await http.MultipartFile.fromPath(files[i]['title'],files[i]['file']!.path ));
        }
      }

      request.headers.addAll(x==0 ?_setHeaders():_setTokenHeaders(token));
      return await request.send();

      // return await http.post(
      //     Uri.parse(fullUrl),
      //     body: (data),
      //     encoding: Encoding.getByName("utf-8"),
      //     headers:x==0 ?_setHeaders():_setTokenHeaders(token)
      // );


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

  putJsonAndFile(Map<String, String>data, List<Map> files,apiUrl ,x ) async {
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

      var request = http.MultipartRequest('PUT', Uri.parse(fullUrl));

      request.fields.addAll(data);

      for(int i = 0; i< files.length; i++){
        if(files[i] != null && files[i]['file'] !=null){
          request.files
              .add(await http.MultipartFile.fromPath(files[i]['title'], files[i]['file']!.path));
        }
      }

      request.headers.addAll(x==0 ?_setHeaders():_setTokenHeaders(token));
      return await request.send();

      // return await http.post(
      //     Uri.parse(fullUrl),
      //     body: (data),
      //     encoding: Encoding.getByName("utf-8"),
      //     headers:x==0 ?_setHeaders():_setTokenHeaders(token)
      // );


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

  getData(apiUrl,x) async {

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
      return await http.get(
          Uri.parse(fullUrl),
          headers:x==0 ?_setHeaders():_setTokenHeaders(token)
      );
    }
    on IOException catch(e) {

      print('Socket Error: $e');
      //msg='Socket Error: $e';
      msg='No Internet Connection!';

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
      //   ShowMyDialog.showSnack(context,msg);
      print (msg);
    }
  }

  getWithBody(data,apiUrl  ,x) async {
    msg='';
    try {

      String token='';
      try {
        Map session = await UserSession.GetData();
        token= session == null ? '' : session['access_token'];
      }catch(e){
        print("null error "+e.toString());
      }
      final uri = Uri.parse(_url+apiUrl);
      final newURI = uri.replace(queryParameters: data);
      //  print (newURI);
      return await http.get(
          newURI,
          headers: x==0 ?_setHeaders():_setTokenHeaders(token)
      );
    }on IOException catch(e) {
      msg='No Internet Connection!';
      print('Socket Error: $msg');
    }
    on Error catch (e) {
      msg='General Error: $e';
      print('General Error: $e');
    }
    on TimeoutException catch (e) {
      msg='Timeout Error: $e';
      print('Timeout Error: $e');
    }
    on FormatException catch(e){
      msg='No Response !';
      print('Timeout Error: $e');
    }
    if(msg !=''){
      ShowMyDialog.showMsg(msg);
      //   ShowMyDialog.showSnack(context,msg);
      print (msg);
    }

  }

  delete(data,apiUrl ,x  ) async {
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

      return await http.delete(
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

  postDataANDFile(data,File? file,apiUrl ,x  ) async {
    try {
      msg='';
      var fullUrl = _url + apiUrl;

        Map session = await UserSession.GetData();
        String token= session['access_token'];

      var request = http.MultipartRequest('POST', Uri.parse(fullUrl));

      request.fields.addAll(data);
      if(file != null) {
        request.files
            .add(await http.MultipartFile.fromPath('Intro', file.path));
      }
      request.headers.addAll(_fileHeader(token));
      return await request.send();

      // return await http.post(
      //     Uri.parse(fullUrl),
      //     body: (data),
      //     encoding: Encoding.getByName("utf-8"),
      //     headers:x==0 ?_setHeaders():_setTokenHeaders(token)
      // );


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

  postDataANDFile1(data,File? file,apiUrl ,x  ) async {
    try {
      msg='';
      var fullUrl = _url + apiUrl;

      Map session = await UserSession.GetData();
      String token= session['access_token'];

      var request = http.MultipartRequest('POST', Uri.parse(fullUrl));

      request.fields.addAll(data);
      if(file != null) {
        request.files
            .add(await http.MultipartFile.fromPath('IntroVideo', file.path));
      }
      request.headers.addAll(_fileHeader(token));
      return await request.send();

      // return await http.post(
      //     Uri.parse(fullUrl),
      //     body: (data),
      //     encoding: Encoding.getByName("utf-8"),
      //     headers:x==0 ?_setHeaders():_setTokenHeaders(token)
      // );


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

  postDataANDFile2(data,File? file,apiUrl ,x  ) async {
    try {
      msg='';
      var fullUrl = _url + apiUrl;

      Map session = await UserSession.GetData();
      String token= session['access_token'];

      var request = http.MultipartRequest('POST', Uri.parse(fullUrl));

      request.fields.addAll(data);
      if(file != null) {
        request.files
            .add(await http.MultipartFile.fromPath('Attachments', file.path));
      }
      request.headers.addAll(_fileHeader(token));
      return await request.send();


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



  postJsonAndFileCourseLesson(Map<String, String>data, List<String>videoFile,List<String>AttachmentUrl,apiUrl ,x ) async {
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

      var request = http.MultipartRequest('POST', Uri.parse(fullUrl));

        request.fields.addAll(data);

      for (String filePath in videoFile){

        request.files
            .add(await http.MultipartFile.fromPath('Video', filePath));
      }

      for (String filePath in AttachmentUrl) {
              File file = File(filePath);
              var fileStream = http.ByteStream(file.openRead());
              var fileLength = await file.length();

              var multipartFile = http.MultipartFile(
                  'Attachments', fileStream, fileLength,
                  filename: path.basename(file.path));
            //  request.files.add(multipartFile);
              request.files.add(await http.MultipartFile.fromPath('Attachments',filePath));
            }
      request.headers.addAll(x==0 ?_setHeaders():_setTokenHeaders(token));
      return await request.send();

      // return await http.post(
      //     Uri.parse(fullUrl),
      //     body: (data),
      //     encoding: Encoding.getByName("utf-8"),
      //     headers:x==0 ?_setHeaders():_setTokenHeaders(token)
      // );


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

  puttJsonAndFileCourseLesson(Map<String, String>data,  List<String>videoFile,List<String>AttachmentUrl,apiUrl ,x ) async {
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

      var request = http.MultipartRequest('PUT', Uri.parse(fullUrl));

        request.fields.addAll(data);

      for (String filePath in videoFile){

        request.files
            .add(await http.MultipartFile.fromPath('Video', filePath));
      }

            for (String filePath in AttachmentUrl) {
              File file = File(filePath);
              var fileStream = http.ByteStream(file.openRead());
              var fileLength = await file.length();

              var multipartFile = http.MultipartFile(
                  'Attachments', fileStream, fileLength,
                  filename: path.basename(file.path));
            //  request.files.add(multipartFile);
              request.files.add(await http.MultipartFile.fromPath('Attachments',filePath));
            }
      request.headers.addAll(x==0 ?_setHeaders():_setTokenHeaders(token));
      return await request.send();

      // return await http.post(
      //     Uri.parse(fullUrl),
      //     body: (data),
      //     encoding: Encoding.getByName("utf-8"),
      //     headers:x==0 ?_setHeaders():_setTokenHeaders(token)
      // );


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
        'Content-type': 'application/x-www-form-urlencoded',
         'Accept': 'application/json',
      };

  _setTokenHeaders(Token) =>
      {
        'Accept': 'application/json',
        'Content-type': 'application/x-www-form-urlencoded',
        HttpHeaders.authorizationHeader: "Bearer $Token"
      };

  _fileHeader(Token) {
    return {
     // "Accept": "application/json",
      "Authorization": 'Bearer ${Token}',
    };
  }


}