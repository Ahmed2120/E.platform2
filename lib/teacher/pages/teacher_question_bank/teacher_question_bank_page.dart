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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.fetchSubOfTeacher1();
    widget.model.fetchTeacherEducationType();
    widget.model.fetchTeacherEducationLevels();
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
                Row(
                  children: [
                    Expanded(child: model.customSubOfTeacherLoading?const Center(child: CircularProgressIndicator()):
                     CustomDropDown(model.allCustomSubOfTeacher, changeSubject, subject, 'المادة'),),
                    const SizedBox(width: 8,),
                    Expanded(child:  model.customLevel_loading ?const Center(child: CircularProgressIndicator()):
                     CustomDropDown(model.allCustomEducationLevels,
                        selectLevel,educationLevel, 'المرحلة الدراسية'),),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Expanded(child: model.customEducationType?const Center(child: CircularProgressIndicator()):
                    CustomDropDown(model.allCustomEducationType, changeEducationType, educationType, 'نوع التعليم'),),
                    const SizedBox(width: 8,),
                    Expanded(child:  model.customEducationProgramsLoading?
                         const Center(child: CircularProgressIndicator())
                        :CustomDropDown(model.allCustomEducationPrograms,
                        change_educationPrograms, curriculumType, 'نوع المنهج'),),
                  ],
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

  changeSubject(val){
    subject = val;
    setState(() {

    });
  }
  selectLevel(val){
    educationLevel = val;
    setState(() {

    });

  }
  changeEducationType(val){
    educationType=val;
    widget.model.fetchTeacherEducationPrograms(educationType!);
    curriculumType=null;
    setState(() {

    });
  }
  change_educationPrograms(val){
    curriculumType=val;
    setState(() {

    });
  }

  void _addQuestion()  async{

    setState(() {
      _Loading=true;
    });

    Map data={
      "EducationTypeId": educationType!.Id,
      "GradeId": educationLevel!.Id,
      "SubjectId":subject!.Id ,
      "Text": questions[0]['quest'],
      "Degree": questions[0]['questScore'],
      "QuestionType": 1,
      "CorrectAnswer": questions[0]['rightAns'],
      "QuestionChoices": [
        questions[0]['ans1'],
        questions[0]['ans2'],
        questions[0]['ans3'],
        questions[0]['ans4']
      ],
      "Image": questions[0]['img']
    };
      print('data   '+data.toString());
    try {
      var response = await TeacherCall().postData(json.encode(data), "/api/Question/AddQuestion", 1);
      var body = json.decode(response.body);
        print ('body '+body.toString());
      if (response != null && response.statusCode == 200) {
        if(body['Success']) {
          ShowMyDialog.showMsg("تم إضافة السؤال بنجاح");
          GlobalMethods.navigate(context, TeacherCreateExamPage());
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


  Future<File?> pickImage() async{
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(picked != null){
      return File(picked.path);
    }
  }

}