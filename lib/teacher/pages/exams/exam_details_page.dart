import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../../core/utility/app_colors.dart';
import '../../../../core/utility/global_methods.dart';
import '../../../model/mainmodel.dart';
import 'exam_students_page.dart';

class ExamDetailsPage extends StatefulWidget {
  ExamDetailsPage({required this.model, required this.examId, required this.examTitle, Key? key}) : super(key: key);

  MainModel model;
  int examId;
  String examTitle;

  @override
  State<ExamDetailsPage> createState() => _ExamDetailsPageState();
}

class _ExamDetailsPageState extends State<ExamDetailsPage> {

  List<Map<String, dynamic>> questions = [
    {
      'quest': 'كم مرة ذكر سيدنا هارون في القرآن؟',
      'rightAns': 'أ- اربع مرات',
      'ans1': 'أ- اربع مرات',
      'ans2': 'ب- ثلاث مرات',
      'ans3': 'ج-مرتان',
      'ans4': 'د-خمس مرات',
      'questScore': '',
    },{
      'quest': 'كم مرة ذكر سيدنا هارون في القرآن؟',
      'rightAns': 'أ- اربع مرات',
      'ans1': 'أ- اربع مرات',
      'ans2': 'ب- ثلاث مرات',
      'ans3': 'ج-مرتان',
      'ans4': 'د-خمس مرات',
      'questScore': '',
    },{
      'quest': 'كم مرة ذكر سيدنا هارون في القرآن؟',
      'rightAns': 'أ- اربع مرات',
      'ans1': 'أ- اربع مرات',
      'ans2': 'ب- ثلاث مرات',
      'ans3': 'ج-مرتان',
      'ans4': 'د-خمس مرات',
      'questScore': '',
    },
  ];

  @override
  void initState() {
    super.initState();

    widget.model.fetchExamById(examId: widget.examId);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
          builder:(context,child,MainModel model){
          return CustomStack(
            pageTitle: widget.examTitle,
            child: Column(
              children: [
                Expanded(
                  child: model.examDetailsLoading ? const Center(child: CircularProgressIndicator(),) :
                  ListView.separated(
                      // physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: model.teacherExamDetails.examQuestions!.length,
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
                              Text(model.teacherExamDetails.examQuestions![index].Text!, style: Theme.of(context).textTheme.headlineLarge,),
                              const SizedBox(height: 5,),
                              if(model.questionList.isNotEmpty)
                              GridView.builder(
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3
                                ),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: model.questionList[index].Choices.length,
                                itemBuilder: (context, index2)=> Text(model.questionList[index].Choices[index2].ChoiceText?? '', style: Theme.of(context).textTheme.bodySmall,),
                              ),
                              const Divider(height: 10, thickness: 2,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('الاجابة الصحيحة:', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                                  SizedBox(
                                    width: 200,
                                    child: Text(model.teacherExamDetails.examQuestions![index].CorrectAnswer??'', style: Theme.of(context).textTheme.bodySmall,),
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
                CustomElevatedButton(title: 'اجابات الطلاب', function: ()=> GlobalMethods.navigate(context, ExamStudentsPage())),
                const SizedBox(height: 10,),
              ],
            ),
          );
        }
      ),
    );
  }
}