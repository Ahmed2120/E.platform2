import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import '../../api/api.dart';
import '../../widgets/dialogs/alertMsg.dart';
import '../teacherModels/teacher_examDetails.dart';
import 'exam_question.dart';
import 'notPassedExam.dart';
import 'passedExam.dart';

mixin ExamModel on Model{

  bool _loading=false;
  bool get  ExamLoading=>_loading;

  List <PassedExam> _passedExamList=[];
  List <PassedExam> get  allPassedExam=>_passedExamList;
  List <NotPassedExam> _notpassedExamList=[];
  List <NotPassedExam> get  allNotPassedExam=>_notpassedExamList;

  bool _examQuestionLoading=false;
  bool get  examQuestionLoading=>_examQuestionLoading;
  StudentExamQuestion? _examQuestion;
  StudentExamQuestion? get examQuestion => _examQuestion;

  Future fetchExams(int ? subjectId ) async{
    _loading=true;
    notifyListeners();

    Map <String , dynamic>data ={
      "subjectId":subjectId.toString(),
    };

    try {
      var response = await CallApi().getWithBody(data, "/api/Exam/GetExams", 1);
        print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
        print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        var body = json.decode(response.body);
        List passed=body['PassedExams'];
        List not=body['NotPassedExam'];
        _passedExamList=passed.map((e) => PassedExam.fromJson(e)).toList();
        _notpassedExamList=not.map((e) => NotPassedExam.fromJson(e)).toList();
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

  Future fetchStudentExamById(int ? examId ) async{
    _examQuestionLoading=true;
    notifyListeners();

    Map <String , dynamic>data ={
      "examId":examId.toString(),
    };

    try {
      var response = await CallApi().getWithBody(data, "/api/Exam/GetExamById", 1);
        print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
        print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        var body = json.decode(response.body);
        _examQuestion= StudentExamQuestion.fromJson(body);
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _examQuestionLoading=false;
      notifyListeners();
    }
    catch(e){
      _examQuestionLoading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }




}