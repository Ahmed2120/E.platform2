import 'dart:convert';
import 'dart:io';
import 'package:eplatform/api/teacherCall.dart';
import 'package:eplatform/imgCustomModel.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/model/teacher/curency.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:eplatform/widgets/text_fields/edit_custom_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../api/api.dart';
import '../../../core/utility/app_colors.dart';
import '../../../model/customModel.dart';
import '../../../pages/components/custom_dotted_border.dart';
import '../../../session/userSession.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/drop_downs/custom_dropdown.dart';
import '../../../widgets/drop_downs/multiselect_dropdown.dart';
import '../../../widgets/text_fields/change_value_field.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../../widgets/text_fields/custom_text_field.dart';
import '../../../widgets/text_fields/edit_change_value_field.dart';

class EditNotePage extends StatefulWidget {
  EditNotePage({required this.model,required this.notebookId, Key? key}) : super(key: key);
  MainModel model;
  int notebookId;

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {

  DateTime _dateTime = DateTime.now();

  CustomModel? subject;
  CustomModel? educationType;
  CustomModel? educationLevel;
  CustomModel? curriculumType;


  List<CustomModel> _allCountries=[];
  List<CustomModel> countries=[];
  List _NotePrices=[];

  List<CustomModel> _educationTypes=[];
  List<CustomModel> _sub=[];
  List<CustomModel> _educationLevels=[];
  List<CustomModel> _educationPrograms=[];
  List <SelectedCurrency>_selectedCurrencies=[];

  List<CustomModel?> selectedEducationTypeList = [null];
  List<List<CustomModel>?> curriculumTypeList = [null];
  List<CustomModel?> selectedCurriculumTypeList = [null];
  List<List<CustomModel>?> gradesList = [null];
  List<CustomModel?> selectedGradesList = [null];
  List<List<CustomModel>?> subjectList = [null];
  List<CustomModel?> selectedSubjectList = [null];


  TypeGroup typeGroup = TypeGroup.group;
  TypeTime typeTime = TypeTime.morning;

  bool isNextPage = false;



  File? image;

  String? fromTime;
  String? toTime;

  final _notTitleController = TextEditingController();
  final _noteDescriptionController = TextEditingController();

  bool _Loading=false;
  bool _currency_loading=false;
  bool _country_loading=false;
  bool _educationProgramsLoading=false;
  bool _subLoading=false;
  bool _detailsloading=false;
  bool _type_loading=false;
  bool _level_loading=false;

  List<Map<String,dynamic>> _NotebookImages=[];
  List<File?> images = [null];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.model.fetchTeacherEducationType();
    widget.model.fetchTeacherEducationCountries();

    _getCountry();

       _getData();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
          builder:(context,child,MainModel model){
            return CustomStack(
            pageTitle: 'تفاصيل المذكرة',
            child:
               _detailsloading?
                Center(child: CircularProgressIndicator()):
             ListView(
              shrinkWrap: true,
              children: [

                const SizedBox(height: 5,),
                Text('عنوان المذكرة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  CustomTextField(controller: _notTitleController,
                    hintText: 'عنوان المذكرة', input: TextInputType.text,
                  ),

                const SizedBox(height: 5,),
                Text('وصف المذكرة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                CustomTextField(controller: _noteDescriptionController, hintText: 'وصف المذكرة',
                  input: TextInputType.text,
                  ),

                const SizedBox(height: 5,),

                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: curriculumTypeList.length,
                    separatorBuilder: (context, index)=> const SizedBox(height: 10,),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomDropDown(_educationTypes, (val){
                                        changeEducationType(val, index);
                                      }, selectedEducationTypeList[index], 'نوع التعليم'),
                                    ),

                                    const SizedBox(width: 5,),
                                    if(curriculumTypeList[index] != null && curriculumTypeList[index]!.isNotEmpty)
                                      Expanded(
                                        child: CustomDropDown(curriculumTypeList[index]!,
                                                (val){
                                              change_educationPrograms(val, index);
                                            }, selectedCurriculumTypeList[index], 'نوع المنهج'),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Row(
                                  children: [
                                    if(gradesList[index] != null && gradesList[index]!.isNotEmpty)
                                      Expanded(
                                        child: CustomDropDown(gradesList[index]!, (val){
                                          changeEducationLevel(val, index);
                                        }, selectedGradesList[index], 'السنة الدراسية'),
                                      ),

                                    const SizedBox(width: 5,),
                                    if(subjectList[index] != null && subjectList[index]!.isNotEmpty)
                                      Expanded(
                                        child: CustomDropDown(subjectList[index]!,
                                                (val){
                                              changeSubject(val, index);
                                            }, selectedSubjectList[index], 'المادة'),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          const SizedBox(width: 10,),
                          if(index == curriculumTypeList.length - 1)
                            InkWell(
                                onTap: ()
                                {
                                  curriculumTypeList.add(null);
                                  selectedEducationTypeList.add(null);
                                  selectedCurriculumTypeList.add(null);
                                  gradesList.add(null);
                                  selectedGradesList.add(null);
                                  subjectList.add(null);
                                  selectedSubjectList.add(null);
                                  setState(() {});
                                },
                                child: const Icon(Icons.add_circle_sharp,
                                  color: AppColors.primaryColor, size: 40,))
                        ],
                      );
                    }
                ),

                const SizedBox(height: 5,),


                Text('دول العرض', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                CustomMultiSelectDropDown(_allCountries, countries, selectCountries, 'دول العرض'),

                Text('السعر', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),

                _currency_loading?const Center(child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(),
                )):
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _NotePrices.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index)=> Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_NotePrices[index]['CurrencyName'], style: Theme.of(context).textTheme.bodySmall,),
                      SizedBox(
                        width: 100,
                        child: EditChangeValueField
                          ( hintText: 'السعر',
                          onChange: (value){
                            //   currencies[index] = value;
                            _NotePrices[index]['Price']= value==null ? 0.0 : double.parse(value);
                            setState(() {

                            });
                          } ,value: _NotePrices[index]['Price'] ==null?0.0.toString():
                          _NotePrices[index]['Price'].toString()
                          ,),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 8,),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            width: 130,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async{
                                    final picked = await pickImage();
                                    if(picked == null) return;
                                    images[index] = picked;
                                    setState(() {});
                                  },
                                  child: CustomDottedBorder(
                                    child: Column(
                                      children: [
                                        Image.asset('assets/images/promo.png'),
                                        Text(images[index] != null ? basename(images[index]!.path) : 'رفع صور', style: TextStyle(fontSize: 14),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15,),
                          if(index == images.length - 1)
                            InkWell(
                                onTap: (){
                                  images.add(null);
                                  setState(() {});
                                },

                                child: const Icon(Icons.add_circle_sharp, color: AppColors.primaryColor, size: 60,))
                        ],
                      );
                    }
                ),

                const SizedBox(height: 20,),
                _Loading?Center(child: CircularProgressIndicator()):
                Builder(
                    builder: (context) {
                      return  CustomElevatedButton(title: 'تعديل', function:_updateNotee);
                    }
                ),
                const SizedBox(height: 15,),
              ],
            ),
          );
        }
      ),
    );
  }

  changeSubject(val, int index){
    // curriculumType=val;
    selectedSubjectList[index] = val;
    setState(() {

    });
  }



  selectCountries(val){
    countries = val;
    getCurrencies();

    setState(() {

    });

  }

  changeEducationLevel(val, int index) async{

    selectedGradesList[index] = val;
    await _getSubOfTeacher(selectedEducationTypeList[index]!.Id, selectedGradesList[index]!.Id, selectedCurriculumTypeList[index]?.Id);
    subjectList[index] = _sub;
    setState(() {
    });

  }

  changeEducationType(val, int index) async{
    educationType=val;
    selectedEducationTypeList[index] = val;
    await _getEducationPrograms(selectedEducationTypeList[index]!.Id);
    curriculumTypeList[index] = _educationPrograms;

    if(curriculumTypeList[index]!.isEmpty){
      await _get_educationLevels(educationType!.Id, null);
      gradesList[index] = _educationLevels;
    }
    setState(() {

    });
  }

  change_educationPrograms(val, int index)async{
    selectedCurriculumTypeList[index] = val;

    await _get_educationLevels(selectedEducationTypeList[index]!.Id, selectedCurriculumTypeList[index]!.Id);
    gradesList[index] = _educationLevels;
    setState(() {

    });
  }

  chooseTeacher(SuggestedTeacher suggestedTeacher){
    // teacher = suggestedTeacher.name;
    setState(() {});
  }

  Future<File?> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);;
    if (picked != null) {
      return File(picked.path);
    }
  }


  void _get_educationType() async{

    setState(() {
      _type_loading=true;
    });

    try {
      var response = await CallApi().getData("/api/Teacher/GetTeacherEducationTypes",1);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _educationTypes=body.map((e) => CustomModel.fromJson(e)).toList();
      }
    }
    catch(e){

      ShowMyDialog.showSnack(context,'ee '+e.toString());

    }
    setState(() {
      _type_loading=false;
    });
  }

  Future _getEducationPrograms(int educationTypeId) async{

    setState(() {
      _educationProgramsLoading=true;
    });
    Map <String, dynamic>data={
      "educationTypeId" :educationTypeId.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,
          "/api/EducationProgram/GetEducationPrograms",0);
      List body =json.decode(response.body) ;
      if (response != null && response.statusCode == 200) {
        _educationPrograms=body.map((e) => CustomModel.fromJson(e)).toList();

      }
      setState(() {
        _educationProgramsLoading=false;
      });
    }
    catch(e){
      print ('ee '+e.toString());
      ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
      setState(() {
        _educationProgramsLoading=false;
      });
    }

  }
  Future _get_educationLevels(int educationTypeId, int? programTypeId) async{

    setState(() {
      _level_loading=true;
    });

    Map <String, dynamic>data={
      "educationTypeId" :educationTypeId.toString(),
      "programTypeId" : programTypeId.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,
          "/api/Grade/GetGradesByEducationProgramType",0);

      if (response != null && response.statusCode == 200) {
        List body =json.decode(response.body) ;
        _educationLevels=body.map((e) => CustomModel.fromJson(e)).toList();

      }
    }
    catch(e){
      print ('ee '+e.toString());
      ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _level_loading=false;
    });
  }
  Future _getSubOfTeacher(int educationTypeId, int gradeId, int? programTypeId)  async{
    setState(() {
      _subLoading=true;
    });
    Map <String, dynamic>data={
      "educationTypeId" : educationTypeId.toString(),
      "gradeId" : gradeId.toString(),
      "programTypeId" : programTypeId.toString()
    };
    try {
      var response = await CallApi().getWithBody(data,
          "/api/Subject/GetSubjects",0);
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _sub= body.map((e) => CustomModel.fromJson(e)).toList();
        setState(() {
          _subLoading=false;
        });
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      setState(() {
        _subLoading=false;
      });
    }
    catch(e){
      setState(() {
        _subLoading=false;
      });
      print(' sub  ee '+e.toString());
    }
  }

  void _getCountry() async{

    setState(() {
      _country_loading=true;
    });

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
    setState(() {
      _country_loading=false;
    });
  }

  void getCurrencies() async{

    setState(() {
      _currency_loading=true;
      _NotePrices=[];
    });

    List<int> c=[];
    for(int i=0 ; i <countries.length ;i++){
      c.add(countries[i].Id);
    }

    try {
      final response = await http.post(
          Uri.parse(UserSession.getURL()+'/api/Country/GetCountryCurrencies'),
          body:c.toString(),
          headers: { 'Content-Type': 'application/json',}
      );


      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        //  print(body.toString());
        _selectedCurrencies=body.map((e) => SelectedCurrency.fromJson(e)).toList();
        for(int i=0;i<_selectedCurrencies.length;i++){
          _NotePrices.add({
            'CurrencyId': _selectedCurrencies[i].Id,
            'CurrencyName': _selectedCurrencies[i].Name,
            'Price': _selectedCurrencies[i].value });
        }

        setState(() {

        });

      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      setState(() {
        _currency_loading=false;
      });
    }
    catch(e){
      print (' currrency ee '+e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
      setState(() {
        _currency_loading=false;
      });
    }

  }

  void _updateNotee()  async{

    setState(() {
      _Loading=true;
    });

    List<Map<String, dynamic>>  _notePrices=[];

    for(int i=0;i<_selectedCurrencies.length;i++){
      _notePrices.add({
        'CurrencyId':_selectedCurrencies[i].Id,
        "CurrencyName": _selectedCurrencies[i].Name,
        'Price':_selectedCurrencies[i].value.toInt()
      });
    }

    List<Map<String, dynamic>>  _countries=[];

    for(int i=0;i<countries.length;i++){
      _countries.add({
        'CountryId':countries[i].Id,
        "CountryName": countries[i].Name,
      });
    }

    List<Map<String, dynamic>>  _images=[];

    for(int i=0;i<images.length;i++){
      _images.add({
        'title': 'Images', 'file': images[i]
      });
    }

    Map<String, String> types = {};
    for(int i = 0; i < selectedEducationTypeList.length; i++){
      if(selectedEducationTypeList[i] != null){
        types['EducationTypeIds[$i]'] = selectedEducationTypeList[i]!.Id.toString();

      }
      if(selectedCurriculumTypeList[i] != null){
        types['ProgramTypeIds[$i]'] = selectedCurriculumTypeList[i]!.Id.toString();
      }
      if(selectedGradesList[i] != null){
        types['GradeIDs[$i]'] = selectedGradesList[i]!.Id.toString();
      }
      if(selectedSubjectList[i] != null){
        types['SubjectIDs[$i]'] = selectedSubjectList[i]!.Id.toString();
      }
    }

    Map<String, String> data={
      "Id": widget.notebookId.toString(),
      "Title": _notTitleController.text,
      "Description": _noteDescriptionController.text,
      "Prices": jsonEncode(_notePrices),
      "Countries": jsonEncode(_countries),
      ...types
    };

    print('data   '+data.toString());

    try {
      StreamedResponse response = await CallApi().putJsonAndFile(data, _images, "/api/Notebook/UpdateNotebook", 1);


      if (response != null && response.statusCode == 200) {


          ShowMyDialog.showMsg("تم تعديل بيانات المذكرة بنجاح");

          //  Navigator.of(context).pop();

      }
      else {
        ShowMyDialog.showMsg(response.reasonPhrase);
      }
      setState(() {
        _Loading=false;
      });
    }
    catch(e){
      setState(() {
        _Loading=false;
      });
      print('  update  ee '+e.toString());
    }
  }


  void _getData () async{
    _detailsloading=true;

   setState(() {

   });
    Map <String,dynamic>data={
      'notebookId':widget.notebookId.toString()
    };
    try {
      var response = await CallApi().getWithBody(data,"/api/Notebook/GetNotebookById", 1);
      print ("notes   "+response.body);
      if (response != null && response.statusCode == 200) {
        var body = json.decode(response.body);

       _notTitleController.text=body['Title'];
       _noteDescriptionController.text=body['Description']??'';

        educationLevel=new CustomModel(Id: body['GradeId'], Name: body['GradeName'], NameEN: '');
        subject=new CustomModel(Id: body['SubjectId'], Name: body['SubjectName'], NameEN: '');
        educationType=new CustomModel(Id: body['EducationTypeId'], Name: body['EducationTypeName'], NameEN: '');
        curriculumType=new CustomModel(Id: body['ProgramTypeId'], Name: body['ProgramTypeName'], NameEN: '');

        _getEducationPrograms(educationType!.Id);

        List  noteCountries =body['NotebookCountries'];
        for(int i=0;i<noteCountries.length;i++){
          setState(() {

            countries.add( CustomModel(Id: noteCountries[i]['CountryId'],
                Name:noteCountries[i]['CountryName'], NameEN: ''));
          });

        }

        _NotePrices=body['NotebookPrices'];

        List imgs=body['NotebookImages'];
        for(int i=0 ;i<imgs.length;i++){
          _NotebookImages.add({
            'Id':imgs[i]['Id'],
            'Image':imgs[i]['Image'].toString()
          });
        }

        setState(() {
       //   curriculumType=new CustomModel(Id: body['ProgramTypeId'], Name: body['ProgramTypeName'], NameEN: '');

        });

      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _detailsloading=false;
      setState(() {

      });
    }
    catch(e){
      _detailsloading=false;
      setState(() {

      });

      print('ee '+e.toString());
    }
  }





}

enum TypeGroup{
  group,
  single
}

enum TypeTime{
  night,
  morning
}

class SubscriptionPeriod{
  int id;
  String txt;
  bool isActive;

  SubscriptionPeriod(this.id, this.txt, {this.isActive = false});
}

class SuggestedTeacher{
  int id;
  String name;
  bool isActive;

  SuggestedTeacher(this.id, this.name, {this.isActive = false});
}

class Teacher{
  int id;
  String name;

  Teacher(this.id, this.name);
}