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

enum ContentType { comleted, notcompletd }

class ChildrenTasksPage extends StatefulWidget {
  ChildrenTasksPage({Key? key}) : super(key: key);

  @override
  State<ChildrenTasksPage> createState() => _ChildrenTasksPageState();
}

class _ChildrenTasksPageState extends State<ChildrenTasksPage> {
  ContentType type = ContentType.comleted;
  final TextEditingController _childrenController = TextEditingController();

  List<String> subjecttext = [
    'الفيزياء',
    'الجغرافيا',
    'الانجليزي',
    ' اللغه العربيه',
  ];
  List<String> unitstext = [
    'واجب الوحده الاولي',
    '  واجب الوحده الثانيه',
    ' واجب الوحده الثالثه   ',
    ' واجب الوحده الرابعه   ',
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

  String getTextBasedOnIndex(int index) {
    if (index == 0) {
      return '  لغه عربيه';
    } else if (index == 1) {
      return '    انجليزي';
    } else if (index == 2) {
      return '   رياضيات ';
    } else if (index == 3) {
      return ' جغرافيا     ';
    }
    //
    return 'الفيزياء';
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
                        'اختر الماده',
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
                      SizedBox(height: 80, child: subSubjectContainer()),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () => setState(() {
                                    type = ContentType.comleted;
                                  }),
                              child: Text(
                                'تم التسليم  ',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: typeColor(ContentType.comleted)),
                              )),
                          GestureDetector(
                              onTap: () => setState(() {
                                    type = ContentType.notcompletd;
                                  }),
                              child: Text(
                                'لم يتم التسليم  ',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: typeColor(ContentType.notcompletd)),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // ---------------------- تم التسليم ------------------
                      if (type == ContentType.comleted)
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: 4,
                            itemBuilder: (context, index) =>
                                tasksContainer(context, index),
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                          ),
                        )
                      else
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: 4,
                            itemBuilder: (context, index) =>
                                tasksnotcompleted(context, index),
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
                title: ' الواجبات',
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
          // Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     margin: const EdgeInsets.symmetric(horizontal: 10),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       border: Border.all(color: AppColors.primaryColor),
          //       // color: Colors.white
          //     ),
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

  Container tasksContainer(context, int i) {
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
          Image.asset('assets/images/exam (4) 2(1).png', width: 50),
          SizedBox(
            width: 7,
          ),
          Column(
            children: [
              Text(
                getTextBasedOnIndex(i),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '15/8/2023',
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

  Container tasksnotcompleted(context, int i) {
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
          Image.asset('assets/images/exam (4) 2(1).png', width: 50),
          SizedBox(
            width: 7,
          ),
          Column(
            children: [
              Text(
                getTextBasedOnIndex(i),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '15/8/2023',
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
        ],
      ),
    );
  }
}
