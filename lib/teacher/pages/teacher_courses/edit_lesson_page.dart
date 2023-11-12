import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/teacher/pages/create_course/components/create_course_dropDown.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../api/api.dart';
import '../../../api/teacherCall.dart';
import '../../../core/utility/app_colors.dart';
import '../../../model/customModel.dart';
import '../../../model/teacher/curency.dart';
import '../../../model/teacherModels/teacherCourseLessonDetails.dart';
import '../../../pages/components/custom_dotted_border.dart';
import '../../../session/userSession.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/text_fields/change_value_field.dart';
import '../../../widgets/text_fields/edit_change_value_field.dart';
import '../create_course/components/create_course_field.dart';
import 'package:path/path.dart';

class EditLessonPage extends StatefulWidget {
  EditLessonPage(
      {required this.courseLessonId, Key? key, required this.courseId})
      : super(key: key);

  final int courseLessonId;
  final int courseId;

  @override
  State<EditLessonPage> createState() => _EditLessonPageState();
}

class _EditLessonPageState extends State<EditLessonPage> {
  CustomModel? subject;
  CustomModel? day;
  CustomModel? time;
  List<CustomModel> countries = [];

  List _LessonPrices = [];

  String? videoDuration;

  CustomModel? educationType;
  CustomModel? educationLevel;
  CustomModel? curriculumType;

  TypeGroup typeGroup = TypeGroup.group;
  TypeTime typeTime = TypeTime.morning;

  bool isNextPage = false;

  List<CustomModel> _allCountries = [];
  List<CustomModel> _educationTypes = [];
  List<CustomModel> _educationLevels = [];
  List<CustomModel> _educationPrograms = [];
  List<SelectedCurrency> _selectedCurrencies = [];
  List<SelectedCurrency> _selectedLessonCurrencies = [];
  List<CustomModel> _sub = [];

  bool _type_loading = false;
  bool _level_loading = false;
  bool _educationProgramsLoading = false;
  bool _country_loading = false;
  bool _currency_loading = false;
  bool _lesson_Loading = false;
  bool _Loading = false;

  bool _isFree = false;

  List<SubscriptionPeriod> subscriptionPeriodList = [
    SubscriptionPeriod(1, 'سنة'),
    SubscriptionPeriod(2, 'ترم'),
    SubscriptionPeriod(3, 'شهر'),
    SubscriptionPeriod(4, 'حصة'),
  ];

  Map courseFiles = {
    'video': null,
    'file': null,
    'title': null,
    'price': null,
  };

  List attachments = [null];
  List videos = [null];

  final _lessonNameController = TextEditingController();
  final _videoNameController = TextEditingController();
  final _videoDescController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getLessonData();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
          pageTitle: 'تفاصيل الدرس',
          child: _Loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      'اسم الدرس',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.right,
                    ),
                    CreateCourseField(
                        controller: _lessonNameController,
                        hintText: 'اسم الدرس'),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'اسم الفيديو',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.right,
                    ),
                    CreateCourseField(
                        controller: _videoNameController,
                        hintText: 'اسم الفيديو'),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'وصف الفيديو',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.right,
                    ),
                    CreateCourseField(
                        controller: _videoDescController, hintText: 'الوصف'),
                    const SizedBox(
                      height: 8,
                    ),
                    CheckboxListTile(
                      title: Text(
                        "مجاني",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      value: _isFree,
                      onChanged: (newValue) {
                        _isFree = newValue!;
                        setState(() {});
                      },
                      // controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (!_isFree)
                      Text(
                        'سعر الدرس',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.right,
                      ),
                    if (!_isFree)
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _LessonPrices.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _LessonPrices[index]['CurrencyName'],
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            SizedBox(
                              width: 100,
                              child: EditChangeValueField(
                                  hintText: 'السعر',
                                  onChange: (value) {
                                    //   currencies[index] = value;
                                    _LessonPrices[index]['Price'] =
                                        value == null
                                            ? 0.0
                                            : double.parse(value);
                                    setState(() {});
                                  },
                                  value: _LessonPrices[index]['Price'] == null
                                      ? 0.0.toString()
                                      : _LessonPrices[index]['Price']
                                          .toString()),
                            )
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'فيديوهات',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.right,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: videos.length,
                      itemBuilder: (context, index)=>
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                width: 130,
                                child: InkWell(
                                  onTap: () async{
                                    final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
                                    if(picked == null) return;
                                    videos[index] = picked;
                                    setState(() {});
                                  },
                                  child: CustomDottedBorder(
                                    child: Column(
                                      children: [
                                        Image.asset('assets/images/promo.png'),
                                        Text(videos[index] != null ? basename(videos[index].path)
                                            : 'رفع فيديو', style: const TextStyle(fontSize: 14),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              if(index == videos.length - 1)
                                InkWell(
                                    onTap: (){
                                      videos.add(null);
                                      setState(() {});
                                    },

                                    child: const Icon(Icons.add_circle_sharp, color: AppColors.primaryColor, size: 60,))
                            ],
                          )
                      ,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'مرفقات',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.right,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: attachments.length,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            width: 130,
                            child: InkWell(
                              onTap: () async {
                                final picked = await pickFile();
                                if (picked == null) return;
                                attachments[index] = picked;
                              },
                              child: CustomDottedBorder(
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/promo.png'),
                                    Text(attachments[index] != null ?
                                    basename(attachments[index].path) : 'رفع ملف', style: const TextStyle(fontSize: 14),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          if (index == attachments.length - 1)
                            InkWell(
                                onTap: () {
                                  attachments.add(null);
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.add_circle_sharp,
                                  color: AppColors.primaryColor,
                                  size: 60,
                                ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _lesson_Loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomElevatedButton(
                            title: 'حفظ التعديلات',
                            function: _updateCourseLesson

                            /* (){
                   courseFiles = {
                    'video': null,
                    'file': null,
                    'title': null,
                    'price': null,
                  };
                  setState(() {});
                } */

                            )
                  ],
                )),
    );
  }

  Future<File?> pickFile() async {
    final picked = await FilePicker.platform.pickFiles();
    if (picked != null) {
      return File(picked.files.single.path!);
    }
  }

  changePeriod(SubscriptionPeriod subscriptionPeriod) {
    for (var i = 0; i < subscriptionPeriodList.length; i++) {
      if (subscriptionPeriodList[i].id == subscriptionPeriod.id) {
        subscriptionPeriodList[i].isActive = true;
      } else {
        subscriptionPeriodList[i].isActive = false;
      }
    }
    setState(() {});
  }

  void _getLessonData() async {
    setState(() {
      _Loading = true;
    });

    Map<String, dynamic> data = {
      'courseLessonId': widget.courseLessonId.toString()
    };

    try {
      var response = await CallApi()
          .getWithBody(data, "/api/Course/GetCourseLessonById", 1);
      var body = json.decode(response.body);
      print('body ' + body.toString());

      if (response != null && response.statusCode == 200) {
        _lessonNameController.text = body['Title'];
        _videoNameController.text = body['VideoTitle']??'';
        _videoDescController.text = body['VideoDescription']??'';
        _isFree = body['Free'];

        _LessonPrices = body['CourseLessonPrices'];
      } else {
        ShowMyDialog.showMsg(body['Message']);
      }
      setState(() {
        _Loading = false;
      });
    } catch (e) {
      setState(() {
        _Loading = false;
      });
      print(' add Group  ee ' + e.toString());
    }
  }

  void _updateCourseLesson() async {
    setState(() {
      _lesson_Loading = true;
    });

    List<Map<String, dynamic>> _lessonPrices = [];

    for (int i = 0; i < _LessonPrices.length; i++) {
      _lessonPrices.add({
        'CurrencyId': _LessonPrices[i]['CurrencyId'],
        'Price': _LessonPrices[i]['Price'].toInt()
      });
    }

    List<String> AttachmentUrl = [];
    for (int i = 0; i < attachments.length; i++) {
      if(attachments[i] == null) continue;
      AttachmentUrl.add(attachments[i].path);
    }
    List<String>  VidetUrl  =[];
    for(int i=0;i<videos.length;i++){
      if(videos[i] == null) continue;
      VidetUrl.add( videos[i].path);
    }

    Map<String, String> data = {
      "Id": widget.courseLessonId.toString(),
      "CourseId": widget.courseId.toString(),
      "Title": _lessonNameController.text,
      "Prices": jsonEncode(_lessonPrices),
      "VideoTitle": _videoNameController.text,
      "VideoDescription": _videoDescController.text,
      "Free": _isFree.toString(),
      "Duration": videoDuration?? '',
    };
    //  print(' lesson data   '+data.toString());

    try {
      var response = await CallApi().puttJsonAndFileCourseLesson(
          data,
          VidetUrl,
          AttachmentUrl,
          "/api/Course/UpdateCourseLesson",
          1);
      if (response != null && response.statusCode == 200) {
        ShowMyDialog.showMsg("تم تعديل الدرس بنجاح");
      } else {
        ShowMyDialog.showMsg(response.toString());
      }
      setState(() {
        _lesson_Loading = false;
      });
    } catch (e) {
      setState(() {
        _lesson_Loading = false;
      });
      print(' add Course  ee ' + e.toString());
      ShowMyDialog.showMsg(e.toString());
    }
  }
}

enum TypeGroup { group, single }

enum TypeTime { night, morning }

class SubscriptionPeriod {
  int id;
  String txt;
  bool isActive;

  SubscriptionPeriod(this.id, this.txt, {this.isActive = false});
}

class SuggestedTeacher {
  int id;
  String name;
  bool isActive;

  SuggestedTeacher(this.id, this.name, {this.isActive = false});
}

class Teacher {
  int id;
  String name;

  Teacher(this.id, this.name);
}
