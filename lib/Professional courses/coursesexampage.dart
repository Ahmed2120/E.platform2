import 'dart:io';

import 'package:eplatform/Professional%20courses/cousesanswerpage.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/pages/courses_and_groups/groups_page.dart';
import 'package:eplatform/teacher/pages/exams/exam_exam_ans_page.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';

import '../../../../core/utility/app_colors.dart';

class CoursesExamPages extends StatefulWidget {
  CoursesExamPages({Key? key}) : super(key: key);

  @override
  State<CoursesExamPages> createState() => _CoursesExamPagesState();
}

class _CoursesExamPagesState extends State<CoursesExamPages> {
  List<String> names = ['محمد ابرهيم', 'محمد فتحي', 'محمود محمد', 'وائل محمد'];
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'اجابات اختبار الوحدة الاولى',
        child: ListView(
          shrinkWrap: true,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) => InkWell(
                  onTap: () =>
                      GlobalMethods.navigate(context, ExamCoursetAnsPage()),
                  child: studentContainer(
                    context,
                    name: names[index],
                    img: 'assets/images/student-profile.png',
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Container studentContainer(
    context, {
    required String name,
    required String img,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      decoration: BoxDecoration(
        border: const Border(
            right: BorderSide(color: AppColors.primaryColor, width: 5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            img,
            width: 70,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
