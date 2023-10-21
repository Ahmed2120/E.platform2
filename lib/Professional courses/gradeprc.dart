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

import '../../core/utility/app_colors.dart';

class GradesProcPage extends StatefulWidget {
  GradesProcPage({Key? key}) : super(key: key);

  @override
  State<GradesProcPage> createState() => _GradesProcPageState();
}

class _GradesProcPageState extends State<GradesProcPage> {
  ContentType type = ContentType.course;
  final TextEditingController _childrenController = TextEditingController();

  List<String> subjecttext = [
    'التصميم',
    'البرمجه',
    'التسوق الرقمي',
    '  التصميم',
  ];
  List<String> unitstext = [
    'اختبار المستوي الاول',
    'الوحده الثاني',
    'الوحده الثالث  ',
    '  اختبار شامل علي الكورس ',
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

  String? valuechoose;
  int selectedItemIndex = -1;
  void updateSelectedItem(int index) {
    setState(() {
      selectedItemIndex = index;
    });
  }

  String getTextBasedOnIndex(int index) {
    if (index == 0) {
      return 'التصميم ';
    } else if (index == 1) {
      return 'البرمجه  ';
    } else if (index == 2) {
      return ' التسويق الالكتروني ';
    } else if (index == 3) {
      return ' التصميم  ';
    }
    //
    return 'التصميم';
  }

  String getphotosBasedOnIndex(int index) {
    if (index == 0) {
      return 'assets/images/digital-marketing 1.png';
    } else if (index == 1) {
      return 'assets/images/web-design 2.png';
    } else if (index == 2) {
      return 'assets/images/web-design 3.png';
    } else if (index == 3) {
      return 'assets/images/web-design 4.png';
    }
    //
    return 'assets/images/web-design 4.png';
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
                      Text(
                        'اختر الكورس',
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              updateSelectedItem(index);
                            },
                            child: subjectSubscription(
                              context,
                              index,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      selectedItemIndex == -1
                          ? Expanded(
                              child: Image.asset(
                                'assets/images/no_data.png',
                              ),
                            )
                          : Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder: (context, index) =>
                                    gradesContainer(context, index),
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider();
                                },
                              ),
                            )
                    ],
                  ),
                ),
              ),
              const CustomRowTitle(
                title: 'درجاتي',
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

  Color typeColor(ContentType contentType) {
    if (contentType == type) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }

  Container gradesContainer(context, int i) {
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
          Image.asset(getphotosBasedOnIndex(selectedItemIndex), width: 50),
          SizedBox(
            width: 7,
          ),
          Column(
            children: [
              Text(
                getTextBasedOnIndex(selectedItemIndex),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                unitstext[i],
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 12),
              ),
              Text(
                gradedetail[i],
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 12),
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
