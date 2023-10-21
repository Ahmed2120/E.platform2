
import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/teacherModels/teacherNote.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../api/api.dart';
import 'dart:convert';
import '../../priceCustomModel.dart';
import '../../widgets/dialogs/alertMsg.dart';
import '../../imgCustomModel.dart';

mixin TeacherCreatedNoteModel on Model{

  //-------------- Notes---------------
  bool _loading = false;
  bool get   teacherCreatedNoteLoading => _loading;

  List<TeacherCreatedNote> _teacherNoteList= [];
  List<TeacherCreatedNote> get allTeacherCreatedNotes => _teacherNoteList;

  //----------Note Details----------------------

  bool _detailsloading = false;
  bool get   teacherCreatedNoteDetailsLoading => _detailsloading;

  var _body ={};
   get  teacherCreatedNoteDetailsBody=>_body;

   List <ImgCustomModel> _img_list=[];
  List <ImgCustomModel>  get teacherCreatedNoteDetailsImgs=>_img_list;

  List <PriceCustomModel> _price_list=[];
  List <PriceCustomModel>  get teacherCreatedNoteDetailsPrices=>_price_list;


  Future fetchCreatedTeacherNotes (int ? subjectId) async{
    _loading=true;
    notifyListeners();
    Map <String,dynamic>data={
      'subjectId':subjectId.toString()
    };
    try {
      var response = await CallApi().getWithBody(data,"/api/Notebook/GetTeacherCreatedNotebooks", 1);
     //  print ("notes   "+response.body);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _teacherNoteList = body.map((e) => TeacherCreatedNote.fromJson(e)).toList();
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

  Future fetchCreatedTeacherNoteDetails (int ? notebookId  ) async{
    _detailsloading=true;
    _body={};
    notifyListeners();
    Map <String,dynamic>data={
      'notebookId':notebookId.toString()
    };
    try {
      var response = await CallApi().getWithBody(data,"/api/Notebook/GetNotebookById", 1);
       print ("notes   "+response.body+'      '+notebookId.toString());
      if (response != null && response.statusCode == 200) {
        var body = json.decode(response.body);
         _body=body;

          List imgs=body['NotebookImages'];
        _img_list=imgs.map((e) => ImgCustomModel.fromJson(e)).toList();

        List prices=body['NotebookPrices'];
        _price_list=prices.map((e) => PriceCustomModel.fromJson(e)).toList();

         notifyListeners();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _detailsloading=false;
      notifyListeners();
    }
    catch(e){
      _detailsloading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }



}