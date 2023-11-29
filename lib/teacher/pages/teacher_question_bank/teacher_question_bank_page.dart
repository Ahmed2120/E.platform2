import 'dart:convert';
import 'dart:io';

import 'package:eplatform/api/teacherCall.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/pages/courses_and_groups/groups_page.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:eplatform/widgets/dialogs/alertMsg.dart';
import 'package:eplatform/widgets/text_fields/edit_change_value_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../api/api.dart';
import '../../../core/utility/app_colors.dart';
import '../../../core/utility/global_methods.dart';
import '../../../model/customModel.dart';
import '../../../widgets/drop_downs/custom_dropdown.dart';
import '../../../widgets/text_fields/change_value_field.dart';
import '../teacher_create_exam/teacher_create_exam.dart';

class TeacherQuestBankPage extends StatefulWidget {
  TeacherQuestBankPage({required this.model,Key? key}) : super(key: key);
  MainModel model;

  @override
  State<TeacherQuestBankPage> createState() => _TeacherQuestBankPageState();
}

class _TeacherQuestBankPageState extends State<TeacherQuestBankPage> {
  CustomModel? subject;
  CustomModel? educationType;
  CustomModel? educationLevel;
  CustomModel? curriculumType;
  bool _Loading=false;

  List<Map<String, dynamic>> questions = [
    {
      'quest': '',
      'rightAns': '',
      'ans1': '',
      'ans2': '',
      'ans3': '',
      'ans4': '',
      'questScore': '',
      'img': null,
      'type': 1
    },
  ];

  List<CustomModel?> selectedEducationTypeList = [null];
  List<List<CustomModel>?> curriculumTypeList = [null];
  List<CustomModel?> selectedCurriculumTypeList = [null];
  List<List<CustomModel>?> gradesList = [null];
  List<CustomModel?> selectedGradesList = [null];
  List<List<CustomModel>?> subjectList = [null];
  List<CustomModel?> selectedSubjectList = [null];

  List<CustomModel> _educationTypes=[];
  List<CustomModel> _educationLevels=[];
  List<CustomModel> _educationPrograms=[];
  List<CustomModel> _sub=[];

  bool _type_loading=false;
  bool _level_loading=false;
  bool _educationProgramsLoading=false;
  bool _subLoading=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _get_educationType();
  }


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
          body: CustomStack(
            pageTitle: 'بنك الاسئلة ',
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

                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: questions.length,
                  separatorBuilder: (context, index)=> const SizedBox(height: 10,),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(questions[index]['type'] == 1) multiChoiceQuest(index),
                        if(questions[index]['type'] == 2) trueAndFalseQuest(index),
                        if(questions[index]['type'] == 3) essayQuest(index),
                        if(index != questions.length - 1)
                          const Divider(thickness: 2, color: AppColors.primaryColor,),
                        if(index == questions.length - 1)
                          showDropDown(type1: 'اختيارات', type2: 'صح وخطأ', type3: 'مقالي',
                          onSelect: (val){
                            if(val == 1){
                              questions.add({
                                'quest': '',
                                'rightAns': '',
                                'ans1': '',
                                'ans2': '',
                                'ans3': '',
                                'ans4': '',
                                'questScore': '',
                                'img': null,
                                'type': 1
                              });
                              setState(() {});
                            }else if(val == 2){
                              questions.add({
                                'quest': '',
                                'rightAns': '',
                                'ans1': 'صح',
                                'ans2': 'خطا',
                                'questScore': '',
                                'img': null,
                                'type': 2
                              });
                              setState(() {});
                            }else if(val == 3){
                              questions.add({
                                'quest': '',
                                'rightAns': '',
                                'questScore': '',
                                'img': null,
                                'type': 3
                              });
                              setState(() {});
                            }
                          })
                       /*    InkWell(
                              onTap: ()
                              {
                                questions.add({
                                  'quest': '',
                                  'rightAns': '',
                                  'ans1': '',
                                  'ans2': '',
                                  'ans3': '',
                                  'ans4': '',
                                  'questScore': '',
                                  'img': null
                                });
                                setState(() {});
                              },
                              child: const Icon(Icons.add_circle_sharp, color: AppColors.primaryColor, size: 60,)) */
                      ],
                    );
                  }
                ),

                const SizedBox(height: 20,),
                _Loading ?Center(child: CircularProgressIndicator()):
                CustomElevatedButton(title: 'تم',function:_addQuestion,),
                    //function: ()=> GlobalMethods.navigate(context, TeacherCreateExamPage())),
                const SizedBox(height: 15,),

              ],
            ),
          ),
        );
      }
    );
  }

  Widget showDropDown({
    required String type1,
    required String type2,
    required String type3,
    required Function onSelect,
}){
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        iconEnabledColor: AppColors.primaryColor,
        icon: const Icon(Icons.add_circle_sharp, color: AppColors.primaryColor, size: 60,),
        items: [
          DropdownMenuItem(value: 1,
            child: Text(type1),),
          DropdownMenuItem(value: 2,
            child: Text(type2),),
          DropdownMenuItem(value: 3,
            child: Text(type3,))
        ],
        onChanged: (val) =>onSelect(val),
        // value: 1,
      ),
    );
  }

  Widget multiChoiceQuest(int index){
    return Column(
      children: [
        Text('السؤال '+ (index+1).toString(), style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
        Row(
          children: [
            Expanded(
              child: ChangeValueField(hintText: 'السؤال', onChange: (val){
                questions[index]['quest'] = val;
              },input:  TextInputType.multiline),
            ),
            IconButton(onPressed: () async{
              final img = await pickImage();
              if(img != null) questions[index]['img'] = img;
            }, icon: Icon(Icons.camera_enhance_outlined, size: 40,))
          ],
        ),
        const SizedBox(height: 5,),
        Text('الاجابات', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
        Row(
          children: [
            Expanded(
              child: ChangeValueField(hintText: 'الاجابة الاولى', onChange: (val){
                questions[index]['ans1'] = val;
              },input:  TextInputType.text),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: ChangeValueField(hintText: 'الاجابة الثانية', onChange: (val){
                questions[index]['ans2'] = val;
              },input:  TextInputType.text),
            ),

          ],
        ),
        const SizedBox(height: 5,),
        Row(
          children: [
            Expanded(
              child: ChangeValueField(hintText: 'الاجابة الثالثة', onChange: (val){
                questions[index]['ans3'] = val;
              },input:  TextInputType.text,),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: ChangeValueField(hintText: 'الاجابة الرابعة', onChange: (val){
                questions[index]['ans4'] = val;
              },input:  TextInputType.text),
            ),
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('الاجابة الصحيحة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            SizedBox(
              width: 200,
              child: ChangeValueField(hintText: '', onChange: (val){
                questions[index]['rightAns'] = val;
              },input:  TextInputType.text),
            ),
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('درجة السؤال', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            SizedBox(
              width: 200,
              child: ChangeValueField(hintText: '', onChange: (val){
                questions[index]['questScore'] = val;
              },input:  TextInputType.number),
            ),
          ],
        ),
      ],
    );
  }

  Widget trueAndFalseQuest(int index){
    return Column(
      children: [
        Text('السؤال '+ (index+1).toString(), style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
        Row(
          children: [
            Expanded(
              child: ChangeValueField(hintText: 'السؤال', onChange: (val){
                questions[index]['quest'] = val;
              },input:  TextInputType.multiline),
            ),
            IconButton(onPressed: () async{
              final img = await pickImage();
              if(img != null) questions[index]['img'] = img;
            }, icon: Icon(Icons.camera_enhance_outlined, size: 40,))
          ],
        ),
        const SizedBox(height: 5,),
        Text('الاجابات', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
        Row(
          children: [
            Expanded(
              child: ChangeValueField(hintText: 'الاجابة الاولى', onChange: (val){
                questions[index]['ans1'] = val;
              },input:  TextInputType.text),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: ChangeValueField(hintText: 'الاجابة الثانية', onChange: (val){
                questions[index]['ans2'] = val;
              },input:  TextInputType.text),
            ),

          ],
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('الاجابة الصحيحة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            SizedBox(
              width: 200,
              child: ChangeValueField(hintText: '', onChange: (val){
                questions[index]['rightAns'] = val;
              },input:  TextInputType.text),
            ),
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('درجة السؤال', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            SizedBox(
              width: 200,
              child: ChangeValueField(hintText: '', onChange: (val){
                questions[index]['questScore'] = val;
              },input:  TextInputType.number),
            ),
          ],
        ),
      ],
    );
  }

  Widget essayQuest(int index){
    return Column(
      children: [
        Text('السؤال '+ (index+1).toString(), style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
        Row(
          children: [
            Expanded(
              child: ChangeValueField(hintText: 'السؤال', onChange: (val){
                questions[index]['quest'] = val;
              },input:  TextInputType.multiline),
            ),
            IconButton(onPressed: () async{
              final img = await pickImage();
              if(img != null) questions[index]['img'] = img;
            }, icon: Icon(Icons.camera_enhance_outlined, size: 40,))
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('درجة السؤال', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            SizedBox(
              width: 200,
              child: ChangeValueField(hintText: '', onChange: (val){
                questions[index]['questScore'] = val;
              },input:  TextInputType.number),
            ),
          ],
        ),
      ],
    );
  }

  changeSubject(val, int index){
    // curriculumType=val;
    selectedSubjectList[index] = val;
    setState(() {

    });
  }
  selectLevel(val){
    educationLevel = val;
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

  void _addQuestion()  async{

    setState(() {
      _Loading=true;
    });

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
      // "EducationTypeId": educationType!.Id,
      // "GradeId": educationLevel!.Id,
      // "SubjectId":subject!.Id ,
      ...types,
      "Text": questions[0]['quest'],
      "Degree": questions[0]['questScore'],
      "QuestionType": 1.toString(),
      "CorrectAnswer": questions[0]['rightAns'],
      // "QuestionChoices": [
      //   questions[0]['ans1'],
      //   questions[0]['ans2'],
      //   questions[0]['ans3'],
      //   questions[0]['ans4']
      // ],
      'QuestionChoices[0]': questions[0]['ans1'],
      'QuestionChoices[1]': questions[0]['ans2'],
      'QuestionChoices[2]': questions[0]['ans3'],
      'QuestionChoices[3]': questions[0]['ans4'],
      // "Image": questions[0]['img']
    };
      print('data   '+data.toString());
    try {
      var response = await CallApi().postDataANDFile(data,null, "/api/Question/AddQuestion", 1);
      // var body = json.decode(response.body);
      //   print ('body '+body.toString());
      if (response != null && response.statusCode == 200) {
        // if(body['Success']) {
          ShowMyDialog.showMsg("تم إضافة السؤال بنجاح");
          GlobalMethods.navigate(context, TeacherCreateExamPage());
          //  Navigator.of(context).pop();
        // }
      }
      else {
        // ShowMyDialog.showMsg(body['Message']);
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


  Future<File?> pickImage() async{
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(picked != null){
      return File(picked.path);
    }
  }

}