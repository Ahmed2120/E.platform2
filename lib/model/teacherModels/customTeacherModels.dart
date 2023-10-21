import 'dart:convert';
import 'package:eplatform/model/customModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:eplatform/model/teacher/curency.dart';
import '../../api/api.dart';
import '../../api/teacherCall.dart';
import '../../widgets/dialogs/alertMsg.dart';

mixin CustomTeacherModels on Model{

  ///----------Teacher Subject -------------------
    bool  _teacherLoading=false;
    bool get  customSubOfTeacherLoading=>_teacherLoading;

    List <CustomModel> _sub=[];
    List <CustomModel> get  allCustomSubOfTeacher=>_sub;


    ///--------educationType-------
    bool _type_loading =false;
    bool get customEducationType =>_type_loading;

    List <CustomModel> _educationTypes=[];
    List <CustomModel> get  allCustomEducationType =>_educationTypes;

    ///---------EducationPrograms---------
    bool  _educationProgramsLoading=false;
    bool get  customEducationProgramsLoading=>_educationProgramsLoading;

    List<CustomModel>_educationPrograms=[];
    List<CustomModel> get allCustomEducationPrograms=>_educationPrograms;

    ///--------------educationLevels----------
    bool _level_loading=false;
    bool get customLevel_loading=>_level_loading;

    List<CustomModel>_educationLevels=[];
    List<CustomModel> get allCustomEducationLevels=>_educationLevels;

    ///---------------Country --------
    bool _country_loading=false;
    bool get customCountry_loading =>_country_loading;

    List<CustomModel>_allCountries=[];
    List<CustomModel> get allSustomTeacherCountries=>_allCountries;

    ///-----------Currencies--------------
    bool _currency_loading=false;
    bool get customCurrency_loading=>_currency_loading;

    List<SelectedCurrency>_selectedCurrencies=[];
    List <SelectedCurrency> get allCustomSelectedCurrencies =>_selectedCurrencies;

    List<SelectedCurrency>_selectedLessonCurrencies=[];
    List <SelectedCurrency> get allCustomSelectedLessonCurrencies =>_selectedLessonCurrencies;


  void  fetchSubOfTeacher1()  async{

      _teacherLoading=true;
        notifyListeners();
    Map<String,dynamic> data={
      'teacherId':null
    };
    try {
      var response = await CallApi().getWithBody(data, "/api/Teacher/GetTeacherSubjects", 1);
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _sub= body.map((e) => CustomModel.fromJson(e)).toList();

          _teacherLoading=false;
          notifyListeners();
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }

        _teacherLoading=false;
      notifyListeners();
    }
    catch(e){

        _teacherLoading=false;
       notifyListeners();
      print(' teacher  ee '+e.toString());
    }
  }

  void   fetchTeacherEducationType() async{


      _type_loading=true;
   notifyListeners();

    try {
      var response = await CallApi().getData("/api/Teacher/GetTeacherEducationTypes",1);
      if (response != null && response.statusCode == 200) {
        print(response.body);
        List body = json.decode(response.body);
        _educationTypes=body.map((e) => CustomModel.fromJson(e)).toList();
      }
    }
    catch(e){

      //   ShowMyDialog.showSnack(context,'ee '+e.toString());

    }

      _type_loading=false;
     notifyListeners();
  }

  void   fetchTeacherEducationPrograms(CustomModel educationType) async{

      _educationProgramsLoading=true;

    Map <String, dynamic>data={
      "educationTypeId" :educationType.Id.toString()
    };
    notifyListeners();

    try {
      var response = await CallApi().getWithBody(data,
          "/api/EducationProgram/GetEducationPrograms",1);
      List body =json.decode(response.body) ;
      if (response != null && response.statusCode == 200) {
        _educationPrograms=body.map((e) => CustomModel.fromJson(e)).toList();

      }

        _educationProgramsLoading=false;
       notifyListeners();
    }
    catch(e){
      print ('ee '+e.toString());
        _educationProgramsLoading=false;
       notifyListeners();
    }

  }

  void fetchTeacherEducationLevels() async{

      _level_loading=true;
      notifyListeners();


    try {
      var response = await CallApi().getData("/api/Teacher/GetTeacherGrades",1);

      if (response != null && response.statusCode == 200) {
        List body =json.decode(response.body) ;
        _educationLevels=body.map((e) => CustomModel.fromJson(e)).toList();

      }
    }
    catch(e){
      print ('ee '+e.toString());

    }

      _level_loading=false;
       notifyListeners();

  }

  void   fetchTeacherEducationCountries() async{


      _country_loading=true;
        notifyListeners();

    try {
      var response = await CallApi().getData("/api/Country/GetCountries",0);

      List body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        _allCountries=body.map((e) => CustomModel.fromJson(e)).toList();
      }
    }
    catch(e){
      print ('ee '+e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
    }

      _country_loading=false;
      notifyListeners();
  }

  void  fetchTeacherCurrencies(List<CustomModel>countries ) async{

    _currency_loading=true;
       notifyListeners();

    List<int> c=[];
    for(int i=0 ; i <countries.length ;i++){
      c.add(countries[i].Id);
    }

    try {
    /*  final response = await http.post(
          Uri.parse(UserSession.getURL()+'/api/Country/GetCountryCurrencies'),
          body:c.toString(),
          headers: { 'Content-Type': 'application/json',}
      );*/
      final  response = await TeacherCall().postData(c.toString(), "/api/Country/GetCountryCurrencies", 0);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        //  print(body.toString());
        _selectedCurrencies=body.map((e) => SelectedCurrency.fromJson(e)).toList();

        notifyListeners();

      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }

        _currency_loading=false;
         notifyListeners();
    }
    catch(e){
      print (' currrency ee '+e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());

        _currency_loading=false;
       notifyListeners();
    }

  }



}