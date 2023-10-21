import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/live/live_page.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../../session/userSession.dart';
import '../../../../widgets/dialogs/alertMsg.dart';
import '../../exams/exams_management_page.dart';
import '../../groups/homework/homework_details_page.dart';
import '../../notes/teacher_notes_page.dart';
import '../../student_grades/student_grades_page.dart';
import '../../teacher_create_exam/teacher_create_exam.dart';
import '../../teacher_live/teacher_live_page.dart';
import '../../teacher_question_bank/allQuestions_page.dart';
import '../../teacher_question_bank/teacher_question_bank_page.dart';
import '../../teacher_questions/teacher_questions_page.dart';
import '../../teacher_tasks/teacher_tasks_page.dart';


class TeacherPageHeader extends StatelessWidget {
  const TeacherPageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Container(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildColumn('الاختبارات', Image.asset('assets/images/exam.png', width: 30, height: 30,),()=> GlobalMethods.navigate(context,
                        ExamsManagementPage(model: model,))),
                    const SizedBox(width: 8,),
                    buildColumn('المذكرات', Image.asset('assets/images/diary 1.png', width: 30, height: 30,),
                            ()=> GlobalMethods.navigate(context, TeacherNotesPage(model:model))),
                    const SizedBox(width: 8,),
                    buildColumn('درجات الطلاب', Image.asset('assets/images/grades.png', width: 30, height: 30,),
                            () { if(!UserSession.hasPrivilege(32)) {
                              ShowMyDialog.showMsg(
                                  'You do not have the authority');
                              return ;
                            }
                      GlobalMethods.navigate(context, StudentGradesPage());}),
                    const SizedBox(width: 8,),
                    buildColumn('الواجب', Image.asset('assets/icons/homework.png', width: 30, height: 30,),
                            ()=> GlobalMethods.navigate(context, HomeWorkDetailsPage())),
                    const SizedBox(width: 8,),
                    buildColumn('الأسئلة', Image.asset('assets/images/secure-data 1.png', width: 30, height: 30,),
                            ()=> GlobalMethods.navigate(context, AllQuestionsPage(model: model,))),
                    const SizedBox(width: 8,),
                    buildColumn('لايف', Image.asset('assets/images/live.png', width: 30, height: 30,), ()=>GlobalMethods.navigate(context, const TeacherLivePage())),

                    const SizedBox(width: 8,),
                    buildColumn('المهام', CircularPercentIndicator(
                      radius: 17.0,
                      lineWidth: 3.0,
                      percent: 0.8,
                      reverse: true,
                      center: Text("${(0.8 * 100).toInt()}", style: const TextStyle(color: AppColors.percentColor),),
                      progressColor: AppColors.percentColor,
                    ), ()=> GlobalMethods.navigate(context, const TeacherTasksPage())),
                  ],
                ),
              );
      }
    ) ;
  }

  Widget buildColumn(String title, Widget image, Function function) {
    return InkWell(
      onTap: ()=> function(),
      child: Column(
        children: [
          image,
          Text(title, style: TextStyle(color: const Color(0xFF000000).withOpacity(0.65)),)
        ],
      ),
    );
  }
}
