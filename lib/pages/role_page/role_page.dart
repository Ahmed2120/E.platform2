import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/pages/register/parent_register_page.dart';
import 'package:eplatform/pages/register/student_register_page.dart';
import 'package:flutter/material.dart';

import '../../Professional courses/rootprocourses/rootprocorses.dart';
import '../../core/utility/global_methods.dart';
import '../register/assistant_register_page.dart';
import '../register/teacher_register_page.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.primaryColor,
        title: const Text('اختر دورك'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          // mainAxisSpacing: 60,
          // crossAxisSpacing: 60,
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          children: [
            buildButton('ولي أمر', 'assets/images/parent.png', () {
              GlobalMethods.navigate(context, const ParentRegisterPage());
            }),
            buildButton('طالب', 'assets/images/student.png', () {
              GlobalMethods.navigate(context, const StudentRegisterPage());
            }),
            buildButton('كورسات مهنية', 'assets/images/online-course 1.png', () {
              GlobalMethods.navigate(context, const ROOTPROcORSESScreen());
            }),
            buildButton('معلم', 'assets/images/teacher.png', () {
              GlobalMethods.navigate(context, const TeacherRegisterPage());
            }),
            buildButton('مدرسة', 'assets/images/school.png', () {}),
            buildButton('مساعد', 'assets/images/assistant.png', () {
              GlobalMethods.navigate(context, const AssistantRegisterPage());
            }),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String title, String image, Function function) {
    return InkWell(
      onTap: ()=> function(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: const Color(0xFF000000).withOpacity(0.12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 1,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              image,
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  ElevatedButton buildElevatedButton(String title, Function function,
      Color color) {
    return ElevatedButton(
      onPressed: () => function(),
      child: Text(title),
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: color == Colors.white
              ? AppColors.secondaryColor
              : null,
          minimumSize: const Size.fromHeight(40),
          side: const BorderSide(
//            width: 5.0,
            color: AppColors.secondaryColor,
          ) // NEW
      ),
    );
  }
}
