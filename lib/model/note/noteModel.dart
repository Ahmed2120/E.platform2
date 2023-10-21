import 'dart:convert';

import 'package:eplatform/model/note/teacherNote.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../imgCustomModel.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'note.dart';

mixin NoteModel on Model{

  //--------------------Note--------------------------------
  bool _note_loading=false;
  bool get noteLoading=>_note_loading;

  List<Note>_notes=[];
  List<Note>_mainNotes=[];
  List<Note> get allNotes=>_notes;

  //-----------------teacher Notes--------------------------
  bool _teacherNote_loading=false;
  bool get  teacherNoteLoading=>_teacherNote_loading;

  List<TeacherNotebooks> _teacherNote=[];
  List<TeacherNotebooks> get allTeacherNotes=>_teacherNote;

  //-----------------Note Details-----------------------
  bool _note_details_loading=false;
  bool get NoteDetailsLoading=>_note_details_loading;

  String _Title='';
  String get  NoteDetailsTitle=>_Title;
  double _Price=0.0;
  double get  NoteDetailsPrice=>_Price;

  String  _description='';
  String get  NoteDetailsDescription=>_description;
  List <ImgCustomModel>_imgs=[];
  List <ImgCustomModel> get NoteImgDetails=>_imgs;


  Future fetchNotes(int ? subjectId , String ? TeacherName)  async{

    _note_loading=true;
    notifyListeners();

    Map<String,dynamic> data={
      'subjectId' : subjectId.toString(),
      'TeacherName':TeacherName.toString()
    };
   // print(data.toString());

    try {
      var response = await CallApi().getWithBody(data, "/api/Notebook/GetNotebooks",1);
        print("body  "+json.decode(response.body).toString());

      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _notes=body.map((e) => Note.fromJson(e)).toList();
        _mainNotes = _notes;
        ///   print("nameeeee   "+_notes[0].TeacherName);
      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }

      _note_loading=false;
      notifyListeners();
    }
    catch(e){

      _note_loading=false;
      notifyListeners();
      print("ee "+e.toString());
    }
  }

  Future fetchTeacherNotes(int ? subjectId , int ? teacherId)  async{
    _teacherNote_loading=true;
    notifyListeners();

    Map<String,dynamic> data={
      'subjectId' : subjectId.toString(),
      'teacherId':teacherId.toString()
    };

    try {
      var response = await CallApi().getWithBody(data, "/api/Notebook/GetTeacherNotebooks",1);
       print("body  "+json.decode(response.body).toString());

      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _teacherNote=body.map((e) => TeacherNotebooks.fromJson(e)).toList();
        ///   print("nameeeee   "+_notes[0].TeacherName);
      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }

      _teacherNote_loading=false;
      notifyListeners();
    }
    catch(e){

      _teacherNote_loading=false;
      notifyListeners();
      print("ee "+e.toString());
    }
  }


  void fetchNoteDetDetails(int notebookId) async {
    _note_details_loading=true;
    notifyListeners();

    Map<String,dynamic> data={'notebookId' :notebookId.toString()};

    try {
      var response = await CallApi().getWithBody(data,
          "/api/Notebook/GetNotebookDetails",1);
      if (response != null && response.statusCode == 200) {
        var body = json.decode(response.body);
        _Title=body['Title'];
        _Price=body['Price'];
        _description=body['Description']==null?'Description':body['Description'];
        List ff=body['NotebookImages'];
        _imgs=ff.map((e) => ImgCustomModel.fromJson(e)).toList();
        print("body "+body.toString());
        notifyListeners();
      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _note_details_loading=false;
      notifyListeners();
    }
    catch(e){
      print("ee "+e.toString());
    }

    _note_details_loading=false;
    notifyListeners();

  }

  void searchNoteTeachers(String txt){
    _notes = [];
    if(txt.isEmpty){
      _notes = _mainNotes;
    }else{
      for(var note in _mainNotes){
        if(note.TeacherName.toLowerCase().contains(txt.toLowerCase()) || note.SubjectName.toLowerCase().contains(txt.toLowerCase())){
          _notes.add(note);
        }
      }
    }
    notifyListeners();
  }

}