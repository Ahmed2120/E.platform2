import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/teacher/pages/create_course/components/create_course_dropDown.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../api/api.dart';
import '../../../api/teacherCall.dart';
import '../../../core/utility/app_colors.dart';
import '../../../model/customModel.dart';
import '../../../model/mainmodel.dart';
import '../../../model/teacher/curency.dart';
import '../../../pages/components/custom_dotted_border.dart';
import '../../../session/userSession.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/drop_downs/custom_dropdown.dart';
import '../../../widgets/drop_downs/multiselect_dropdown.dart';
import '../../../widgets/text_fields/change_value_field.dart';
import '../../../widgets/text_fields/custom_text_field.dart';
import '../../../widgets/text_fields/edit_change_value_field.dart';
import '../create_course/components/multiselect_dropdown.dart';

class EditCoursePage extends StatefulWidget {
  EditCoursePage({Key? key, required this.model, required this.courseId}) : super(key: key);
  final MainModel model;
  final int courseId;

  @override
  State<EditCoursePage> createState() => _EditCoursePageState();
}

class _EditCoursePageState extends State<EditCoursePage> {

  CustomModel? subject;
  CustomModel? day;
  CustomModel? time;
  List<CustomModel> countries=[];


  CustomModel? educationType;
  CustomModel? educationLevel;
  CustomModel? curriculumType;

  TypeGroup typeGroup = TypeGroup.group;
  TypeTime typeTime = TypeTime.morning;

  bool isNextPage = false;

  List _CoursePrices=[];

  List<CustomModel> _allCountries=[];
  List<CustomModel> _educationTypes=[];
  List<CustomModel> _educationLevels=[];
  List<CustomModel> _educationPrograms=[];
  List <SelectedCurrency>_selectedCurrencies=[];
  List <SelectedCurrency>_selectedLessonCurrencies=[];
  List<CustomModel> _sub=[];


  bool _type_loading=false;
  bool _level_loading=false;
  bool _educationProgramsLoading=false;
  bool _country_loading=false;
  bool _currency_loading=false;
  bool _subLoading=false;
  bool _Loading=false;


  List<SubscriptionPeriod> subscriptionPeriodList = [
    SubscriptionPeriod(1, 'سنة'),
    SubscriptionPeriod(2, 'ترم'),
    SubscriptionPeriod(3, 'شهر'),
    SubscriptionPeriod(4, 'حصة'),
  ];

  List<SuggestedTeacher> suggestedTeachers = [
    SuggestedTeacher(1, 'أ/احمد خالد'),
    SuggestedTeacher(2, 'أ/محمد محمود'),
    SuggestedTeacher(3, 'أ/احمد ابراهيم'),
  ];

  Map courseFiles =
  {
    'video': null,
    'file': null,
    'title': null,
    'price': null,
  };

  List<Map<String, String>> currencies = [
    {
      'ج.م': '',},
    { 'د.ع': '',},
    { 'ل.س': '',},
    { 'ر.س': '',},
    {'د.إ': '',},
    {'ر.ع': '',},
    {'ر.ق': '',}
  ];

  List<Map<String, String>> lessonCurrencies = [
    {
      'ج.م': '',},
    { 'د.ع': '',},
    { 'ل.س': '',},
    { 'ر.س': '',},
    {'د.إ': '',},
    {'ر.ع': '',},
    {'ر.ق': '',}
  ];

  List attachments = [null];

  List<CustomModel?> selectedEducationTypeList = [null];
  List<List<CustomModel>?> curriculumTypeList = [null];
  List<CustomModel?> selectedCurriculumTypeList = [null];
  List<List<CustomModel>?> gradesList = [null];
  List<CustomModel?> selectedGradesList = [null];
  List<List<CustomModel>?> subjectList = [null];
  List<CustomModel?> selectedSubjectList = [null];

  final _courseNameController = TextEditingController();
  final _teacherNameController = TextEditingController();
  final _courseTitleController = TextEditingController();
  final _coursePriceController = TextEditingController();
  final _subjectNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _get_educationType();
    _getCountry();

    _getCourseData();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'تفاصيل الكورس',
        child: ListView(
          shrinkWrap: true,
          children: [

            Text('عنوان الكورس', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            CustomTextField(controller: _courseNameController, hintText: 'عنوان الكورس', input: TextInputType.text,),
            const SizedBox(height: 8,),

            Text('اسم المادة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            //  CreateCourseField(controller: _subjectNameController, hintText: 'اسم المادة'),

            _subLoading?Center(child: CircularProgressIndicator()):
            CreateCourseDropDown(_sub, changeSubject, subject, 'اسم الماة'),
            // const SizedBox(height: 5,),
            // Text('اسم المدرس ', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            // CreateCourseField(controller: _teacherNameController, hintText: 'اسم المدرس'),
            const SizedBox(height: 5,),

            Text('دول العرض', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            CustomMultiSelectDropDown(_allCountries, countries, selectCountries, 'دول العرض'),

            const SizedBox(height: 5,),
            Text('سعر الكوررس', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            const SizedBox(height: 8,),
            Text('السعر', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),

            _currency_loading?const Center(child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            )):
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _CoursePrices.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index)=> Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_CoursePrices[index]['CurrencyName'],
                    style: Theme.of(context).textTheme.bodySmall,),
                  SizedBox(
                    width: 100,
                    child: EditChangeValueField
                      ( hintText: 'السعر',
                      onChange: (value){
                        //   currencies[index] = value;
                        _CoursePrices[index]['Price']= value==null ? 0.0 : double.parse(value);
                        setState(() {

                        });
                      } ,value: _CoursePrices[index]['Price'] ==null?0.0.toString():
                      _CoursePrices[index]['Price'].toString()
                      ,),
                  )
                ],
              ),
            ),

            const SizedBox(height: 15,),
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

            const SizedBox(height: 20,),
            Builder(
                builder: (context) {
                  return  _Loading ? Center(child: CircularProgressIndicator())
                      :CustomElevatedButton(title: 'تعديل الكورس', function:// _addGroup _
                  _updateCourse );
                }
            ),
            const SizedBox(height: 15,),

          ],
        ),
      ),
    );
  }

  Future<File?> pickFile() async {
    final picked = await FilePicker.platform.pickFiles();
    if (picked != null) {
      return File(picked.files.single.path!);
    }
  }

  changeSubject(val, int index){
    // curriculumType=val;
    selectedSubjectList[index] = val;
    setState(() {

    });
  }
  changeDay(val){
    day = val;
  }
  changeTime(val){
    time = val;
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

  selectCountries(val){
    countries = val;
    getCurrencies();

    setState(() {

    });

  }

  changePeriod(SubscriptionPeriod subscriptionPeriod){
    for(var i = 0; i< subscriptionPeriodList.length; i++ ){
      if(subscriptionPeriodList[i].id == subscriptionPeriod.id){
        subscriptionPeriodList[i].isActive = true;
      }
      else{
        subscriptionPeriodList[i].isActive = false;
      }

    }
    setState(() {});
  }

  chooseTeacher(SuggestedTeacher suggestedTeacher){
    // teacher = suggestedTeacher.name;
    setState(() {});
  }

  Widget subscriptionPeriodContainer(SubscriptionPeriod subscriptionPeriod) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryColor),
        color: subscriptionPeriod.isActive ? AppColors.primaryColor : Colors.white
    ),
    child: Center(child: Text(subscriptionPeriod.txt, style: TextStyle(fontSize: 12, color: subscriptionPeriod.isActive ? Colors.white : AppColors.primaryColor),)),
  );

  Widget suggestedTeacherContainer(SuggestedTeacher suggestedTeacher) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.primaryColor),
    ),
    child: Center(child: Text(suggestedTeacher.name, style: const TextStyle(fontSize: 12, color: AppColors.primaryColor),)),
  );

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
      _CoursePrices=[];
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
          _CoursePrices.add({
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

  void  _getCourseData()  async{

    setState(() {
      _Loading=true;
    });

    Map <String,dynamic>data={
      'courseId':widget.courseId.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,"/api/Course/GetCourseById",1);
      var body = json.decode(response.body);
      print ('body '+body.toString());

      if (response != null && response.statusCode == 200) {

          _courseNameController.text = body['Title'];
          subject= CustomModel(Id: body['SubjectId'], Name: body['SubjectName'], NameEN: '');
          curriculumType= CustomModel(Id: body['ProgramTypeId'], Name: body['ProgramTypeName'], NameEN: '');
          educationType= CustomModel(Id: body['EducationTypeId'],
              Name: body['EducationTypeName'], NameEN: '');
          widget.model.fetchTeacherEducationPrograms(educationType!);
          educationLevel=new CustomModel(Id: body['GradeId'],
              Name: body['GradeName'], NameEN: '');

          List  courseCountries =body['CourseCountries'];

          for(int i=0;i<courseCountries.length;i++){
            setState(() {

              countries.add( CustomModel(Id: courseCountries[i]['CountryId'],
                  Name:courseCountries[i]['CountryName'], NameEN: ''));
            });

          }

          _CoursePrices=body['CoursePrices'];

          print(';;;;;;;;;;;;;;;;;;');
          print(countries);

      }
      else {
        ShowMyDialog.showMsg(body['Message']);
      }
      setState(() {
        _Loading=false;
      });
    }
    catch(e){
      setState(() {
        _Loading=false;
      });
      print(' add Group  ee '+e.toString());
    }
  }

  void _updateCourse()  async{

    setState(() {
      _Loading=true;
    });



    List<Map<String, dynamic>> _CouurseCountries=[];
    for(int i=0;i<countries.length;i++){
      _CouurseCountries.add( {'CountryId':countries[i].Id });
    }

    List educationTypeIds = [];
    List programTypeIds = [];
    List gradeIds = [];
    List subjectIds = [];

    Map<String, String> types = {};
    for(int i = 0; i < selectedEducationTypeList.length; i++){
      if(selectedEducationTypeList[i] != null){
        types['EducationTypeIds[$i]'] = selectedEducationTypeList[i]!.Id.toString();
        educationTypeIds.add(selectedEducationTypeList[i]!.Id);
      }
      if(selectedCurriculumTypeList[i] != null){
        types['ProgramTypeIds[$i]'] = selectedCurriculumTypeList[i]!.Id.toString();
        programTypeIds.add(selectedCurriculumTypeList[i]!.Id);
      }
      if(selectedGradesList[i] != null){
        types['GradeIDs[$i]'] = selectedGradesList[i]!.Id.toString();
        gradeIds.add(selectedGradesList[i]!.Id);
      }
      if(selectedSubjectList[i] != null){
        types['SubjectIDs[$i]'] = selectedSubjectList[i]!.Id.toString();
        subjectIds.add(selectedSubjectList[i]!.Id);
      }
    }


    Map data={
      "Id": widget.courseId,
      "Title": _courseNameController.text,
      "EducationTypeIds":educationTypeIds,
      "ProgramTypeIds":programTypeIds,
      "GradeIds":gradeIds,
      "SubjectIds":subjectIds,
      "CourseCountries": _CouurseCountries,
      "CoursePrices": _CoursePrices
    };
    print('data   '+data.toString());
    try {
      var response = await TeacherCall().putData(json.encode(data), "/api/Course/UpdateCourse", 1);
      var body = json.decode(response.body);
      print ('body '+body.toString());

      if (response != null && response.statusCode == 200) {
        if(body['Success']) {

          ShowMyDialog.showMsg("تم تعديل بيانات الكورس بنجاح");

          //  Navigator.of(context).pop();
        }
      }
      else {
        ShowMyDialog.showMsg(body['Message']);
      }
      setState(() {
        _Loading=false;
      });
    }
    catch(e){
      setState(() {
        _Loading=false;
      });
      print(' update Group  ee '+e.toString());
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