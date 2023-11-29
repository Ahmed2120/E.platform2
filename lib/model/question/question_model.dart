import 'dart:convert';

import 'package:eplatform/model/note/teacherNote.dart';
import 'package:eplatform/model/question/custom_question.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../api/api.dart';

import '../../widgets/dialogs/alertMsg.dart';

mixin QuestionModel on Model{

  // --------------------Note--------------------------------
  bool _quest_loading=false;
  bool get questionLoading=>_quest_loading;

  List<CustomQuestion>_questionList=[];
  List<CustomQuestion> get questionList=>_questionList;


  void fetchQuestions({
    required int subjectId,
    required int educationTypeId,
    required int educationProgramId,
    required int educationLevelId,
  })  async{
    _quest_loading=true;
    notifyListeners();

    Map<String,dynamic> data={
      "EducationTypeIds":[educationTypeId],
      "ProgramTypeIds":[educationProgramId],
      "GradeIds":[educationLevelId],
      "SubjectIds":[subjectId]
    };
    try {
      var response = await CallApi().postData(jsonEncode(data), "/api/Question/GetQuestions", 1);
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _questionList= body.map((e) => CustomQuestion.fromJson(e)).toList();

        _quest_loading=false;
        notifyListeners();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }

      _quest_loading=false;
      notifyListeners();
    }
    catch(e){

      _quest_loading=false;
      notifyListeners();
      print(' sub  ee '+e.toString());
    }
  }

  // void fetchExamById({
  //   required int examId,
  // })  async{
  //   _quest_loading=true;
  //   notifyListeners();
  //
  //   Map<String,dynamic> data={
  //     'examId':examId
  //   };
  //   try {
  //     var response = await CallApi().getWithBody(data, "/api/Exam/GetExamById", 1);
  //     print(json.decode(response.body));
  //     if (response != null && response.statusCode == 200) {
  //       List body = json.decode(response.body);
  //       _questionList= body.map((e) => CustomQuestion.fromJson(e)).toList();
  //
  //       _quest_loading=false;
  //       notifyListeners();
  //     }
  //     else {
  //       ShowMyDialog.showMsg(json.decode(response.body)['Message']);
  //     }
  //
  //     _quest_loading=false;
  //     notifyListeners();
  //   }
  //   catch(e){
  //
  //     _quest_loading=false;
  //     notifyListeners();
  //     print(' sub  ee '+e.toString());
  //   }
  // }


}