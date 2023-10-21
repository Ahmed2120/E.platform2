
import 'dart:convert';
import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/note/note.dart';
import '../courseContent.dart';
import '../courses/course.dart';
import '../../main.dart';
import 'subject.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../api/api.dart';
import '../../session/userSession.dart';
import '../../widgets/dialogs/alertMsg.dart';
import '../courses/CourseDetails.dart';
import '../courses/teacherCourses.dart';
import '../group/group.dart';


mixin SubModel on Model{

  //---------------subject----------------
  bool _subLoading = false;
  bool get  subLoading => _subLoading;

  List<Subject> _subjects = [];
  List<Subject> get allSubjects => _subjects;
   //-----------------Branches-------------
  bool _brancgLoading = false;
  bool get  branchLoading => _brancgLoading;

  List<CustomModel> _branches = [];
  List<CustomModel> get allBranches=> _branches;

  Future fetchSub () async{
    _subLoading=true;
    Map session=await UserSession.GetData();
    notifyListeners();

    try {
      var response = await CallApi().
      getData(
          "/api/Subject/GetStudentSubjects", 1);
      //   print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _subjects = body.map((e) => Subject.fromJson(e)).toList();
      //  print("sub  " + _subjects[0].Name);
       // ShowMyDialog.showMsg(_subjects[0].Name);
        if (_subjects.length > 0) {
          fetchBranch(_subjects[0].Id);
       //   if(show_coursesAndGroups_or_Note==1){
        //  fetchCourses(_subjects[0].Id, '');
          // fetchgroups(_subjects[0].Id, '');
      //  }
        //  if(show_coursesAndGroups_or_Note==2){
         //   fetchNotes(_subjects[0].Id, '');
       //   }
        }
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _subLoading=false;
      notifyListeners();
    }
    catch(e){
     _subLoading=false;
     notifyListeners();
     print('ee '+e.toString());
    }
  }

  Future fetchBranch (int subjectId) async{
    _brancgLoading=true;

   Map<String,dynamic> data={
     'subjectId':subjectId.toString()
   };
    notifyListeners();

    try {
      var response = await CallApi().getWithBody(data,
          "/api/Subject/GetSubjectBranches", 1);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _branches = body.map((e) => CustomModel.fromJson(e)).toList();

      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _brancgLoading=false;
      notifyListeners();
    }
    catch(e){
      _brancgLoading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }








}