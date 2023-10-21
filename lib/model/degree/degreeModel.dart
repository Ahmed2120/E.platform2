
import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import '../../api/api.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'Degree.dart';

mixin DegreeModel on Model{

  bool _loading=false;
  bool get StudentDegreeLoading=>_loading;

  List <Degree> _degreeList=[];
  List <Degree> get  allStudentDegreeList=>_degreeList;

  Future fetchDegrees(int ? subjectId ) async{
    _loading=true;
    notifyListeners();
     Map <String , dynamic>data ={
    "subjectId":subjectId.toString(),
  };

    try {
      var response = await CallApi().
      getWithBody(data, "/api/Student/GetStudentDegrees", 1);
        print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _degreeList=body.map((e) => Degree.fromJson(e)).toList();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _loading=false;
      notifyListeners();
    }
    catch(e){
      _loading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }




}