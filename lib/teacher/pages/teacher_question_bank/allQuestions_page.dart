import 'dart:convert';

import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../../core/utility/app_colors.dart';
import '../../../../core/utility/global_methods.dart';
import '../../../api/api.dart';
import '../../../model/customModel.dart';
import '../../../model/mainmodel.dart';
import '../../../session/userSession.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/drop_downs/custom_dropdown.dart';
import 'teacher_question_bank_page.dart';

class AllQuestionsPage extends StatefulWidget {
  AllQuestionsPage({required this.model, Key? key}) : super(key: key);

  MainModel model;

  @override
  State<AllQuestionsPage> createState() => _AllQuestionsPageState();
}

class _AllQuestionsPageState extends State<AllQuestionsPage> {

  CustomModel? subject;
  List<CustomModel> _subjects=[];
  CustomModel? educationType;
  List<CustomModel> _educationTypes = [];
  CustomModel? educationLevel;
  List<CustomModel> _levels = [];
  CustomModel? educationProgram;
  List<CustomModel> _educationPrograms = [];

  bool _type_loading=false;
  bool _level_loading=false;
  bool _subLoading=false;
  bool _questLoading=false;
  bool _educationProgramsLoading=false;

  @override
  void initState() {
    super.initState();

    _get_educationType();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
          builder:(context,child,MainModel model){
            return CustomStack(
              pageTitle: 'الاسئلة',
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: CustomDropDown(_educationTypes, selectEducationType, educationType, 'نوع التعليم')),

                      const SizedBox(width: 8,),

                      if(_educationPrograms.isNotEmpty) Expanded(child: CustomDropDown(_educationPrograms, selectEducationProgram, educationProgram, 'نوع المنهج')),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      if(_levels.isNotEmpty)  Expanded(child: CustomDropDown(_levels,
                          selectLevel, educationLevel
                          , 'المرحلة الدراسية')),

                      const SizedBox(width: 8,),

                      if(_subjects.isNotEmpty)  Expanded(child: CustomDropDown(_subjects, changeSubject, subject, 'المادة')),
                    ],
                  ),

                  const SizedBox(height: 8,),

                  model.questionLoading ?
                  const Center(child: CircularProgressIndicator(),) :
                  Expanded(
                    child: ListView.separated(
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.questionList.length,
                        separatorBuilder: (context, index)=> const SizedBox(height: 10,),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.borderColor),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('السؤال '+ (index+1).toString()),
                                const SizedBox(height: 5,),
                                Text( model.questionList[index].Text?? '', style: Theme.of(context).textTheme.headlineLarge,),
                                const SizedBox(height: 5,),
                                GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      // crossAxisSpacing: 5.0,
                                      // mainAxisSpacing: 5.0,
                                      childAspectRatio: 3
                                  ),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: model.questionList[index].Choices.length,
                                  itemBuilder: (context, index2)=> Text(model.questionList[index].Choices[index2].ChoiceText?? '', style: Theme.of(context).textTheme.bodySmall,),
                                ),
                                // if( model.questionList[index].Choices.isNotEmpty)
                                //   Row(
                                //     children: [
                                //       Expanded(
                                //         child: Text(model.questionList[index].Choices[0].ChoiceText?? '', style: Theme.of(context).textTheme.bodySmall,),
                                //       ),
                                //       const SizedBox(width: 8,),
                                //       Expanded(
                                //         child: Text(model.questionList[index].Choices[1].ChoiceText?? '', style: Theme.of(context).textTheme.bodySmall,),
                                //       ),
                                //
                                //     ],
                                //   ),
                                // const SizedBox(height: 5,),
                                // if( model.questionList[index].QuestionType == 1)
                                //   if( model.questionList[index].Choices.isNotEmpty)
                                //     Row(
                                //       children: [
                                //         Expanded(
                                //           child: Text( model.questionList[index].Choices[2].ChoiceText?? '', style: Theme.of(context).textTheme.bodySmall,),
                                //         ),
                                //         const SizedBox(width: 8,),
                                //         Expanded(
                                //           child: Text( model.questionList[index].Choices[3].ChoiceText?? '', style: Theme.of(context).textTheme.bodySmall,),
                                //         ),
                                //       ],
                                //     ),
                                const Divider(height: 10, thickness: 2,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('الاجابة الصحيحة:', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                                    SizedBox(
                                      width: 200,
                                      child: Text( model.questionList[index].CorrectAnswer??'', style: Theme.of(context).textTheme.bodySmall,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                    ),
                  ),
                  const SizedBox(height: 10,),
                  if(UserSession.hasPrivilege(23)) CustomElevatedButton(title: 'اضافة سؤال', function: ()=> GlobalMethods.navigate(context, TeacherQuestBankPage(model: model,))),
                  const SizedBox(height: 10,),
                ],
              ),
            );
          }
      ),
    );
  }


  changeSubject(val){
    subject = val;
    if(subject != null && educationType != null && educationLevel != null && educationProgram != null){
      widget.model.fetchQuestions(educationProgramId: educationProgram!.Id, subjectId: subject!.Id, educationTypeId: educationType!.Id, educationLevelId: educationLevel!.Id);
    }
  }

  changeEducationProgram(val){
    educationProgram = val;
    if(subject != null && educationType != null && educationLevel != null && educationProgram != null){
      widget.model.fetchQuestions(educationProgramId: educationProgram!.Id, subjectId: subject!.Id, educationTypeId: educationType!.Id, educationLevelId: educationLevel!.Id);
    }
  }


  selectLevel(val) async{
    educationLevel = val;
    await _getSubOfTeacher(educationType!.Id, educationLevel!.Id, educationProgram!.Id);
    if(subject != null && educationType != null && educationLevel != null && educationProgram != null){
      widget.model.fetchQuestions(educationProgramId: educationProgram!.Id, subjectId: subject!.Id, educationTypeId: educationType!.Id, educationLevelId: educationLevel!.Id);
    }
  }
  selectEducationType(val)async{
    educationType = val;
    await _getEducationPrograms(educationType!.Id);
    if(_educationPrograms.isEmpty){
      await _get_educationLevels(educationType!.Id, null);
    }
    if(subject != null && educationType != null && educationLevel != null && educationProgram != null){
      widget.model.fetchQuestions(educationProgramId: educationProgram!.Id, subjectId: subject!.Id, educationTypeId: educationType!.Id, educationLevelId: educationLevel!.Id);
    }
  }
  selectEducationProgram(val)async{
    educationProgram = val;
    await _get_educationLevels(educationType!.Id, educationProgram!.Id);
    if(subject != null && educationType != null && educationLevel != null && educationProgram != null){
      widget.model.fetchQuestions(educationProgramId: educationProgram!.Id, subjectId: subject!.Id, educationTypeId: educationType!.Id, educationLevelId: educationLevel!.Id);
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
}