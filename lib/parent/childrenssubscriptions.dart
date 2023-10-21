import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/pages/components/row_title.dart';
import 'package:eplatform/pages/courses_and_groups/coursesAndGroups_page.dart';
import 'package:eplatform/pages/subscribtions/sub_course_content_page.dart';
import 'package:eplatform/parent/childrensubscriptiongroups.dart';
import 'package:eplatform/parent/choldensubscoursesdetails.dart';
import 'package:eplatform/parent/custom%20widgets/customtextformfield.dart';
import 'package:eplatform/widgets/rateIndecator.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../core/utility/app_colors.dart';
import '../../model/courses/course.dart';
import '../../model/group/group.dart';
import '../../model/subject/subject.dart';
import '../pages/subscribtions/sub_groupsContant_page.dart';

List<String> subjecttext = [
  'الفيزياء',
  'الرياضيات',
  'الانجليزي  ',
  ' اللغه العربيه',
];
List<String> subsubjecttext = [
  'نصوص ',
  'نحو ',
  'بلاغه  ',
  'ادب',
];
List<String> teachersnamestext = [
  'كورس أ:احمد خالد ',
  'كورس أ: عاطف محمود ',
  'كورس أ:علاء يوسف  ',
];
List<String> groupssnamestext = [
  'مجموعه أ:احمد خالد ',
  'مجموعه أ: عاطف محمود ',
  'مجموعه أ:علاء يوسف  ',
];
List<String> teachersSubjectstext = ['لغه عربيه  ', ' عربيه ', 'لغه عربيه'];
String getphotosBasedOnIndex(int index) {
  if (index == 0) {
    return 'assets/images/physics.png';
  } else if (index == 1) {
    return 'assets/images/geography.png';
  } else if (index == 2) {
    return 'assets/images/english.png';
  } else if (index == 3) {
    return 'assets/images/arabic 1.png';
  }
  //
  return 'assets/images/physics.png';
}

String getTextBasedOnIndex(int index) {
  if (index == 0) {
    return 'الفيزياء';
  } else if (index == 1) {
    return '    الرياضيات';
  } else if (index == 2) {
    return '   انجليزي ';
  } else if (index == 3) {
    return '   لغه عربيه   ';
  }
  //
  return 'الفيزياء';
}

int selectedItemIndex = -1;

class ChildrensSubscriptions extends StatefulWidget {
  ChildrensSubscriptions({Key? key}) : super(key: key);

  @override
  State<ChildrensSubscriptions> createState() => _ChildrensSubscriptionsState();
}

class _ChildrensSubscriptionsState extends State<ChildrensSubscriptions> {
  ContentType type = ContentType.course;
  final TextEditingController _childrenController = TextEditingController();

  final List<String> childrenchoise = [
    'esraa esraa',
    'mahmoud mahmoud ',
    'ahmed ahmed',
    'ali ali'
  ];
  String? valuechoose;

  void updateSelectedItem(int index) {
    setState(() {
      selectedItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ScopedModelDescendant<MainModel>(
            builder: (context, child, MainModel model) {
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: AppColors.primaryColor,
              ),
              Container(
                margin: EdgeInsets.only(top: deviceSize.height * 0.08),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                updateSelectedItem(index);
                              },
                              child: subjectSubscription(context, index)),
                        ),
                      ),
                      SizedBox(height: 80, child: subSubjectContainer()),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () => setState(() {
                                    type = ContentType.course;
                                  }),
                              child: Text(
                                'كورسات الابناء ',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: typeColor(ContentType.course)),
                              )),
                          GestureDetector(
                              onTap: () => setState(() {
                                    type = ContentType.group;
                                  }),
                              child: Text(
                                'مجموعات الابناء ',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: typeColor(ContentType.group)),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // ---------------------- courses ------------------
                      if (type == ContentType.course)
                        Expanded(
                          child: ListView.builder(
                            itemCount: 3,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  GlobalMethods.navigate(
                                      context, ChildernCoursesContentPPage());
                                },
                                child:
                                    ChildrnsCoursesContainer(context, index)),
                          ),
                        )

                      // ---------------------- groups ------------------
                      else
                        Expanded(
                          child: ListView.builder(
                            itemCount: 3,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  GlobalMethods.navigate(
                                      context, ChildernGroupsContentPPage());
                                },
                                child: ChildrnsgroupsContainer(context, index)),
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      type == ContentType.course
                          ? CustomElevatedButton(
                              title: 'متجر الكورسات',
                              function: () {
                                GlobalMethods.navigate(
                                    context,
                                    CoursesAndGroupsPage(
                                      model: model,
                                    ));
                              })
                          : CustomElevatedButton(
                              title: 'متجر المجموعات', function: () {}),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const CustomRowTitle(
                title: 'اشتراكات الابناء',
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget subjectSubscription(context, int i) => InkWell(
        onTap: () {
          updateSelectedItem(i);
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFBBDDF8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                getphotosBasedOnIndex(i),
                width: 50,
                height: 50,
              ),
            ),
            Text(
              subjecttext[i],
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: selectedItemIndex == i
                      ? AppColors.primaryColor
                      : AppColors.cancelColor),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );

  Widget subSubjectContainer() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text(
                'اسم الاين',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              value: valuechoose,
              isExpanded: true,
              iconSize: 30,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.blue,
              ),
              onChanged: (newvalue) {
                setState(() {
                  valuechoose = newvalue;
                });
              },
              items: childrenchoise.map(buildMenuItem).toList(),
            ),
          )));
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 20, color: Colors.grey),
        ),
      );

  Widget courseContainer(context, {required Function onStart}) => Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/teacher.png',
              width: 50,
              height: 50,
            ),
            Text(
              'course.TeacherName!',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              'course.SubjectName',
              style: const TextStyle(color: Color(0xFF888B8E)),
            ),
            ElevatedButton(
                onPressed: () => onStart(), child: const Text('ابدا'))
          ],
        ),
      );

  Widget groupContainer(context, Group group, {required Function onStart}) =>
      Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            group.TeacherPicture == ''
                ? Image.asset(
                    'assets/images/teacher.png',
                    width: 50,
                    height: 50,
                  )
                : Image.network(
                    group.TeacherPicture!,
                    width: 50,
                    height: 50,
                  ),
            Text(
              group.TeacherName,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              group.SubjectName,
              style: const TextStyle(color: Color(0xFF888B8E)),
            ),
            ElevatedButton(
                onPressed: () => onStart(), child: const Text('ابدا'))
          ],
        ),
      );

  Color typeColor(ContentType contentType) {
    if (contentType == type) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }
}

enum ContentType { course, group }

Widget ChildrnsCoursesContainer(context, int i) => Container(
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
          'assets/images/teachers.png',
          width: 50,
          height: 50,
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          width: 6,
        ),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              teachersnamestext[i],
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              getTextBasedOnIndex(selectedItemIndex),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
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
    ));
Widget ChildrnsgroupsContainer(context, int i) => Container(
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
          'assets/images/teachers.png',
          width: 50,
          height: 50,
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          width: 6,
        ),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              groupssnamestext[i],
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              getTextBasedOnIndex(selectedItemIndex),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ],
    ));
