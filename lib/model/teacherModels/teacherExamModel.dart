
import 'dart:convert';

import 'package:eplatform/api/api.dart';
import 'package:eplatform/widgets/dialogs/alertMsg.dart';
import 'package:scoped_model/scoped_model.dart';

import 'teacherExam.dart';

mixin TeacherExamModel on Model{

  //--------------Exam---------------------
  bool _loading=false;
  bool  get allTeacherExamLoading=>_loading;

  List <TeacherExam>_list=[];
  List  <TeacherExam>  get allTeacherExams =>_list;

  ///------------Delete Exam-----------
   bool _deleteLoading=false;

  Future fetchAllTeacherExams (int ? subjectId , int ?  educationTypeId, int ?  gradeId,int ? ProgramTypeId  ) async{
    _loading=true;

    notifyListeners();
    Map <String,dynamic>data={
      'subjectId':subjectId.toString(),
      'educationTypeId':educationTypeId.toString(),
      'gradeId':gradeId.toString(),
      'ProgramTypeId':ProgramTypeId.toString()

    };
    try {
      var response = await CallApi().getWithBody(data,"/api/Exam/ShowAllExams", 1);

     //  print ("EXams   "+response.body);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);

        _list=body.map((e) => TeacherExam.fromJson(e)).toList();

        notifyListeners();
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

  Future deleteTeacherCreatedExam(int ? examId ,int index ) async{
    _deleteLoading=true;
    notifyListeners();

    try {
      var response = await CallApi().delete(null,"/api/Exam/DeleteExam?examId="+examId.toString(), 1);
       print ("delete Exam  "+response.body);

      var body = json.decode(response.body);

      if (response != null && response.statusCode == 200) {
        _list.removeAt(index);

        _deleteLoading=false;
        notifyListeners();
        ShowMyDialog.showMsg('تم حذف الإختبار  بنجاح');

      }else{
        ShowMyDialog.showMsg(body['Message']);
      }

      _deleteLoading=false;
      notifyListeners();
    }
    catch(e){
      _deleteLoading=false;
      notifyListeners();
      print('ee '+e.toString());
    }




  }

}