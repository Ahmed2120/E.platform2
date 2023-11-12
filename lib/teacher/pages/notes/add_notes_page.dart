import 'dart:convert';
import 'dart:io';

import 'package:eplatform/api/teacherCall.dart';
import 'package:eplatform/model/teacher/curency.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/teacher/pages/create_course/components/multiselect_dropdown.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

class AddNotePage extends StatefulWidget {
  AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {

  DateTime _dateTime = DateTime.now();

  CustomModel? subject;
  CustomModel? educationType;
  CustomModel? educationLevel;
  CustomModel? curriculumType;
  CustomModel? period;

  List<CustomModel> countries=[];


  List<CustomModel> _allCountries=[];
  List<CustomModel> _educationTypes=[];
  List<CustomModel> _educationLevels=[];
  List<CustomModel> _sub=[];
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
  List<File?> images = [null];

  String? fromTime;
  String? toTime;

  final _notTitleController = TextEditingController();
  final _noteDescriptionController = TextEditingController();

  bool _Loading=false;
  bool _teacherLoading=false;
  bool _type_loading=false;
  bool _level_loading=false;
  bool _country_loading=false;
  bool _currency_loading=false;
  bool _educationProgramsLoading=false;
  bool _subLoading=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _get_educationType();
    _getCountry();

  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'اضافة مذكرة',
        child:
        ListView(
          shrinkWrap: true,
          children: [

            Text('عنوان المذكرة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            CustomTextField(controller: _notTitleController, hintText: 'عنوان المذكرة', input: TextInputType.text),

            const SizedBox(height: 5,),
            Text('وصف المذكرة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            CustomTextField(controller: _noteDescriptionController, hintText: 'وصف المذكرة', input: TextInputType.text,),


            const SizedBox(height: 8,),
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
            _country_loading?Center(child: CircularProgressIndicator()):
            Text('دول العرض', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            CustomMultiSelectDropDown(_allCountries, countries, selectCountries, 'دول العرض'),

            _currency_loading ?Center(child: CircularProgressIndicator()):
            Text('السعر', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _selectedCurrencies.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index)=> Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedCurrencies[index].Name, style: Theme.of(context).textTheme.bodySmall,),
                  SizedBox(
                    width: 100,
                    child: ChangeValueField(hintText: 'السعر',
                      onChange: (value){
                        //   currencies[index] = value;
                        _selectedCurrencies[index].value= value==null ? 0.0 : double.parse(value);
                        setState(() {

                        });
                      },
                      input:  TextInputType.number,
                    ),
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
            _Loading ?Center(child: CircularProgressIndicator())
            : Builder(
                builder: (context) {
                  return  CustomElevatedButton(title: 'اضافة مذكرة', function:_addNotee);
                }
            ),
            const SizedBox(height: 15,),

          ],
        ),
      ),
    );
  }

  changeSubject(val, int index){
    // curriculumType=val;
    selectedSubjectList[index] = val;
    setState(() {

    });
  }

  selectPeriod(val){
    period=val;
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
      _selectedCurrencies.clear();
      _currency_loading=true;
    });

    List<int> _selectedCountriesForCurrency=[];
    for(int i=0 ; i <countries.length ;i++){
      _selectedCountriesForCurrency.add(countries[i].Id);
    }

    try {
      final response = await http.post(
          Uri.parse(UserSession.getURL()+'/api/Country/GetCountryCurrencies'),
          body:_selectedCountriesForCurrency.toString(),
          headers: { 'Content-Type': 'application/json',}
      );


      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        //  print(body.toString());
        _selectedCurrencies=body.map((e) => SelectedCurrency.fromJson(e)).toList();
      //   print(_selectedCurrencies[0].Name);
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

  void _addNotee()  async{

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
    //
    // for(int i=0;i<images.length;i++){
    //   _images.add({
    //     "Id": 0,
    //     "Image": images[i]?.path
    //   });
    // }

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
      "Id": "0",
      // "SubjectId": subject!.Id.toString(),
      "Title": _notTitleController.text,
      "Description": _noteDescriptionController.text,
      // "Price": 70.0,
      // "GradeId": educationLevel!.Id.toString(),
      // "EducationTypeId": educationType!.Id.toString(),
      // "ProgramTypeId": curriculumType!.Id.toString(),
      // "NotebookImages": _images,
      "Countries": jsonEncode(_countries),
      "Prices": jsonEncode(_notePrices),
      ...types
    };

    print(' Note data   '+data.toString());

    try {
      // var response = await TeacherCall().postData(json.encode(data), "/api/Notebook/AddNotebook", 1);
      var response = await CallApi().postJsonAndFile(data, _images, "/api/Notebook/AddNotebook", 1);
      // var body = json.decode(response.body);
      print ('body '+ await response.stream.bytesToString());

      if (response != null && response.statusCode == 200) {


          ShowMyDialog.showMsg("تم إنشاء المذكرة بنجاح");

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
      print(' add Note  ee '+e.toString());
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