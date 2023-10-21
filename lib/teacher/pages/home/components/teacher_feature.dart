import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/session/userSession.dart';
import 'package:eplatform/teacher/pages/create_group/create_group_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../assistant_management/assistant_management_page.dart';
import '../../assistant_management/available_assistant.dart';
import '../../create_course/create_course_page.dart';
import '../../groups/groups_management_page.dart';
import '../../parent_add_requests/parent_add_requests_page.dart';
import '../../student_add_requests/student_add_requests_page.dart';
import '../../teacher_courses/courses_management_page.dart';

class TeacherFeatures extends StatelessWidget {
  const TeacherFeatures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ScopedModelDescendant<MainModel>(
        builder: (context, child, MainModel model) {
      return GridView.count(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        mainAxisSpacing: 10,
        // crossAxisSpacing: 60,
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 2.5),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          if(UserSession.userRole == '6')feature(deviceSize,
              title: 'المدرسين',
              onTap: () =>
                  GlobalMethods.navigate(context, AvailableAssistantPage(model: model)),
              img: 'assets/icons/fatherhood 1.png'),
          feature(deviceSize,
              title: 'اضافة ولي امر',
              onTap: () =>
                  GlobalMethods.navigate(context, ParentAddRequestsPage()),
              img: 'assets/icons/fatherhood 1.png'),
          feature(deviceSize,
              title: 'اضافة طالب',
              onTap: () =>
                  GlobalMethods.navigate(context, StudentAddRequestsPage()),
              img: 'assets/icons/add (4) 1.png'),
          feature(deviceSize,
              title: 'ادارة المجموعات',
              onTap: () => GlobalMethods.navigate(
                  context,
                  GroupsManagementPage(
                    model: model,
                  )),
              img: 'assets/icons/add (5) 1.png'),
          feature(deviceSize,
              title: 'ادارة الكورسات',
              onTap: () => GlobalMethods.navigate(
                  context, CoursesManagementPage(model: model)),
              img: 'assets/icons/online-learning 2.png'),
          feature(deviceSize,
              title: 'ادارة  المساعدين',
              onTap: () =>
                  GlobalMethods.navigate(context, AssistantManagementPage(model: model,)),
              img: 'assets/icons/web-cam 1.png'),
        ],
      );
    });
  }

  Widget feature(Size deviceSize,
      {required String title, required String img, required Function onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: 140,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(img),
            SizedBox(
              height: 6,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: deviceSize.height * 0.02,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
