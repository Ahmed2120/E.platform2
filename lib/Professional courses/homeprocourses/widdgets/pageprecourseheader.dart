import 'package:eplatform/Professional%20courses/exampage/examprec.dart';
import 'package:eplatform/Professional%20courses/gradeprc.dart';
import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/homework/homework_page.dart';
import 'package:eplatform/pages/live/live_page.dart';
import 'package:eplatform/pages/my_grades/my_grades_page.dart';
import 'package:eplatform/pages/note/note_page.dart';
import 'package:eplatform/pages/private_groups/private_groups_page.dart';
import 'package:eplatform/pages/test_yourself/test_yourself_page.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../pages/tasks/tasks_page.dart';

class PagePrecoursesHeader extends StatelessWidget {
  const PagePrecoursesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (context, child, MainModel model) {
      return Container(
        height: 80,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            buildColumn(
                'الاختبارات  ',
                Image.asset(
                  'assets/images/exam.png',
                  width: 30,
                  height: 30,
                ),
                () => GlobalMethods.navigate(context, ExamprocPage())),
            const SizedBox(
              width: 8,
            ),
            buildColumn(
                'المذكرات',
                Image.asset(
                  'assets/images/diary 1.png',
                  width: 30,
                  height: 30,
                ),
                () => GlobalMethods.navigate(
                    context,
                    NotePage(
                      model: model,
                    ))),
            SizedBox(
              width: 10,
            ),
            buildColumn(
                'درجات الطالب ',
                Image.asset(
                  'assets/images/grades.png',
                  width: 30,
                  height: 30,
                ),
                () => GlobalMethods.navigate(context, GradesProcPage())),
            SizedBox(
              width: 3,
            ),
            buildColumn(
                "الاسئلة ",
                Image.asset(
                  'assets/images/secure-data 1.png',
                  width: 30,
                  height: 30,
                ),
                () => GlobalMethods.navigate(
                    context,
                    PrivateGroupsPage(
                      model: model,
                    ))),
            const SizedBox(
              width: 8,
            ),
            buildColumn(
                'لايف',
                Image.asset(
                  'assets/images/live.png',
                  width: 30,
                  height: 30,
                ),
                () => GlobalMethods.navigate(context, const LivePage())),
            const SizedBox(
              width: 8,
            ),
            buildColumn(
                'المهام',
                CircularPercentIndicator(
                  radius: 17.0,
                  lineWidth: 3.0,
                  percent: 0.8,
                  reverse: true,
                  center: Text(
                    "${(0.8 * 100).toInt()}",
                    style: const TextStyle(color: AppColors.percentColor),
                  ),
                  progressColor: AppColors.percentColor,
                ),
                () => GlobalMethods.navigate(context, const TasksPage())),
          ],
        ),
      );
    });
  }

  Widget buildColumn(String title, Widget image, Function function) {
    return InkWell(
      onTap: () => function(),
      child: Column(
        children: [
          image,
          Text(
            title,
            style: TextStyle(color: const Color(0xFF000000).withOpacity(0.65)),
          )
        ],
      ),
    );
  }
}
