import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/pages/components/row_title.dart';
import 'package:eplatform/pages/courses_and_groups/coursesAndGroups_page.dart';
import 'package:eplatform/parent/childrensubscriptiongroups.dart';
import 'package:eplatform/parent/choldensubscoursesdetails.dart';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

List<String> subjecttext = [
  'الفيزياء',
  'الجغرافيا',
  'الانجليزي',
  ' اللغه العربيه',
];
List<String> unitstext = [
  'الوحده الاولي',
  'الوحده الثانيه',
  'الوحده الثالثه  ',
  'اسئله بنك المعرفه ',
];
List<Color> percentgeColors = [
  Color(0xFFB3716F),
  Color(0xffD79E85),
  Colors.blue,
  Colors.green,
];
List<String> textprecentage = [
  ' 80',
  '50 ',
  '80   ',
  ' 45  ',
];
List<String> gradedetail = [
  ' 60/40',
  '60/30 ',
  '60/40   ',
  ' 100/45  ',
];
List<double> precentagen = [
  .8,
  .5,
  .8,
  .45,
];
String getTextBasedOnIndex(int index) {
  if (index == 0) {
    return 'مجموعه أ/ احمد خالد';
  } else if (index == 1) {
    return 'مجموعه أ/ عاطف محمود ';
  } else if (index == 2) {
    return ' مجموعه أ/علاء يوسف ';
  } else if (index == 3) {
    return ' مجموعه أ/ممدوح احمد';
  }
  //
  return 'مجموعه أ/ممدوح احمد';
}

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

class GroupsAnalysis extends StatefulWidget {
  GroupsAnalysis({Key? key}) : super(key: key);

  @override
  State<GroupsAnalysis> createState() => _GroupsAnalysisState();
}

class _GroupsAnalysisState extends State<GroupsAnalysis> {
  ContentType type = ContentType.course;
  final TextEditingController _childrenController = TextEditingController();

  final List<String> childrenchoise = [
    'esraa esraa',
    'mahmoud mahmoud ',
    'ahmed ahmed',
    'ali ali'
  ];
  String? valuechoose;
  int selectedItemIndex = -1;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 80, child: childrenchoisecontainer()),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context, index) =>
                              analysiscoursecontainer(context, index),
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const CustomRowTitle(
                title: 'احصائيات المجموعات ',
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget analysischoising(
    context,
    String title,
  ) =>
      Container(
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
            ),
            Expanded(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
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

  Widget childrenchoisecontainer() => Padding(
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

  Color typeColor(ContentType contentType) {
    if (contentType == type) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }

  Container analysiscoursecontainer(context, int i) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
              child: Image.asset(
            'assets/images/teachers.png',
          )),
          SizedBox(
            width: 7,
          ),
          Column(
            children: [
              Text(
                getTextBasedOnIndex(i),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 14),
              ),
              Text(
                subjecttext[i],
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 12),
              ),
              Text(
                'تم مشاهدة 30 /40 فيديو',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
          const Spacer(),
          CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 5.0,
              percent: precentagen[i],
              reverse: true,
              center: Text(
                textprecentage[i],
                style: TextStyle(color: percentgeColors[i]),
              ),
              progressColor: percentgeColors[i]),
        ],
      ),
    );
  }
}
