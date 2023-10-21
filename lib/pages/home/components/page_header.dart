import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/pages/live/live_page.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../model/mainmodel.dart';
import '../../homework/homework_page.dart';
import '../../my_grades/my_grades_page.dart';
import '../../note/note_page.dart';
import '../../private_groups/private_groups_page.dart';
import '../../tasks/tasks_page.dart';
import '../../test_yourself/test_yourself_page.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Container(
            height: 80,
            child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
             buildColumn('اختبر نفسك', Image.asset('assets/images/exam.png', width: 30, height: 30,),()=>
              GlobalMethods.navigate(context,TestYourselfPage(model: model,))),
                 const SizedBox(width: 8,),
              buildColumn('درجاتي', Image.asset('assets/images/grades.png', width: 30, height: 30,),
                ()=> GlobalMethods.navigate(context, MyGradesPage(model: model)  )),
              const SizedBox(width: 8,),
                      buildColumn('المذكرات', Image.asset('assets/images/diary 1.png', width: 30, height: 30,),
                ()=>GlobalMethods.navigate(context,NotePage(model: model,) )),
             const SizedBox(width: 8,),
            buildColumn('برايفت', Image.asset('assets/images/secure-data 1.png', width: 30, height: 30,),
                ()=>GlobalMethods.navigate(context, PrivateGroupsPage(model: model,))),
                   const SizedBox(width: 8,),
            buildColumn('لايف', Image.asset('assets/images/live.png', width: 30, height: 30,), ()=>GlobalMethods.navigate(context, const LivePage())),
               const SizedBox(width: 8,),
                 buildColumn('الواجب', Image.asset('assets/icons/homework.png', width: 30, height: 30,),
                ()=>GlobalMethods.navigate(context, HomeworkPage(model: model,))),
               const SizedBox(width: 8,),
              buildColumn('المهام', CircularPercentIndicator(
          radius: 17.0,
          lineWidth: 3.0,
          percent: 0.8,
          reverse: true,
          center: Text("${(0.8 * 100).toInt()}", style: const TextStyle(color: AppColors.percentColor),),
          progressColor: AppColors.percentColor,
        ), ()=>GlobalMethods.navigate(context, const TasksPage())),
      ],
    ),
          ) ;  });
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
