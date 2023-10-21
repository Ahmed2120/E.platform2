import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/homework/homework_page.dart';
import 'package:eplatform/pages/live/live_page.dart';
import 'package:eplatform/pages/my_grades/my_grades_page.dart';
import 'package:eplatform/pages/note/note_page.dart';
import 'package:eplatform/pages/private_groups/private_groups_page.dart';
import 'package:eplatform/pages/test_yourself/test_yourself_page.dart';
import 'package:eplatform/parent/analysispage/analysis.dart';
import 'package:eplatform/parent/attendanceandabsence/attendanceandabsence.dart';
import 'package:eplatform/parent/childrendegrades/childrendegrees.dart';
import 'package:eplatform/parent/childrentasks/childrentaks.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../pages/tasks/tasks_page.dart';

class PageParentHeader extends StatelessWidget {
  const PageParentHeader({Key? key}) : super(key: key);

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
            const SizedBox(
              width: 8,
            ),
            buildColumn(
                'درجات الاباء ',
                Image.asset(
                  'assets/images/grades.png',
                  width: 30,
                  height: 30,
                ),
                () => GlobalMethods.navigate(context, ChildrenGradeePage())),
            const SizedBox(
              width: 8,
            ),
            buildColumn(
                'واجبات الابناء',
                Image.asset(
                  'assets/icons/homework.png',
                  width: 30,
                  height: 30,
                ),
                () => GlobalMethods.navigate(context, ChildrenTasksPage())),
            const SizedBox(
              width: 8,
            ),
            buildColumn(
                'الاحصائيات  ',
                Image.asset(
                  'assets/images/attendance 1.png',
                  width: 30,
                  height: 30,
                ),
                () => GlobalMethods.navigate(context, AnalysisPage())),
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              width: 10,
            ),
            buildColumn(
                'الغياب والحضور',
                Image.asset(
                  'assets/images/exam.png',
                  width: 30,
                  height: 30,
                ),
                () => GlobalMethods.navigate(context, AttendanceandAbsence())),
            const SizedBox(
              width: 8,
            ),
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
