
import 'dart:convert';

import 'package:eplatform/api/api.dart';
import 'package:eplatform/model/teacherModels/teacher_examDetails.dart';
import 'package:eplatform/widgets/dialogs/alertMsg.dart';
import 'package:scoped_model/scoped_model.dart';

import 'teacherExam.dart';

mixin TeacherExamDetailsModel on Model{

  //--------------ExamDetails---------------------
  bool _examDetails_loading=false;
  bool  get examDetailsLoading=>_examDetails_loading;

  TeacherExamDetails? _teacherExamDetails;
  TeacherExamDetails  get teacherExamDetails =>_teacherExamDetails!;


  void fetchExamById({
    required int examId,
  })  async{
    _examDetails_loading=true;
    notifyListeners();

    Map<String,dynamic> data={
      'examId':examId.toString()
    };
    try {
      var response = await CallApi().getWithBody(data, "/api/Exam/GetExamById", 1);
      print('----------------------');
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        final body = json.decode(response.body);
        _teacherExamDetails= TeacherExamDetails.fromJson(body);

        _examDetails_loading=false;
        notifyListeners();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }

      _examDetails_loading=false;
      notifyListeners();
    }
    catch(e){

      _examDetails_loading=false;
      notifyListeners();
      print(' sub  ee '+e.toString());
    }
  }

}