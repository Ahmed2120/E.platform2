import 'dart:convert';
import 'dart:io';

import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/teacher/curency.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../api/api.dart';
import '../../../api/teacherCall.dart';
import '../../../core/utility/app_colors.dart';
import '../../../model/customModel.dart';
import '../../../session/userSession.dart';
import '../../../widgets/drop_downs/custom_dropdown.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/text_fields/change_value_field.dart';
import 'package:http/http.dart' as http;

import '../../../widgets/text_fields/custom_text_field.dart';

class CreateLivePage extends StatefulWidget {
  CreateLivePage({Key? key}) : super(key: key);

  @override
  State<CreateLivePage> createState() => _CreateLivePageState();
}

class _CreateLivePageState extends State<CreateLivePage> {

  DateTime _dateTime = DateTime.now();

  CustomModel? subject;
  CustomModel? educationType;
  CustomModel? educationLevel;
  CustomModel? curriculumType;
  CustomModel? period;

  List<CustomModel> countries=[];

  List<Map<String, dynamic>> days=[
    {'days':
    [ CustomModel(Id: 1, Name: 'السبت', NameEN: 'Saturday'),
      CustomModel(Id: 2, Name: 'الاحد', NameEN: 'Sunday'),
      CustomModel(Id: 3, Name: 'الاثنين', NameEN: 'Monday'),
      CustomModel(Id: 4, Name: 'الثلاثاء', NameEN: 'Tuesday'),
      CustomModel(Id: 5, Name: 'الاربعاء', NameEN: 'Wednesday'),
      CustomModel(Id: 6, Name: 'الخميس', NameEN: 'Thursday'),
      CustomModel(Id: 7, Name: 'الجمعة', NameEN: 'Friday'),],
      'selectedDay': null,
      'fromTime': null,
      'toTime': null,
    }
  ];

  List<CustomModel> _allCountries=[];
  List<CustomModel> _educationTypes=[];
  List<CustomModel> _educationLevels=[];
  List<CustomModel> _sub=[];
  List<CustomModel> _educationPrograms=[];
  List <SelectedCurrency>_selectedCurrencies=[];


  TypeGroup typeGroup = TypeGroup.group;
  TypeTime typeTime = TypeTime.morning;

  bool isNextPage = false;

  List<CustomModel> subscriptionPeriodList = [
    CustomModel(Id: 1,Name: 'حصة', NameEN: ''),
    CustomModel(Id: 2,Name: 'شهر', NameEN: ''),
    CustomModel(Id: 3,Name: 'ترم', NameEN: ''),
    CustomModel(Id: 4,Name: 'سنة', NameEN: ''),
  ];

  List<SuggestedTeacher> suggestedTeachers = [
    SuggestedTeacher(1, 'أ/احمد خالد'),
    SuggestedTeacher(2, 'أ/محمد محمود'),
    SuggestedTeacher(3, 'أ/احمد ابراهيم'),
  ];


  File? _video;

  String? fromTime;
  String? toTime;

  final _liveNameController = TextEditingController();
  final _teacherNameController = TextEditingController();
  final _studentsNumController = TextEditingController();
  final _classesNumController = TextEditingController();
  final _periodController = TextEditingController();

  bool _Loading=false;
  bool _teacherLoading=false;
  bool _type_loading=false;
  bool _level_loading=false;
  bool _country_loading=false;
  bool _currency_loading=false;
  bool _educationProgramsLoading=false;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSubOfTeacher();
    _get_educationType();
    _get_educationLevels();
    _getCountry();

  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'انشاء لايف',
        child:
        ListView(
          shrinkWrap: true,
          children: [
            Text('اسم اللايف', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            CustomTextField(controller: _liveNameController, hintText: 'اسم المجموعة', input: TextInputType.text,),
            // const SizedBox(height: 5,),
            // Text('اسم المدرس ', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            // CreateGroupField(controller: _teacherNameController, hintText: 'اسم المدرس '),

            const SizedBox(height: 5,),

            Text('اسم المادة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            _teacherLoading?const Center(child: CircularProgressIndicator()):
            CustomDropDown(_sub, changeSubject, subject, 'المادة'),

            const SizedBox(height: 5,),

            Text('نوع التعليم', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            _type_loading?const Center(child: CircularProgressIndicator()):
            CustomDropDown(_educationTypes, changeEducationType, educationType, 'نوع التعليم'),

            const SizedBox(height: 5,),

            Text('نوع المنهج', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            _educationProgramsLoading?const Center(child: CircularProgressIndicator())
                :CustomDropDown(_educationPrograms, change_educationPrograms, curriculumType, 'نوع المنهج'),

            const SizedBox(height: 5,),

            Text('المرحلة الدراسية', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            _level_loading ?const Center(child: CircularProgressIndicator()):
            CustomDropDown(_educationLevels, selectLevel,educationLevel, 'المرحلة الدراسية'),

            const SizedBox(height: 8,),

            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: days.length,
                separatorBuilder: (context, index)=> const SizedBox(height: 10,),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: CustomDropDown(
                            days[index]['days'], (val){
                          days[index]['selectedDay'] = val;
                          setState(() {

                          });
                        }, days[index]['selectedDay'], 'الايام'),
                      ),
                      const SizedBox(width: 8,),
                      Text('من', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                      const SizedBox(width: 5,),
                      InkWell(
                        onTap: ()async{
                          final time = await selectTime();
                          if(time != null) {
                            days[index]['fromTime'] = GlobalMethods().formatTimeFromTime(time);
                          }
                          setState(() {});

                        },
                        child: buildChip(days[index]['fromTime']??'  '),
                      ),
                      const SizedBox(width: 5,),
                      Text('الى', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                      const SizedBox(width: 8,),
                      InkWell(
                        onTap: ()async{
                          final time = await selectTime();
                          if(time != null) {
                            days[index]['toTime'] = GlobalMethods().formatTimeFromTime(time);
                          }
                          setState(() {});
                        },
                        child: buildChip(days[index]['toTime']??'  '),
                      ),
                      const SizedBox(height: 10,),
                      if(index == days.length - 1)
                        InkWell(
                            onTap: ()
                            {
                              days.add( {'days':
                              [ CustomModel(Id: 1, Name: 'السيت', NameEN: 'Saturday'),
                                CustomModel(Id: 2, Name: 'الاحد', NameEN: 'Sunday'),
                                CustomModel(Id: 3, Name: 'الاثنين', NameEN: 'Monday'),
                                CustomModel(Id: 4, Name: 'الثلاثاء', NameEN: 'Tuesday'),
                                CustomModel(Id: 5, Name: 'الاربعاء', NameEN: 'Wednesday'),
                                CustomModel(Id: 6, Name: 'الخميس', NameEN: 'Thursday'),
                                CustomModel(Id: 7, Name: 'الجمعة', NameEN: 'Friday'),],
                                'selectedDay': null,
                                'fromTime': null,
                                'toTime': null,
                              });
                              setState(() {});
                            },
                            child: const Icon(Icons.add_circle_sharp,
                              color: AppColors.primaryColor, size: 40,))
                    ],
                  );
                }
            ),

            const SizedBox(height: 8,),
            Text('السعر', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            _currency_loading?const Center(child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ))
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
                        _selectedCurrencies[index].value= value==null ? 0.0 : double.parse(value);
                        setState(() {

                        });
                      },input:  TextInputType.number,),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20,),
            Builder(
                builder: (context) {
                  return  _Loading ? Center(child: CircularProgressIndicator())
                      :CustomElevatedButton(title: 'انشاء لايف', function:(){});
                }
            ),
            const SizedBox(height: 15,),

          ],
        ),
      ),
    );
  }

  Chip buildChip(String title) {
    return Chip(
      // padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(side: BorderSide(color: AppColors.borderColor)),
      backgroundColor: Colors.white,
      label: Text(title, style: Theme.of(context).textTheme.bodySmall),
    );
  }

  Widget buildDateWidget(BuildContext context) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(' تاريخ البدء ${GlobalMethods().dateFormat(_dateTime)}', style: Theme
                .of(context)
                .textTheme
                .titleMedium, textAlign: TextAlign.center,),
            IconButton(onPressed: () {
              showDatePicker(
                  context: context,
                  initialDate: _dateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime
                      .now()
                      .year + 1)).then((value) {
                setState(() { if(value != null) _dateTime = value;}
                );
              });
            }, icon: Icon(Icons.date_range))
          ],
        ),
      );

  changeSubject(val){
    subject = val;
    setState(() {

    });
  }
  selectDays(val){
    days = val;
    setState(() {

    });
  }

  selectLevel(val){
    educationLevel=val;
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

  changeEducationType(val){
    educationType=val;
    _getEducationPrograms();
    curriculumType=null;
    setState(() {

    });
  }

  change_educationPrograms(val){
    curriculumType=val;
    setState(() {

    });
  }

  chooseTeacher(SuggestedTeacher suggestedTeacher){
    // teacher = suggestedTeacher.name;
    setState(() {});
  }

  Future<TimeOfDay?> selectTime() async{
    final newTime = await showTimePicker(context: context,
        initialTime: TimeOfDay(hour: DateTime.now().hour,
            minute: DateTime.now().minute));

    return newTime;

  }

  Future<File?> pickFile() async {
    final picked = await FilePicker.platform.pickFiles();
    if (picked != null) {
      return File(picked.files.single.path!);
    }
  }



  void _addGroup()  async{

    setState(() {
      _Loading=true;
    });

    List<Map<String, dynamic>>  _GroupPrices=[];

    for(int i=0;i<_selectedCurrencies.length;i++){
      _GroupPrices.add({
        'CurrencyId':_selectedCurrencies[i].Id,
        'Price':_selectedCurrencies[i].value.toInt()
      });
    }

    List<Map<String, dynamic>> _GroupCountries=[];
    for(int i=0;i<countries.length;i++){
      _GroupCountries.add( {'CountryId':countries[i].Id });
    }

    List<Map<String, dynamic>> _daysAndTime=[];

    for(int i=0;i<days.length;i++){
      _daysAndTime.add({
        'Day':days[i]['selectedDay'].Id,
        'FromTime': days[i]['fromTime'],
        'ToTime': days[i]['toTime']
      });

    }

    Map data={
      "Id": 0,
      "Title": _liveNameController.text,
      "SubjectId": subject!.Id,
      "GradeId": educationLevel!.Id,
      "Price": 0,
      "EducationTypeId": educationType!.Id,
      "StudentsCount": _studentsNumController.text,
      "SessionsCount": _classesNumController.text,
      "Period": period!.Id,
      "GroupType": typeGroup==TypeGroup.single ? 1:2,
      // "StartedAt": "2023-07-22T12:10:15.551Z",
      "StartedAt": _dateTime.toString(),
      "GroupAppointments": _daysAndTime,
      "GroupCountries": _GroupCountries,
      "GroupPrices": _GroupPrices
    };
    print('data   '+data.toString());
    try {
      var response = await TeacherCall().postData(json.encode(data), "/api/Group/AddGroup", 1);
      var body = json.decode(response.body);
      print ('body '+body.toString());

      if (response != null && response.statusCode == 200) {
        if(body['Success']) {

          ShowMyDialog.showMsg("تم إنشاء المجموعة بنجاح");

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
      print(' add Group  ee '+e.toString());
    }
  }

  void _getSubOfTeacher()  async{
    setState(() {
      _teacherLoading=true;
    });
    Map<String,dynamic> data={
      'teacherId':null
    };
    try {
      var response = await CallApi().getWithBody(data, "/api/Teacher/GetTeacherSubjects", 1);
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _sub= body.map((e) => CustomModel.fromJson(e)).toList();
        setState(() {
          _teacherLoading=false;
        });
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      setState(() {
        _teacherLoading=false;
      });
    }
    catch(e){
      setState(() {
        _teacherLoading=false;
      });
      print(' teacher  ee '+e.toString());
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

  void _getEducationPrograms() async{

    setState(() {
      _educationProgramsLoading=true;
    });
    Map <String, dynamic>data={
      "educationTypeId" :educationType!.Id.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,
          "/api/EducationProgram/GetEducationPrograms",1);
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

  void _get_educationLevels() async{

    setState(() {
      _level_loading=true;
    });


    try {
      var response = await CallApi().getData("/api/Teacher/GetTeacherGrades",1);

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
        print(_selectedCurrencies[0].Name);
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