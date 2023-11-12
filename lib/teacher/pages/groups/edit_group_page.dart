import 'dart:convert';
import 'dart:io';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/teacher/curency.dart';
import 'package:eplatform/widgets/text_fields/edit_change_value_field.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../api/api.dart';
import '../../../api/teacherCall.dart';
import '../../../core/utility/app_colors.dart';
import '../../../model/customModel.dart';
import '../../../pages/components/custom_dotted_border.dart';
import '../../../session/userSession.dart';
import '../../../widgets/date_widget.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/drop_downs/custom_dropdown.dart';
import '../../../widgets/drop_downs/multiselect_dropdown.dart';
import '../../../widgets/text_fields/change_value_field.dart';
import 'package:http/http.dart' as http;
import '../../../widgets/text_fields/custom_text_field.dart';
import '../create_group/components/create_group_field.dart';
import '../create_group/components/multiselect_dropdown.dart';
import '../../../model/mainmodel.dart';
import 'groupPrices.dart';

class EditGroupPage extends StatefulWidget {
  EditGroupPage({required this.model,required this.groupId, Key? key}) : super(key: key);
  MainModel model;
  int groupId;
  @override
  State<EditGroupPage> createState() => _EditGroupPageState();
}

class _EditGroupPageState extends State<EditGroupPage> {

  DateTime  ?  _dateTime ;
  DateTime _endDateTime = DateTime.now();

  CustomModel? subject;
  CustomModel? educationType;
  CustomModel? educationLevel;
  CustomModel? curriculumType;
  CustomModel? period;

  List<CustomModel> countries=[];

  List<Map<String, dynamic>> days=[];

  List<CustomModel?> selectedEducationTypeList = [null];
  List<List<CustomModel>?> curriculumTypeList = [null];
  List<CustomModel?> selectedCurriculumTypeList = [null];
  List<List<CustomModel>?> gradesList = [null];
  List<CustomModel?> selectedGradesList = [null];
  List<List<CustomModel>?> subjectList = [null];
  List<CustomModel?> selectedSubjectList = [null];

  List<CustomModel> _sub=[];
  List<CustomModel> _educationLevels=[];



   List <CustomModel>_days=[
       CustomModel(Id: 1, Name: 'السبت', NameEN: 'Saturday'),
       CustomModel(Id: 2, Name: 'الاحد', NameEN: 'Sunday'),
       CustomModel(Id: 3, Name: 'الاثنين', NameEN: 'Monday'),
       CustomModel(Id: 4, Name: 'الثلاثاء', NameEN: 'Tuesday'),
       CustomModel(Id: 5, Name: 'الاربعاء', NameEN: 'Wednesday'),
       CustomModel(Id: 6, Name: 'الخميس', NameEN: 'Thursday'),
       CustomModel(Id: 7, Name: 'الجمعة', NameEN: 'Friday'),];

  TypeGroup typeGroup = TypeGroup.group;
  TypeTime typeTime = TypeTime.morning;

  bool isNextPage = false;

  List<CustomModel> subscriptionPeriodList = [
    CustomModel(Id: 1,Name: 'حصة', NameEN: ''),
    CustomModel(Id: 2,Name: 'شهر', NameEN: ''),
    CustomModel(Id: 3,Name: 'ترم', NameEN: ''),
    CustomModel(Id: 4,Name: 'سنة', NameEN: ''),
  ];

  File? _video;

  String? fromTime;
  String? toTime;

  final _groupNameController = TextEditingController();
  final _teacherNameController = TextEditingController();
  final _studentsNumController = TextEditingController();
  final _classesNumController = TextEditingController();
  final _periodController = TextEditingController();

  bool _Loading=false;

  bool _dataLoading=false;
  bool _currency_loading=false;
  bool _subLoading=false;
  bool _level_loading=false;

  List _GroupPrices=[];

  List<SelectedCurrency>_selectedCurrencies=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.model.fetchTeacherEducationType();
    widget.model.fetchTeacherEducationCountries();

    _getgroupData();

  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return  ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
           body: CustomStack(
            pageTitle: 'تعديل مجموعة',
            child:
                _dataLoading?Center(child: CircularProgressIndicator()):
            ListView(
              shrinkWrap: true,
              children: [
                Text('اسم المجموعة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                CustomTextField(controller: _groupNameController, hintText: 'اسم المجموعة',input: TextInputType.text, ),
                // const SizedBox(height: 5,),
                // Text('اسم المدرس ', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                // CreateGroupField(controller: _teacherNameController, hintText: 'اسم المدرس '),

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
                                      child: CustomDropDown(model.allCustomEducationType, (val){
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

                model.customCountry_loading?const Center(child: CircularProgressIndicator()):
                Text('دول العرض', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                CustomMultiSelectDropDown(model.allSustomTeacherCountries, countries, selectCountries,
                     'دول العرض'),

                const SizedBox(height: 8,),

                Text('المدة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                CustomDropDown(subscriptionPeriodList, selectPeriod, period, 'المدة'),

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
                Text('نوع المجموعة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: RadioListTile(
                            title: const Text('فرد'),
                            value: TypeTime.night,
                            groupValue: typeTime,
                            onChanged: (value) {
                              typeTime = value!;
                              setState(() {});
                            })),
                    Expanded(
                        child: RadioListTile(
                            title: const Text('مجموعة'),
                            value: TypeTime.morning,
                            groupValue: typeTime,
                            onChanged: (value) {
                              typeTime = value!;
                              setState(() {});
                            })),
                  ],
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
                     itemCount: _GroupPrices.length,
                     separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                      ),
                     itemBuilder: (context, index)=> Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                       Text(_GroupPrices[index]['CurrencyName'],
                        style: Theme.of(context).textTheme.bodySmall,),
                        SizedBox(
                         width: 100,
                         child: EditChangeValueField
                           ( hintText: 'السعر',
                          onChange: (value){
                            //   currencies[index] = value;
                            _GroupPrices[index]['Price']= value==null ? 0.0 : double.parse(value);
                            setState(() {

                            });
                          } ,value: _GroupPrices[index]['Price'] ==null?0.0.toString():
                           _GroupPrices[index]['Price'].toString()
                           ,),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(child: Column(
                      children: [
                        Text('عدد الطلاب', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                        CreateGroupField(controller: _studentsNumController, hintText: '',input: TextInputType.number,),
                      ],
                    ),),
                    const SizedBox(width: 8,),
                    Expanded(child: Column(
                      children: [
                        Text('عدد الحصص', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                        CreateGroupField(controller: _classesNumController, hintText: '',input: TextInputType.number,),
                      ],
                    ),),
                    const SizedBox(width: 8,),
                    /*  Expanded(child: Column(
                      children: [
                        Text('المدة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                        CreateGroupField(controller: _periodController, hintText: '',input: TextInputType.number,),
                      ],
                    ),), */
                  ],
                ),

                const SizedBox(height: 8,),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  width: 130,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async{
                          final picked = await pickFile();

                          if(picked == null) return;
                          _video = picked;
                        },
                        child: CustomDottedBorder(
                          child: Column(
                            children: [
                              Image.asset('assets/images/promo.png'),
                              const Text('رفع فيديو او ملف', style: TextStyle(fontSize: 14),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8,),
                buildDateWidget(context),
                const SizedBox(height: 8,),
                DateWidget( title: ' تاريخ الانتهاء ${GlobalMethods().dateFormat(_endDateTime)}', onSelectDate: (){
                  showDatePicker(
                      context: context,
                      initialDate: _endDateTime,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime
                          .now()
                          .year + 1)).then((value) {
                    setState(() { if(value != null) _endDateTime = value;}
                    );
                  });
                }),

                const SizedBox(height: 20,),
                Builder(
                    builder: (context) {
                      return  _Loading ? Center(child: CircularProgressIndicator())
                          :CustomElevatedButton(title: 'تعديل المجموعة', function:// _addGroup _
                      _updateGroup );
                    }
                ),
                const SizedBox(height: 15,),

              ],
            ),
          ),
        );
      }
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
            Text(' تاريخ البدء ${
                GlobalMethods().dateFormat(_dateTime== null ? DateTime.now() :_dateTime! )}', style: Theme
                .of(context)
                .textTheme
                .titleMedium, textAlign: TextAlign.center,),
            IconButton(onPressed: () {
              showDatePicker(
                  context: context,
                  initialDate: _dateTime == null ? DateTime.now() :_dateTime!,
                  firstDate:_dateTime == null ? DateTime.now() :_dateTime!,
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

  changeSubject(val, int index){
    // curriculumType=val;
    selectedSubjectList[index] = val;
    setState(() {

    });
  }
  selectDays(val){
    days = val;
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
    _getCurrencies();
    setState(() {

    });

  }

  changeEducationType(val, int index) async{
    educationType=val;
    selectedEducationTypeList[index] = val;
    await widget.model.fetchTeacherEducationPrograms(educationType!);
    curriculumTypeList[index] = widget.model.allCustomEducationPrograms;

    if(curriculumTypeList[index]!.isEmpty){
      await _get_educationLevels(selectedEducationTypeList[index]!.Id, null);
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

  changeEducationLevel(val, int index) async{

    selectedGradesList[index] = val;
    await _getSubOfTeacher(selectedEducationTypeList[index]!.Id, selectedGradesList[index]!.Id, selectedCurriculumTypeList[index]?.Id);
    subjectList[index] = _sub;
    setState(() {
    });

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

  void _updateGroup()  async{

    setState(() {
      _Loading=true;
    });



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
      "Id": widget.groupId.toString(),
      "Title": _groupNameController.text,
      // "SubjectId": subject!.Id.toString(),
      // "GradeId": educationLevel!.Id.toString(),
      // "EducationTypeId": educationType!.Id.toString(),
      // "ProgramTypeId": curriculumType!.Id.toString(),
      "StudentsCount": _studentsNumController.text,
      "SessionsCount": _classesNumController.text,
      "Period": period!.Id.toString(),
      "GroupType": typeGroup==TypeGroup.single ? 1.toString():2.toString(),
      "StartedAt": _dateTime.toString(),
      "EndedAt": _endDateTime.toString(),
      "Appointments": jsonEncode(_daysAndTime),
      "Countries": jsonEncode(_GroupCountries),
      "Prices": jsonEncode(_GroupPrices),
      ...types
    };
    print('data   '+data.toString());
    List<Map> files= [
      {'title': 'IntroVideo', 'file': _video},
      // {'title': 'Attachments', 'file': attachments[0]},
    ];
    try {
      StreamedResponse response = await CallApi().putJsonAndFile(data, files, "/api/Group/UpdateGroup", 1);

      if (response.statusCode == 200) {


          ShowMyDialog.showMsg("تم تعديل بيانات المجموعة بنجاح");

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
      print(' update Group  ee '+e.toString());
    }
  }

  void _getgroupData() async{

    setState(() {
      _dataLoading=true;
    });
     Map <String,dynamic>data={
       'groupId':widget.groupId.toString()
     };

    try {
      var response = await CallApi().getWithBody(data,"/api/Group/GetGroupById",1);

      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {

           _groupNameController.text=body['Title'];
           typeGroup =body['GroupType']==1?TypeGroup.single:TypeGroup.group ;

        subject=new CustomModel(Id: body['SubjectId'], Name: body['SubjectName'], NameEN: '');
        curriculumType=new CustomModel(Id: body['ProgramTypeId'], Name: body['ProgramTypeName'], NameEN: '');

        educationType=new CustomModel(Id: body['EducationTypeId'],
            Name: body['EducationTypeName'], NameEN: '');

        widget.model.fetchTeacherEducationPrograms(educationType!);
        educationLevel=new CustomModel(Id: body['GradeId'],
            Name: body['GradeName'], NameEN: '');

        _studentsNumController.text=body['StudentsCount'].toString();
        _classesNumController.text=body['SessionsCount'].toString();
        _dateTime= new DateFormat('yy-MM-dd').parse(body['StartedAt']);

        period=new CustomModel(Id: body['Period'],
            Name:subscriptionPeriodList[ subscriptionPeriodList.indexWhere((element) =>
            element.Id==body['Period'])].Name,
            NameEN: '');

           List  GroupCountries =body['GroupCountries'];

            for(int i=0;i<GroupCountries.length;i++){
              setState(() {

                countries.add(new CustomModel(Id: GroupCountries[i]['CountryId'],
                    Name:widget.model.allSustomTeacherCountries[
                    widget.model.allSustomTeacherCountries.indexWhere((element) =>
                    element.Id==GroupCountries[i]['CountryId'])].Name, NameEN: ''));
              });

           }
            setState(() {});


            List GroupAppointments=body['GroupAppointments'];

             for (int i=0 ;i<GroupAppointments.length ;i++){
              days.add( {'days':
              [ CustomModel(Id: 1, Name: 'السبت', NameEN: 'Saturday'),
                CustomModel(Id: 2, Name: 'الاحد', NameEN: 'Sunday'),
                CustomModel(Id: 3, Name: 'الاثنين', NameEN: 'Monday'),
                CustomModel(Id: 4, Name: 'الثلاثاء', NameEN: 'Tuesday'),
                CustomModel(Id: 5, Name: 'الاربعاء', NameEN: 'Wednesday'),
                CustomModel(Id: 6, Name: 'الخميس', NameEN: 'Thursday'),
                CustomModel(Id: 7, Name: 'الجمعة', NameEN: 'Friday'),],
                   'selectedDay':
                    new CustomModel(Id:  GroupAppointments[i]['Day'],
                    Name: _days[ _days.indexWhere((element) =>
                    element.Id==GroupAppointments[i]['Day'])].Name, NameEN: ''),

                   'fromTime': GlobalMethods().formatTimeFromString(GroupAppointments[i]['FromTime']),
                   'toTime': GlobalMethods().formatTimeFromString(GroupAppointments[i]['ToTime']),
              });
            }
             _GroupPrices=body['GroupPrices'];
           setState(() {
           });


      }
    }
    catch(e){
      print (' show ee '+e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
    }
    setState(() {
      _dataLoading=false;
    });
  }

  void _getCurrencies() async{

    setState(() {
      _currency_loading=true;
      _GroupPrices=[];
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
          _GroupPrices.add({
              'CurrencyId': _selectedCurrencies[i].Id,
              // 'CurrencyName': _selectedCurrencies[i].Name,
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

  chooseTeacher(SuggestedTeacher suggestedTeacher){
    // teacher = suggestedTeacher.name;
    setState(() {});
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