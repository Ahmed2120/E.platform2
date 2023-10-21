import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/courses_and_groups/coursesAndGroups_page.dart';
import 'package:eplatform/pages/my_grades/my_grades_page.dart';
import 'package:eplatform/pages/my_wallet/my_wallet_page.dart';
import 'package:eplatform/pages/notification/notification_page.dart';
import 'package:eplatform/pages/student/student_page.dart';
import 'package:eplatform/pages/subscribtions/subscriptions.dart';
import 'package:eplatform/pages/tasks/tasks_page.dart';
import 'package:eplatform/pages/teachers/teachers_page.dart';
import 'package:eplatform/parent/childrendegrades/childrendegrees.dart';
import 'package:eplatform/parent/childrenssubscriptions.dart';
import 'package:eplatform/parent/childrentasks/childrentaks.dart';
import 'package:eplatform/parent/coursesandgroupsppage/coursesandgroupsparents.dart';
import 'package:eplatform/parent/homescreen/widgets/parentwallet.dart';
import 'package:eplatform/parent/homescreen/widgets/subscriptiptionparent.dart';
import 'package:eplatform/parent/homescreen/widgets/teachersp.dart';
import 'package:eplatform/parent/parentwallet/my_wallet_page.dart';
import 'package:eplatform/parent/princplechatting.dart';
import 'package:eplatform/parent/support.dart';
import 'package:eplatform/parent/topStudents/topstudents.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MorePreCoursPage extends StatelessWidget {
  MorePreCoursPage({Key? key}) : super(key: key);
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
          builder: (context, child, MainModel model) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: AppColors.primaryColor,
            ),
            Container(
              margin: EdgeInsets.only(top: deviceSize.height * 0.15),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 32.0),
                      const Text('المزيد',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              height: 1.5,
                              fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: AppColors.primaryColor,
                          size: 15,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.09,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () =>
                            GlobalMethods.navigate(context, StudentPage()),
                        child: CircleAvatar(
                          radius: deviceSize.height > 500 ? 25 : 20,
                          backgroundImage:
                              const AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Column(
                        children: [
                          Text(
                            '   عمر احمد',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Column(
                        children: [
                          Icon(
                            Icons.edit,
                            color: AppColors.primaryColor,
                          ),
                          Text('تعديل'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisSpacing: 40.0,
                      mainAxisSpacing: 30.0,
                      childAspectRatio: 1.88,
                      crossAxisCount: 2,
                      children: [
                        InkWell(
                            onTap: () => GlobalMethods.navigate(
                                context, ChildrensSubscriptions()),
                            child: buildContainer('اشتراكاتي',
                                'assets/images/notification.png', context)),
                        InkWell(
                            onTap: () => GlobalMethods.navigate(
                                context, ChildrenTasksPage()),
                            // const TasksPage()),
                            child: buildContainer('المهام ',
                                'assets/images/exam (4) 5.png', context,
                                hasCoins: true)),
                        InkWell(
                            onTap: () =>
                                GlobalMethods.navigate(context, ParentWallet()),
                            child: buildContainer('المحفظة',
                                'assets/images/wallet 1.png', context)),
                        InkWell(
                            onTap: () => GlobalMethods.navigate(
                                context, CoursesAndGroupsOfChildrens()),
                            child: buildContainer(
                                'الكورسات والمجموعات',
                                'assets/images/online-learning 2.png',
                                context)),
                        InkWell(
                            onTap: () => GlobalMethods.navigate(
                                context, NotificationPage()),
                            child: buildContainer(
                                'الاشعارات',
                                'assets/icons/notification (1) 1.png',
                                context)),
                        InkWell(
                            onTap: () => GlobalMethods.navigate(
                                context, ChildrenTasksPage()),
                            // const TasksPage()),
                            child: buildContainer('التحديات ',
                                'assets/images/exam (4) 5.png', context,
                                hasCoins: true)),
                        InkWell(
                            onTap: () => GlobalMethods.navigate(
                                context, ChildrenGradeePage()),
                            child: buildContainer(
                                'درجاتي', 'assets/images/grades.png', context,
                                hasCoins: true)),
                        InkWell(
                            onTap: () {
                              GlobalMethods.navigate(context, TopStudents());
                            },
                            child: buildContainer('الاوائل',
                                'assets/icons/podium 1.png', context)),
                        InkWell(
                            onTap: () {
                              GlobalMethods.navigate(context, SupportParent());
                            },
                            child: buildContainer(
                                'التواصل مع الدعم',
                                'assets/icons/technical-support 1.png',
                                context)),
                        InkWell(
                            onTap: () => GlobalMethods.navigate(
                                context, TeachersPPage()),
                            child: buildContainer('المدرسين',
                                'assets/images/teacher.png', context)),
                        InkWell(
                            onTap: () {},
                            child: buildContainer(
                                'الشروط والاحكام',
                                'assets/icons/terms-and-conditions 1.png',
                                context)),
                        InkWell(
                            onTap: () {},
                            child: buildContainer('عن المنصة',
                                'assets/icons/information 1.png', context)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Container buildContainer(String title, String img, context,
      {bool hasCoins = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  img,
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.black, fontSize: textSize(context)),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (hasCoins)
                Image.asset(
                  'assets/icons/coin.png',
                  width: 20,
                )
              else
                Container(),
              const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: AppColors.primaryColor,
                size: 13,
              )
            ],
          ),
        ],
      ),
    );
  }

  double textSize(context) {
    final widthSize = MediaQuery.of(context).size.width;
    if (widthSize > 420) {
      return 14;
    } else if (widthSize > 378) {
      return 12;
    } else {
      return 10;
    }
  }
}
