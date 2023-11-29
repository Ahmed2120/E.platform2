import 'dart:convert';
import 'dart:io';

import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/pages/courses_and_groups/groups_page.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../api/api.dart';
import '../../../core/utility/app_colors.dart';
import '../../../model/customModel.dart';
import '../../../model/mainmodel.dart';
import '../../../model/question/custom_question.dart';
import '../../../model/teacher/curency.dart';
import '../../../pages/private_groups/component/multiSelect_drowpDown.dart';
import '../../../session/userSession.dart';
import '../../../widgets/drop_downs/custom_dropdown.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/drop_downs/multiselect_dropdown.dart';
import '../../../widgets/text_fields/change_value_field.dart';
import '../../../widgets/text_fields/custom_text_field.dart';
import 'package:http/http.dart' as http;

import '../teacher_question_bank/teacher_question_bank_page.dart';

class TeacherCreateExamPage extends StatefulWidget {
  TeacherCreateExamPage({this.courseId, this.groupId, Key? key}) : super(key: key);

  final int? courseId;
  final int? groupId;

  @override
  State<TeacherCreateExamPage> createState() => _TeacherCreateExamPageState();
}

class _TeacherCreateExamPageState extends State<TeacherCreateExamPage> {

  final _formKey = GlobalKey<FormState>();

  CustomModel? subject;
  List<CustomModel> _subjects=[];
  CustomModel? day;
  CustomModel? time;
  CustomModel? educationType;
  List<CustomModel> _educationTypes = [];
  CustomModel? educationLevel;
  List<CustomModel> _levels = [];
  CustomModel? programType;
  List<CustomModel> _educationPrograms = [];
  List<CustomModel> countries = [];
  List<CustomModel> _selectedCountries=[];

  List <SelectedCurrency>_selectedCurrencies=[];
  List <CustomQuestion>_questions=[];

  List<CustomModel?> selectedEducationTypeList = [null];
  List<List<CustomModel>?> curriculumTypeList = [null];
  List<CustomModel?> selectedCurriculumTypeList = [null];
  List<List<CustomModel>?> gradesList = [null];
  List<CustomModel?> selectedGradesList = [null];
  List<List<CustomModel>?> subjectList = [null];
  List<CustomModel?> selectedSubjectList = [null];

  bool _type_loading=false;
  bool _level_loading=false;
  bool _educationProgramsLoading=false;
  bool _country_loading=false;
  bool _currency_loading=false;
  bool _subLoading=false;
  bool _questLoading=false;
  bool _create_Loading=false;


  List<Map<String, dynamic>> questions = [
    {
      'quest': 'كم مرة ذكر سيدنا هارون في القرآن؟',
      'selected': false,
    },
    {
      'quest': 'كم مرة ذكر سيدنا هارون في القرآن؟',
      'selected': false,
    },
    {
      'quest': 'كم مرة ذكر سيدنا هارون في القرآن؟',
      'selected': false,
    },
    {
      'quest': 'كم مرة ذكر سيدنا هارون في القرآن؟',
      'selected': false,
    },
  ];

  final _priceController = TextEditingController();
  final _examTitleController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _get_educationType();
    _getCountry();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'انشاء اختبار',
        child: Form(
          key: _formKey ,
          child: ListView(
            shrinkWrap: true,
            children: [
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
                                      selectEducationType(val, index);
                                    }, selectedEducationTypeList[index], 'نوع التعليم'),
                                  ),

                                  const SizedBox(width: 5,),
                                  if(curriculumTypeList[index] != null && curriculumTypeList[index]!.isNotEmpty)
                                    Expanded(
                                      child: CustomDropDown(curriculumTypeList[index]!,
                                              (val){
                                            selectProgramType(val, index);
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
                                        selectLevel(val, index);
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
              Text('عنوان الاختبار', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
              CustomTextField(controller: _examTitleController, hintText: 'عنوان الاختبار', input: TextInputType.text),

              const SizedBox(height: 5,),
              Text('مدة الاختبار', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
              CustomTextField(controller: _timeController, hintText: 'المدة', input: TextInputType.number,),
              const SizedBox(height: 5,),
              CustomMultiSelectDropDown(countries, _selectedCountries, selectCountries, 'دول العرض'),
              const SizedBox(height: 5,),
              Text('سعر الاختبار', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
              _currency_loading?const Center(child: CircularProgressIndicator())
                  :ListView.separated(
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
                          _selectedCurrencies[index].value= value==null ? 0.0
                              : double.parse(value);
                          setState(() {

                          });
                        },input:  TextInputType.number,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8,),
              ScopedModelDescendant<MainModel>(
                  builder:(context,child,MainModel model){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('الاسئلة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                      IconButton(onPressed: ()=> GlobalMethods.navigate(context, TeacherQuestBankPage(model: model,)), icon: Icon(Icons.add_circle_outlined), color: AppColors.primaryColor, iconSize: 25,)
                    ],
                  );
                }
              ),
              _questLoading?const Center(child: CircularProgressIndicator())
                  :ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _questions.length,
                  separatorBuilder: (context, index)=> const SizedBox(height: 10,),
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(_questions[index].Text!, style: Theme.of(context).textTheme.bodySmall,),
                        value: _questions[index].Selected, onChanged: (val){
                      _questions[index].Selected = val!;
                      setState(() {});
                    });
                  }
              ),

              const SizedBox(height: 20,),
              _create_Loading ? const Center(child: CircularProgressIndicator(),)
                  : CustomElevatedButton(title: 'انشاء الاختبار', function:() {
                    for(int  i = 0; i < _selectedCurrencies.length; i++){
                      print(_selectedCurrencies[i].value);
                    }
                if (validates()) _addExam();
              }),
              const SizedBox(height: 15,),

            ],
          ),
        ),
      ),
    );
  }

  changeSubject(val, index){
    selectedSubjectList[index] = val;

    if(checkLists){
      _getQuestions();
    }
  }
  changeDay(val){
    day = val;
  }
  changeTime(val){
    time = val;
  }


  selectLevel(val, index) async{
    educationLevel = val;
    selectedGradesList[index] = val;
    await _getSubOfTeacher(selectedEducationTypeList[index]!.Id, selectedGradesList[index]!.Id, selectedCurriculumTypeList[index]?.Id);
    subjectList[index] = _subjects;

    if(checkLists){
      _getQuestions();
    }
  }

  selectEducationType(val, index) async{
    educationType = val;
    selectedEducationTypeList[index] = val;
    await _getEducationPrograms(selectedEducationTypeList[index]!.Id);
    curriculumTypeList[index] = _educationPrograms;

    if(curriculumTypeList[index]!.isEmpty){
      await _get_educationLevels(educationType!.Id, null);
      gradesList[index] = _levels;
    }
    if(checkLists){
      _getQuestions();
    }
  }

  selectProgramType(val, index) async{
    selectedCurriculumTypeList[index] = val;

    await _get_educationLevels(selectedEducationTypeList[index]!.Id, selectedCurriculumTypeList[index]!.Id);
    gradesList[index] = _levels;

    if(checkLists){
      _getQuestions();
    }
  }
  selectCountries(val){
    _selectedCountries = val;
    getCurrencies();

  }

  Future<File?> pickImage() async{
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(picked != null){
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
        _levels=body.map((e) => CustomModel.fromJson(e)).toList();

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
  void _getCountry() async{

    setState(() {
      _country_loading=true;
    });

    try {
      var response = await CallApi().getData("/api/Country/GetCountries",0);

      List body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        countries=body.map((e) => CustomModel.fromJson(e)).toList();
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
    });

    List<int> c=[];
    for(int i=0 ; i <_selectedCountries.length ;i++){
      c.add(_selectedCountries[i].Id);
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
        _subjects= body.map((e) => CustomModel.fromJson(e)).toList();
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

  void _getQuestions()  async{
    print('--------------------------------------------------');
    setState(() {
      _questLoading=true;
    });
    List e = [];
    for(int i = 0; i < selectedEducationTypeList.length; i++){
      if(selectedEducationTypeList[i] != null){
        e.add(selectedEducationTypeList[i]!.Id);
      }
    }
    List p = [];
    for(int i = 0; i < selectedCurriculumTypeList.length; i++){
      if(selectedCurriculumTypeList[i] != null){
        p.add(selectedCurriculumTypeList[i]!.Id);
      }
    }
    List g = [];
    for(int i = 0; i < selectedGradesList.length; i++){
      if(selectedGradesList[i] != null){
        g.add(selectedGradesList[i]!.Id);
      }
    }
    List s = [];
    for(int i = 0; i < selectedSubjectList.length; i++){
      if(selectedSubjectList[i] != null){
        s.add(selectedSubjectList[i]!.Id);
      }
    }

    Map<String,dynamic> data={
      "EducationTypeIds":e,
      "ProgramTypeIds":p,
      "GradeIds":g,
      "SubjectIds":s
    };
    try {
      var response = await CallApi().postData(jsonEncode(data), "/api/Question/GetQuestions", 1);
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _questions= body.map((e) => CustomQuestion.fromJson(e)).toList();
        setState(() {
          _questLoading=false;
        });
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      setState(() {
        _questLoading=false;
      });
    }
    catch(e){
      setState(() {
        _questLoading=false;
      });
      print(' sub  ee '+e.toString());
    }
  }

  void _addExam()  async{

    setState(() {
      _create_Loading=true;
    });

    List<Map<String, dynamic>>  _examPrices=[];

    for(int i=0;i<_selectedCurrencies.length;i++){
      _examPrices.add({
        'CurrencyId':_selectedCurrencies[i].Id,
        "CurrencyName": _selectedCurrencies[i].Name,
        'Price':_selectedCurrencies[i].value.toInt()
      });
    }

    List<Map<String, dynamic>>  _countries=[];

    for(int i=0;i<_selectedCountries.length;i++){
      _countries.add({
        'CountryId':_selectedCountries[i].Id,
        "CountryName": _selectedCountries[i].Name,
      });
    }

    List<Map<String, dynamic>>  _quests=[];
final selectedQuest = _questions.where((element) => element.Selected).toList();

    for(int i=0;i<selectedQuest.length;i++){
      _quests.add({
        'QuestionId':selectedQuest[i].QuestionId,
        "Order": selectedQuest[i].QuestionType,
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
      "Title": _examTitleController.text,
      "CourseId": widget.courseId.toString(),
      "GroupId": widget.groupId.toString(),
      ...types,
      "ExamDuration": _timeController.text,
      // "NotebookImages": _images,
      "Countries": jsonEncode(_countries),
      "Prices": jsonEncode(_examPrices),
      "Questions": jsonEncode(_quests)
    };

    Map<String, String> params = {
      'courseId': widget.courseId.toString(),

      'groupId': widget.courseId.toString(),
    };

    print('data   '+data.toString());

    try {
      // var response = await TeacherCall().postData(json.encode(data), "/api/Notebook/AddNotebook", 1);
      StreamedResponse response = await CallApi().postJsonAndFile(data, [], "/api/Exam/AddExam", 1);
      // var body = json.decode(response.body);
      print ('body '+ await response.stream.bytesToString());

      if (response != null && response.statusCode == 200) {


        ShowMyDialog.showMsg("تم إنشاء الاختبار بنجاح");

      }
      else {
        ShowMyDialog.showMsg(response.reasonPhrase);
      }
      setState(() {
        _create_Loading=false;
      });
    }
    catch(e){
      setState(() {
        _create_Loading=false;
      });
      print(' add Exam  ee '+e.toString());
    }
  }

  bool validates(){
    if(_examTitleController.text.isEmpty) {
      ShowMyDialog.showMsg('ضع عنوان الاختبار');
      return false;
    }
    if(_timeController.text.isEmpty) {
      ShowMyDialog.showMsg('ضع مدة للاختبار');
      return false;
    }
    // if(subject == null || educationType == null || educationLevel == null || programType == null) {
    //   ShowMyDialog.showMsg('املاء جميع الحقول');
    //   return false;
    // }
    if(_questions.every((element) => !element.Selected)) {
      ShowMyDialog.showMsg('اختر اسئلة');
      return false;
    }
    if(_selectedCountries.isEmpty) {
      ShowMyDialog.showMsg('اختر دول للعرض');
      return false;
    }
    return true;
  }

  bool get checkLists{
    if(selectedEducationTypeList[0] != null
        && selectedCurriculumTypeList[0] !=null
        && selectedGradesList[0] !=null
        && selectedSubjectList[0] !=null){
      return true;
    }
    return false;
  }

}