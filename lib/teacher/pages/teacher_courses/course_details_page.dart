// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:eplatform/pages/components/custom_elevated_button.dart';
// import 'package:eplatform/pages/courses_and_groups/groups_page.dart';
// import 'package:eplatform/teacher/pages/create_course/components/create_course_dropDown.dart';
// import 'package:eplatform/widgets/custom_stack.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
//
// import '../../../api/api.dart';
// import '../../../api/teacherCall.dart';
// import '../../../core/utility/app_colors.dart';
// import '../../../model/customModel.dart';
// import '../../../model/teacher/curency.dart';
// import '../../../pages/components/custom_dotted_border.dart';
// import '../../../session/userSession.dart';
// import '../../../widgets/dialogs/alertMsg.dart';
// import '../../../widgets/text_fields/change_value_field.dart';
//
// class CreateCoursePage extends StatefulWidget {
//   CreateCoursePage({Key? key}) : super(key: key);
//
//   @override
//   State<CreateCoursePage> createState() => _CreateCoursePageState();
// }
//
// class _CreateCoursePageState extends State<CreateCoursePage> {
//
//   CustomModel? subject;
//   CustomModel? day;
//   CustomModel? time;
//   List<CustomModel> countries=[];
//
//
//   CustomModel? educationType;
//   CustomModel? educationLevel;
//   CustomModel? curriculumType;
//
//   TypeGroup typeGroup = TypeGroup.group;
//   TypeTime typeTime = TypeTime.morning;
//
//   bool isNextPage = false;
//   int _insertedCourseId=0;
//
//   List<CustomModel> _allCountries=[];
//   List<CustomModel> _educationTypes=[];
//   List<CustomModel> _educationLevels=[];
//   List<CustomModel> _educationPrograms=[];
//   List <SelectedCurrency>_selectedCurrencies=[];
//   List <SelectedCurrency>_selectedLessonCurrencies=[];
//   List<CustomModel> _sub=[];
//
//
//   bool _type_loading=false;
//   bool _level_loading=false;
//   bool _educationProgramsLoading=false;
//   bool _country_loading=false;
//   bool _currency_loading=false;
//   bool _subLoading=false;
//   bool _Loading=false;
//   bool _lesson_Loading=false;
//
//
//   List<SubscriptionPeriod> subscriptionPeriodList = [
//     SubscriptionPeriod(1, 'سنة'),
//     SubscriptionPeriod(2, 'ترم'),
//     SubscriptionPeriod(3, 'شهر'),
//     SubscriptionPeriod(4, 'حصة'),
//   ];
//
//   List<SuggestedTeacher> suggestedTeachers = [
//     SuggestedTeacher(1, 'أ/احمد خالد'),
//     SuggestedTeacher(2, 'أ/محمد محمود'),
//     SuggestedTeacher(3, 'أ/احمد ابراهيم'),
//   ];
//
//   Map courseFiles =
//   {
//     'video': null,
//     'file': null,
//     'title': null,
//     'price': null,
//   };
//
//   List<Map<String, String>> currencies = [
//     {
//       'ج.م': '',},
//     { 'د.ع': '',},
//     { 'ل.س': '',},
//     { 'ر.س': '',},
//     {'د.إ': '',},
//     {'ر.ع': '',},
//     {'ر.ق': '',}
//   ];
//
//   List<Map<String, String>> lessonCurrencies = [
//     {
//       'ج.م': '',},
//     { 'د.ع': '',},
//     { 'ل.س': '',},
//     { 'ر.س': '',},
//     {'د.إ': '',},
//     {'ر.ع': '',},
//     {'ر.ق': '',}
//   ];
//
//   List attachments = [null];
//
//   final _courseNameController = TextEditingController();
//   final _teacherNameController = TextEditingController();
//   final _courseTitleController = TextEditingController();
//   final _coursePriceController = TextEditingController();
//   final _subjectNameController = TextEditingController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _get_educationType();
//     _get_educationLevels();
//     _getCountry();
//     _getSubOfTeacher();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: CustomStack(
//         pageTitle: 'تفاصيل كورس',
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//
//             Text('عنوان الكورس', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
//             CreateCourseField(controller: _courseTitleController, hintText: 'عنوان الكورس'),
//             const SizedBox(height: 8,),
//
//             Text('اسم المادة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
//             //  CreateCourseField(controller: _subjectNameController, hintText: 'اسم المادة'),
//
//             _subLoading?Center(child: CircularProgressIndicator()):
//             CreateCourseDropDown(_sub, changeSubject, subject, 'النوع'),
//             // const SizedBox(height: 5,),
//             // Text('اسم المدرس ', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
//             // CreateCourseField(controller: _teacherNameController, hintText: 'اسم المدرس'),
//             const SizedBox(height: 5,),
//
//             _country_loading?Center(child: CircularProgressIndicator()):
//             Text('دول العرض', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
//             CreateCourseMultiSelectDropDown(_allCountries, selectCountries, 'دول العرض'),
//
//             const SizedBox(height: 5,),
//             Text('سعر الكوررس', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
//             const SizedBox(height: 8,),
//             Text('السعر', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
//
//             _currency_loading?const Center(child: Padding(
//               padding: EdgeInsets.all(10.0),
//               child: CircularProgressIndicator(),
//             )):
//             ListView.separated(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: _selectedCurrencies.length,
//               separatorBuilder: (context, index) => SizedBox(
//                 height: 10,
//               ),
//               itemBuilder: (context, index)=> Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(_selectedCurrencies[index].Name, style: Theme.of(context).textTheme.bodySmall,),
//                   SizedBox(
//                     width: 100,
//                     child: ChangeValueField(hintText: 'السعر', onChange: (value){
//                       _selectedCurrencies[index].value= value==null ? 0.0 : double.parse(value);
//                       setState(() {
//
//                       });
//
//                     },input:  TextInputType.number,),
//                   )
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 15,),
//             Row(
//               children: [
//                 Expanded(child: Column(
//                   children: [
//                     Text('نوع التعليم', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
//                     _type_loading?Center(child: CircularProgressIndicator()):
//                     CreateCourseDropDown(_educationTypes, changeEducationType, educationType, 'النوع'),
//                   ],
//                 ),),
//                 const SizedBox(width: 8,),
//                 Expanded(child: Column(
//                   children: [
//                     Text('نوع المنهج ', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
//                     _educationProgramsLoading?Center(child: CircularProgressIndicator()):
//                     CreateCourseDropDown(_educationPrograms, change_educationPrograms, curriculumType, 'المنهج'),
//                   ],
//                 ),),
//                 const SizedBox(width: 8,),
//                 Expanded(child: Column(
//                   children: [
//                     Text('المرحلة الدراسية', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
//                     _level_loading?Center(child: CircularProgressIndicator()):
//                     CreateCourseDropDown(_educationLevels, selectLevel, educationLevel, 'المرحلة'),
//                   ],
//                 ),),
//               ],
//             ),
//
//             const SizedBox(height: 15,),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<File?> pickFile() async {
//     final picked = await FilePicker.platform.pickFiles();
//     if (picked != null) {
//       return File(picked.files.single.path!);
//     }
//   }
//
//   changeSubject(val){
//     subject = val;
//     setState(() {
//
//     });
//
//   }
//   changeDay(val){
//     day = val;
//   }
//   changeTime(val){
//     time = val;
//   }
//
//   selectLevel(val){
//     educationLevel = val;
//     setState(() {
//
//     });
//
//   }
//   changeEducationType(val){
//     educationType=val;
//     _getEducationPrograms();
//     curriculumType=null;
//     setState(() {
//
//     });
//   }
//
//   change_educationPrograms(val){
//     curriculumType=val;
//     setState(() {
//
//     });
//   }
//
//   selectCountries(val){
//     countries = val;
//     getCurrencies();
//
//     setState(() {
//
//     });
//
//   }
//
//
//   changePeriod(SubscriptionPeriod subscriptionPeriod){
//     for(var i = 0; i< subscriptionPeriodList.length; i++ ){
//       if(subscriptionPeriodList[i].id == subscriptionPeriod.id){
//         subscriptionPeriodList[i].isActive = true;
//       }
//       else{
//         subscriptionPeriodList[i].isActive = false;
//       }
//
//     }
//     setState(() {});
//   }
//
//   chooseTeacher(SuggestedTeacher suggestedTeacher){
//     // teacher = suggestedTeacher.name;
//     setState(() {});
//   }
//
//   Widget subscriptionPeriodContainer(SubscriptionPeriod subscriptionPeriod) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 20),
//     margin: const EdgeInsets.only(right: 10),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: AppColors.primaryColor),
//         color: subscriptionPeriod.isActive ? AppColors.primaryColor : Colors.white
//     ),
//     child: Center(child: Text(subscriptionPeriod.txt, style: TextStyle(fontSize: 12, color: subscriptionPeriod.isActive ? Colors.white : AppColors.primaryColor),)),
//   );
//
//   Widget suggestedTeacherContainer(SuggestedTeacher suggestedTeacher) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 10),
//     margin: const EdgeInsets.only(right: 10),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       border: Border.all(color: AppColors.primaryColor),
//     ),
//     child: Center(child: Text(suggestedTeacher.name, style: const TextStyle(fontSize: 12, color: AppColors.primaryColor),)),
//   );
//
//   ElevatedButton buildElevatedButton(String title, Function function) {
//     return ElevatedButton(
//       onPressed: () => function(),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.primaryColor,
//         foregroundColor: Colors.white,
//         minimumSize: const Size.fromHeight(40),
//       ),
//       child: Text(title),
//     );
//   }
//   void _get_educationType() async{
//
//     setState(() {
//       _type_loading=true;
//     });
//
//     try {
//       var response = await CallApi().getData("/api/Teacher/GetTeacherEducationTypes",1);
//       if (response != null && response.statusCode == 200) {
//         List body = json.decode(response.body);
//         _educationTypes=body.map((e) => CustomModel.fromJson(e)).toList();
//       }
//     }
//     catch(e){
//
//       ShowMyDialog.showSnack(context,'ee '+e.toString());
//
//     }
//     setState(() {
//       _type_loading=false;
//     });
//   }
//   void _getEducationPrograms() async{
//
//     setState(() {
//       _educationProgramsLoading=true;
//     });
//     Map <String, dynamic>data={
//       "educationTypeId" :educationType!.Id.toString()
//     };
//
//     try {
//       var response = await CallApi().getWithBody(data,
//           "/api/EducationProgram/GetEducationPrograms",1);
//       List body =json.decode(response.body) ;
//       if (response != null && response.statusCode == 200) {
//         _educationPrograms=body.map((e) => CustomModel.fromJson(e)).toList();
//
//       }
//       setState(() {
//         _educationProgramsLoading=false;
//       });
//     }
//     catch(e){
//       print ('ee '+e.toString());
//       ShowMyDialog.showSnack(context,'ee '+e.toString());
//       //   ShowMyDialog.showMsg(context,'ee '+e.toString());
//       setState(() {
//         _educationProgramsLoading=false;
//       });
//     }
//
//   }
//   void _get_educationLevels() async{
//
//     setState(() {
//       _level_loading=true;
//     });
//
//
//     try {
//       var response = await CallApi().getData("/api/Teacher/GetTeacherGrades",1);
//
//       if (response != null && response.statusCode == 200) {
//         List body =json.decode(response.body) ;
//         _educationLevels=body.map((e) => CustomModel.fromJson(e)).toList();
//
//       }
//     }
//     catch(e){
//       print ('ee '+e.toString());
//       ShowMyDialog.showSnack(context,'ee '+e.toString());
//       //   ShowMyDialog.showMsg(context,'ee '+e.toString());
//     }
//     setState(() {
//       _level_loading=false;
//     });
//   }
//   void _getCountry() async{
//
//     setState(() {
//       _country_loading=true;
//     });
//
//     try {
//       var response = await CallApi().getData("/api/Country/GetCountries",0);
//
//       List body = json.decode(response.body);
//       if (response != null && response.statusCode == 200) {
//         _allCountries=body.map((e) => CustomModel.fromJson(e)).toList();
//       }
//     }
//     catch(e){
//       print ('ee '+e.toString());
//       //  ShowMyDialog.showSnack(context,'ee '+e.toString());
//     }
//     setState(() {
//       _country_loading=false;
//     });
//   }
//   void getCurrencies() async{
//
//     setState(() {
//       _currency_loading=true;
//     });
//
//     List<int> c=[];
//     for(int i=0 ; i <countries.length ;i++){
//       c.add(countries[i].Id);
//     }
//
//     try {
//       final response = await http.post(
//           Uri.parse(UserSession.getURL()+'/api/Country/GetCountryCurrencies'),
//           body:c.toString(),
//           headers: { 'Content-Type': 'application/json',}
//       );
//
//
//       if (response != null && response.statusCode == 200) {
//         List body = json.decode(response.body);
//         //  print(body.toString());
//         _selectedCurrencies=body.map((e) => SelectedCurrency.fromJson(e)).toList();
//         _selectedLessonCurrencies=body.map((e) => SelectedCurrency.fromJson(e)).toList();
//         print(_selectedCurrencies[0].Name);
//         setState(() {
//
//         });
//
//       }
//       else{
//         ShowMyDialog.showMsg(json.decode(response.body)['Message']);
//       }
//       setState(() {
//         _currency_loading=false;
//       });
//     }
//     catch(e){
//       print (' currrency ee '+e.toString());
//       //  ShowMyDialog.showSnack(context,'ee '+e.toString());
//       setState(() {
//         _currency_loading=false;
//       });
//     }
//
//   }
//   void _getSubOfTeacher()  async{
//     setState(() {
//       _subLoading=true;
//     });
//     Map<String,dynamic> data={
//       'teacherId':null
//     };
//     try {
//       var response = await CallApi().getWithBody(data, "/api/Teacher/GetTeacherSubjects", 1);
//       print(json.decode(response.body));
//       if (response != null && response.statusCode == 200) {
//         List body = json.decode(response.body);
//         _sub= body.map((e) => CustomModel.fromJson(e)).toList();
//         setState(() {
//           _subLoading=false;
//         });
//       }
//       else {
//         ShowMyDialog.showMsg(json.decode(response.body)['Message']);
//       }
//       setState(() {
//         _subLoading=false;
//       });
//     }
//     catch(e){
//       setState(() {
//         _subLoading=false;
//       });
//       print(' sub  ee '+e.toString());
//     }
//   }
//   void _addCourse()  async{
//
//     setState(() {
//       _Loading=true;
//     });
//
//     List<Map<String, dynamic>>  _courcePrices=[];
//
//     for(int i=0;i<_selectedCurrencies.length;i++){
//       _courcePrices.add({
//         'CurrencyId':_selectedCurrencies[i].Id,
//         'Price':_selectedCurrencies[i].value.toInt()
//       });
//     }
//
//     List<Map<String, dynamic>> _courseCountries=[];
//     for(int i=0;i<countries.length;i++){
//       _courseCountries.add( {'CountryId':countries[i].Id });
//     }
//
//
//     Map data={
//       "Id": 0,
//       "Title": _courseTitleController.text,
//       "SubjectId": subject!.Id,
//       "GradeId": educationLevel!.Id,
//       "EducationTypeId": educationType!.Id,
//       "CourseCountries": _courseCountries,
//       "CoursePrices":_courcePrices
//     };
//     //  print('data   '+data.toString());
//     try {
//       var response = await TeacherCall().postData(json.encode(data), "/api/Course/AddCourse", 1);
//       var body = json.decode(response.body);
//       print ('body '+body.toString());
//
//       if (response != null && response.statusCode == 200) {
//         if(body['Success']) {
//
//           ShowMyDialog.showMsg("تم إنشاء الكورس بنجاح");
//
//           setState(() {
//             isNextPage = true;
//             _insertedCourseId=body['Id'];
//           });
//           //  Navigator.of(context).pop();
//         }
//       }
//       else {
//         ShowMyDialog.showMsg(body['Message']);
//       }
//       setState(() {
//         _Loading=false;
//       });
//     }
//     catch(e){
//       setState(() {
//         _Loading=false;
//       });
//       print(' add Group  ee '+e.toString());
//     }
//   }
//   void _addCourseLesson()  async{
//     setState(() {
//       _lesson_Loading=true;
//     });
//
//     List<Map<String, dynamic>>  _lessonPrices=[];
//
//     for(int i=0;i<_selectedLessonCurrencies.length;i++){
//       _lessonPrices.add({
//         'CurrencyId':_selectedLessonCurrencies[i].Id,
//         'Price':_selectedLessonCurrencies[i].value.toInt()
//       });
//     }
//
//     List<Map<String, dynamic>> AttachmentUrl  =[];
//     for(int i=0;i<attachments.length;i++){
//       AttachmentUrl.add( {'AttachmentUrl':attachments[i]});
//     }
//
//     Map data={
//       "Id": 0,
//       "Title": _courseNameController.text,
//       "CourseLessonPrices":_lessonPrices,
//       "CourseVideoLessons": [
//         {
//           "VideoUrl": courseFiles['video'].toString(),
//           "CourseVideoLessonAttachments": [
//             {
//               "AttachmentUrl": AttachmentUrl.toString()
//             }
//           ]
//         }
//       ]
//     };
//     print(' lesson data   '+data.toString());
//     try {
//       var response = await TeacherCall().postData(json.encode(data),
//           "/api/Course/AddCourseLesson?courseId="+_insertedCourseId.toString(), 1);
//       var body = json.decode(response.body);
//       print ('body '+body.toString());
//
//       if (response != null && response.statusCode == 200) {
//         if(body['Success']) {
//
//           ShowMyDialog.showMsg("تم إضافة الدرس بنجاح");
//
//         }
//       }
//       else {
//         ShowMyDialog.showMsg(body['Message']);
//       }
//       setState(() {
//         _lesson_Loading=false;
//       });
//     }
//     catch(e){
//       setState(() {
//         _lesson_Loading=false;
//       });
//       print(' add Group  ee '+e.toString());
//     }
//   }
//
//
// }
//
// enum TypeGroup{
//   group,
//   single
// }
//
// enum TypeTime{
//   night,
//   morning
// }
//
// class SubscriptionPeriod{
//   int id;
//   String txt;
//   bool isActive;
//
//   SubscriptionPeriod(this.id, this.txt, {this.isActive = false});
// }
//
// class SuggestedTeacher{
//   int id;
//   String name;
//   bool isActive;
//
//   SuggestedTeacher(this.id, this.name, {this.isActive = false});
// }
//
// class Teacher{
//   int id;
//   String name;
//
//   Teacher(this.id, this.name);
// }