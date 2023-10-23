import 'dart:convert';
import 'dart:io';
import 'package:eplatform/api/api.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../api/teacherCall.dart';
import '../../../core/utility/app_colors.dart';
import '../../../model/customModel.dart';
import '../../../model/mainmodel.dart';
import '../../../pages/components/custom_dotted_border.dart';
import '../../../session/userSession.dart';
import '../../../widgets/date_widget.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/text_fields/change_value_field.dart';
import 'components/create_group_dropDown.dart';
import 'components/create_group_field.dart';
import 'components/multiselect_dropdown.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class CreateGroupPage extends StatefulWidget {
  CreateGroupPage({ required this.model, Key? key}) : super(key: key);

  MainModel model;

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {

  DateTime _dateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now();
  DateTime _classAt = DateTime.now();

  CustomModel? subject;
  CustomModel? educationType;
  List<CustomModel?> selectedEducationTypeList = [null];
  CustomModel? educationLevel;
  CustomModel? curriculumType;
  List<List<CustomModel>?> curriculumTypeList = [null];
  List<CustomModel?> selectedCurriculumTypeList = [null];
  CustomModel? period;

  List<CustomModel> countries=[];

  String? videoDuration;

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

  List attachments = [null];


  TypeGroup typeGroup = TypeGroup.group;
  TypeTime typeTime = TypeTime.morning;

  bool isNextPage = false;
  int _insertedGroupId=0;

  List<CustomModel> subscriptionPeriodList = [
    CustomModel(Id: 1,Name: 'حصة', NameEN: ''),
    CustomModel(Id: 2,Name: 'شهر', NameEN: ''),
    CustomModel(Id: 3,Name: 'ترم', NameEN: ''),
    CustomModel(Id: 4,Name: 'سنة', NameEN: ''),
  ];

  File? _video;
  File? _classVideo;
  String? classFromTime;
  String? classToTime;

  final _groupNameController = TextEditingController();
  final _groupDescriptionController = TextEditingController();
  final _studentsNumController = TextEditingController();
  final _classesNumController = TextEditingController();
  final _classNameController = TextEditingController();
  final _classDescriptionController = TextEditingController();
  bool _Loading=false;
  bool _class_Loading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.fetchSubOfTeacher1();
    widget.model.fetchTeacherEducationType();
    widget.model.fetchTeacherEducationLevels();
    widget.model.fetchTeacherEducationCountries();

  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return  ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
            body: CustomStack(
              pageTitle: 'انشاء مجموعة',
              child: isNextPage ?
              ListView(
                shrinkWrap: true,
                children: [
                  Text('عنوان الحصة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  CreateGroupField(controller: _classNameController, hintText: 'عنوان الحصة', input: TextInputType.text,),

                  const SizedBox(height: 8,),
                  Text('وصف الحصة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  CreateGroupField(controller: _classDescriptionController, hintText: 'وصف الحصة', input: TextInputType.text,),

                  const SizedBox(height: 8,),
                  DateWidget( title: ' تاريخ البدء ${GlobalMethods().dateFormat(_classAt)}',onSelectDate: (){
                    showDatePicker(
                        context: context,
                        initialDate: _classAt,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime
                            .now()
                            .year + 1)).then((value) {
                      setState(() { if(value != null) _classAt = value;}
                      );
                    });
                  }),

                  const SizedBox(width: 8,),
                  Row(
                    children: [
                      Text('من', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                      const SizedBox(width: 5,),
                      InkWell(
                        onTap: ()async{
                          final time = await selectTime(context);
                          if(time != null) {
                            classFromTime = GlobalMethods().formatTimeFromTime(time);
                          }
                          setState(() {});

                        },
                        child: buildChip(context, classFromTime??'  '),
                      ),
                      const SizedBox(width: 5,),
                      Text('الى', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                      const SizedBox(width: 8,),
                      InkWell(
                        onTap: ()async{
                          final time = await selectTime(context);
                          if(time != null) {
                            classToTime = GlobalMethods().formatTimeFromTime(time);
                          }
                          setState(() {});
                        },
                        child: buildChip(context, classToTime??'  '),
                      ),

                    ],
                  ),

                  const SizedBox(height: 8,),
                  Text('رفع فيديو', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  InkWell(
                    onTap: () async{
                      final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
                      if(picked == null) return;

                      final controller = VideoPlayerController.file(File(picked.path));
                      controller.initialize().then((_) {
                        // Get the duration of the video.
                        videoDuration = controller.value.duration.inMinutes.toString().padLeft(2, '0') + ":" + controller.value.duration.inSeconds.toString().padLeft(2, '0');
                      });

                      _classVideo = File(picked.path);
                      setState(() {});
                    },
                    child: CustomDottedBorder(
                      child: Column(
                        children: [
                          Image.asset('assets/images/promo.png'),
                          Text(_classVideo != null ? basename(_classVideo!.path) : 'رفع فيديو', style: const TextStyle(fontSize: 14),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Text('مرفقات', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: attachments.length,
                    itemBuilder: (context, index)=>
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              width: 130,
                              child: InkWell(
                                onTap: () async{
                                  final picked = await pickFile();
                                  if(picked == null) return;
                                  attachments[index] = picked;
                                  setState(() {});
                                },
                                child: CustomDottedBorder(
                                  child: Column(
                                    children: [
                                      Image.asset('assets/images/promo.png'),
                                      Text(attachments[index] != null ? basename(attachments[index].path) : 'رفع ملف', style: const TextStyle(fontSize: 14),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15,),
                            if(index == attachments.length - 1)
                              InkWell(
                                  onTap: (){
                                    attachments.add(null);
                                    setState(() {});
                                  },

                                  child: const Icon(Icons.add_circle_sharp, color: AppColors.primaryColor, size: 60,))
                          ],
                        )
                    ,
                  ),
                  const SizedBox(height: 20,),
                  _class_Loading?const Center(child: CircularProgressIndicator()):
                  CustomElevatedButton(title: 'ارسال',
                      function:_addGroupClass
                  )
                ],
              )
                  : ListView(
                shrinkWrap: true,
                children: [
                  Text('اسم المجموعة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  CreateGroupField(controller: _groupNameController, hintText: 'اسم المجموعة', input: TextInputType.text,),
                  // const SizedBox(height: 5,),
                  // Text('اسم المدرس ', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  // CreateGroupField(controller: _teacherNameController, hintText: 'اسم المدرس '),

                  const SizedBox(height: 5,),

                  Text('وصف المجموعة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  CreateGroupField(controller: _groupDescriptionController, hintText: 'وصف المجموعة', input: TextInputType.text,),
                  const SizedBox(height: 5,),

                  Text('اسم المادة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  model.customSubOfTeacherLoading?const Center(child: CircularProgressIndicator()):
                  CreateGroupDropDown(model.allCustomSubOfTeacher, changeSubject, subject, 'المادة'),

                  // const SizedBox(height: 5,),
                  //
                  // Text('نوع التعليم', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  // model.customEducationType?const Center(child: CircularProgressIndicator()):
                  // CreateGroupDropDown(model.allCustomEducationType, changeEducationType, educationType, 'نوع التعليم'),
                  //
                  // const SizedBox(height: 5,),
                  //
                  // Text('نوع المنهج', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  //  model.customEducationProgramsLoading?const Center(child: CircularProgressIndicator())
                  //     :CreateGroupDropDown(model.allCustomEducationPrograms,
                  //     change_educationPrograms, curriculumType, 'نوع المنهج'),

                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('نوع التعليم', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                      Text('نوع المنهج', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),

                    ],
                  ),

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
                                  model.customEducationType?const Center(child: CircularProgressIndicator()):
                                  CreateGroupDropDown(model.allCustomEducationType, (val){
                                    changeEducationType(val, index);
                                  }, selectedEducationTypeList[index], 'نوع التعليم'),

                                ],
                              ),
                            ),

                            const SizedBox(width: 5,),
                            Expanded(
                              child: Column(
                                children: [
                                  CreateGroupDropDown(curriculumTypeList[index]??[],
                                          (val){
                                        change_educationPrograms(val, index);
                                      }, selectedCurriculumTypeList[index], 'نوع المنهج'),
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
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.add_circle_sharp,
                                    color: AppColors.primaryColor, size: 40,))
                          ],
                        );
                      }
                  ),

                  const SizedBox(height: 5,),

                  Text('المرحلة الدراسية', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  model.customLevel_loading ?const Center(child: CircularProgressIndicator()):
                  CreateGroupDropDown(model.allCustomEducationLevels,
                      selectLevel,educationLevel, 'المرحلة الدراسية'),

                  const SizedBox(height: 5,),

                  model.customCountry_loading?const Center(child: CircularProgressIndicator()):
                  Text('دول العرض', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  CreateGroupMultiSelectDropDown(model.allSustomTeacherCountries, selectCountries,countries, 'دول العرض'),

                  const SizedBox(height: 8,),

                  Text('المدة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  CreateGroupDropDown(subscriptionPeriodList, selectPeriod, period, 'المدة'),

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
                              child: CreateGroupDropDown(
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
                                final time = await selectTime(context);
                                if(time != null) {
                                  days[index]['fromTime'] = GlobalMethods().formatTimeFromTime(time);
                                }
                                setState(() {});

                              },
                              child: buildChip(context, days[index]['fromTime']??'  '),
                            ),
                            const SizedBox(width: 5,),
                            Text('الى', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                            const SizedBox(width: 8,),
                            InkWell(
                              onTap: ()async{
                                final time = await selectTime(context);
                                if(time != null) {
                                  days[index]['toTime'] = GlobalMethods().formatTimeFromTime(time);
                                }
                                setState(() {});
                              },
                              child: buildChip(context, days[index]['toTime']??'  '),
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
                  model.customCurrency_loading?const Center(child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(),
                  ))
                      :ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: model.allCustomSelectedCurrencies.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (context, index)=> Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(model.allCustomSelectedCurrencies[index].Name, style: Theme.of(context).textTheme.bodySmall,),
                        SizedBox(
                          width: 100,
                          child: ChangeValueField(hintText: 'السعر',
                            onChange: (value){
                              //   currencies[index] = value;
                              model.allCustomSelectedCurrencies[index].value= value==null ? 0.0
                                  : double.parse(value);
                              setState(() {

                              });
                            },input:  TextInputType.number,
                          ),
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
                            final picked = await pickVideo();
                            if(picked == null) return;
                            _video = picked;
                            setState(() {});
                          },
                          child: CustomDottedBorder(
                            child: Column(
                              children: [
                                Image.asset('assets/images/promo.png'),
                                Text(_video != null ? basename(_video!.path) : 'رفع فيديو او ملف', style: TextStyle(fontSize: 14),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8,),
                  DateWidget( title: ' تاريخ البدء ${GlobalMethods().dateFormat(_dateTime)}',onSelectDate: (){
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
                  }),
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
                            :CustomElevatedButton(title: 'انشاء مجموعة', function:// _addGroup _
                        //_addGroup
                        // _lastChance
                        // _POSTDio
                        _addGroup
                        );
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

  Chip buildChip(context, String title) {
    return Chip(
      // padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(side: BorderSide(color: AppColors.borderColor)),
      backgroundColor: Colors.white,
      label: Text(title, style: Theme.of(context).textTheme.bodySmall),
    );
  }

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


  selectPeriod(val){
    period=val;
    setState(() {

    });
  }

  selectCountries(val){
    countries = val;
    widget.model.fetchTeacherCurrencies(countries);
    setState(() {

    });

  }

  changeEducationType(val, int index) async{
    educationType=val;
    selectedEducationTypeList[index] = val;
    await widget.model.fetchTeacherEducationPrograms(educationType!);
    curriculumTypeList[index] = widget.model.allCustomEducationPrograms;
    curriculumType=null;
    setState(() {

    });
  }
  change_educationPrograms(val, int index){
    curriculumType=val;
    selectedCurriculumTypeList[index] = val;
    setState(() {

    });
  }

  selectLevel(val){
    educationLevel=val;
    setState(() {

    });
  }



  chooseTeacher(SuggestedTeacher suggestedTeacher){
    // teacher = suggestedTeacher.name;
    setState(() {});
  }

  Future<TimeOfDay?> selectTime(context) async{
    final newTime = await showTimePicker(context: context,
        initialTime: TimeOfDay(hour: DateTime.now().hour,
            minute: DateTime.now().minute));

    return newTime;

  }

  Future<File?> pickVideo() async {
    final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      return File(picked.path);
    }
  }

  Future<File?> pickFile() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (picked != null) {
      return File(picked.files.single.path!);
    }
  }

  void _addGroup()  async{

    setState(() {
      _Loading=true;
    });

    List<Map<String, dynamic>>  _GroupPrices=[];

    for(int i=0;i<widget.model.allCustomSelectedCurrencies.length;i++){
      _GroupPrices.add({
        'CurrencyId':widget.model.allCustomSelectedCurrencies[i].Id.toString(),
        'Price':widget.model.allCustomSelectedCurrencies[i].value.toInt()
      });
    }

    List<Map<String, dynamic>> _GroupCountries=[];
    for(int i=0;i<countries.length;i++){
      _GroupCountries.add( {'CountryId':countries[i].Id.toString() });
    }

    List<Map<String, dynamic>> _Appointments=[];

    for(int i=0;i<days.length;i++){
      _Appointments.add({
        "Day":days[i]['selectedDay'].Id.toString(),
        "FromTime":days[i]['fromTime'].toString(),
        "ToTime": days[i]['toTime'].toString()
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
    }

    try{
      Map <String,String> data={
        "Title": _groupNameController.text,
        "SubjectId": subject!.Id.toString(),
        "GradeId": educationLevel!.Id.toString(),
        "EducationTypeId": educationType!.Id.toString(),
        "ProgramTypeId": curriculumType!.Id.toString(),
        "StudentsCount": _studentsNumController.text,
        "SessionsCount": _classesNumController.text,
        "Period": period!.Id.toString(),
        "GroupType": typeGroup==TypeGroup.single ? 1.toString():2.toString(),
        "StartedAt": _dateTime.toString(),
        "EndedAt": _endDateTime.toString(),
        "Appointments": jsonEncode(_Appointments),
        'Description': _groupDescriptionController.text,
        'Countries': _GroupCountries.toString(),
        'Prices': _GroupPrices.toString(),
        'Id': '0',
        ...types
      };
      print('data   '+data.toString());

      StreamedResponse response = await CallApi().postDataANDFile1(data,_video, "/api/Group/AddGroup", 1);

      var res = await http.Response.fromStream(response);

      getIdFromResponse(res);
      // print(getIdFromResponse(res));
      print(res.headers);

      if (response.statusCode == 200) {
        ShowMyDialog.showMsg("تم إنشاء المجموعة بنجاح");

        final id = await getIdFromResponse(res);
        setState(() {
          isNextPage = true;
          _insertedGroupId=int.parse(id!);
        });
      }
      else {
        print(response.toString());
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
      print(' add Group  ee '+e.toString());
      ShowMyDialog.showMsg(e.toString());
    }
  }


  void _addGroupClass()  async{
    setState(() {
      _class_Loading=true;
    });


    List<Map<String, dynamic>> AttachmentUrl  =[];
    for(int i=0;i<attachments.length;i++){
      AttachmentUrl.add( {'AttachmentUrl':attachments[i]});
    }

    Map<String, String> data={
      "Id": 0.toString(),
      "Title": _classNameController.text,
      "Description": _classDescriptionController.text,
      "Duration": videoDuration?? '',
      "ClassAt": _classAt.toString(),
      "FromTime": classFromTime.toString(),
      "ToTime": classToTime.toString(),
      "Attachments": '[]',
    };
    //  print(' class data   '+data.toString());

    List<Map> filess= [
      {'title': 'VideoUrl', 'file': _classVideo},
      // {'title': 'Attachments', 'file': attachments[0]},
    ];
    try {
      var response = await CallApi().postJsonAndFile(data, filess,
          "/api/GroupVideo/AddGroupVideo?groupId="+_insertedGroupId.toString(), 1);


      if (response != null && response.statusCode == 200) {

        ShowMyDialog.showMsg("تم إضافة الدرس بنجاح");

      }
      else {
        ShowMyDialog.showMsg(response.reasonPhrase);
      }
      setState(() {
        _class_Loading=false;
      });
    }
    catch(e){
      setState(() {
        _class_Loading=false;
      });
      print(' add Group  ee '+e.toString());
    }
  }

  Future<String?> getIdFromResponse(http.Response response) async {
    final boundary = response.headers['content-type']!.split('boundary=')[1].trim();

    final parts = response.body.split(boundary);
    for (final part in parts) {
      if (part.startsWith('--')) {
        continue;
      }
      final name = part.split('=')[1];
      final remove = name.replaceAll(RegExp(r'\s+'), '').trim();
      if (remove.contains('"Id"')) {

        final id = remove.split('--')[0].substring(4);
        return id;
      }
    }
    return null;
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