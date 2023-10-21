import 'package:eplatform/Professional%20courses/homeprocourses/widdgets/coursescontentp.dart';
import 'package:eplatform/Professional%20courses/homeprocourses/widdgets/livecourses.dart';
import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/group/group.dart';
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

List<String> subjecttext = [
  'م/ممدوح احمد',
  'م/ممدوح احمد',
  'م/ممدوح احمد  ',
  ' اللغه العربيه',
];

List<String> teachersnamestext = [
  'كورس التسويق الالكتروني ',
  'كورس البرمجة  ',
  'كورس التصميم',
];
List<String> coursesimages = [
  'assets/images/digital-marketing 1.png',
  'assets/images/coding 1.png',
  'assets/images/web-design 3.png',
];
List<String> coursesnamestext = [
  'كورس التسويق الالكتروني  ',
  ' كورس البرمجه   ',
  ' كورس التصميم   ',
];

int selectedItemIndex = -1;

class MySubscription extends StatefulWidget {
  MySubscription({Key? key}) : super(key: key);

  @override
  State<MySubscription> createState() => _MySubscriptionState();
}

class _MySubscriptionState extends State<MySubscription> {
  ContentType type = ContentType.course;
  final TextEditingController _childrenController = TextEditingController();

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
                                'كورساتي ',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: typeColor(ContentType.course)),
                              )),
                          GestureDetector(
                              onTap: () => setState(() {
                                    type = ContentType.group;
                                  }),
                              child: Text(
                                ' كورسات لايف  ',
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
                                      context, CoursesContentPPage());
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
                                      context, LiveCoursesContent());
                                },
                                child: liveCoursesContainer(context, index)),
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
                title: ' كورساتي ',
              ),
            ],
          );
        }),
      ),
    );
  }

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
          coursesimages[i],
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
              'م/ممدوح احمد',
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
Widget liveCoursesContainer(context, int i) => Container(
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
          coursesimages[i],
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
              coursesnamestext[i],
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'م/ممدوح احمد',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ],
    ));
