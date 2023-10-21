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
import 'widgets/coursesanalysis.dart';
import 'widgets/groupsanalysis.dart';
import 'widgets/tasksanalysis.dart';

class AnalysisPage extends StatefulWidget {
  AnalysisPage({Key? key}) : super(key: key);

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  ContentType type = ContentType.course;
  final TextEditingController _childrenController = TextEditingController();

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
      return 'فيزياء';
    } else if (index == 1) {
      return 'الجغرافيا ';
    } else if (index == 2) {
      return ' الانجليزي ';
    } else if (index == 3) {
      return ' اللغه العربيه ';
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
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
                        columncontent(context,
                            'اجمالي فتح الفيديوهات على المنصة ', '60 فيديو'),
                        const SizedBox(
                          height: 10,
                        ),
                        columncontent(
                            context, 'اجمالي عدد اللايفات ', '5 لايفات '),
                        InkWell(
                          onTap: () {
                            GlobalMethods.navigate(context, GroupsAnalysis());
                          },
                          child: analysischoising(
                            context,
                            '      احصائيات المجموعات ',
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              GlobalMethods.navigate(
                                  context, CoursesAnalysis());
                            },
                            child:
                                analysischoising(context, 'احصائيات الكورسات')),
                        InkWell(
                            onTap: () {
                              GlobalMethods.navigate(context, TasksAnalysis());
                            },
                            child: analysischoising(
                                context, 'احصائيات الاختبارات')),
                      ],
                    ),
                  ),
                ),
              ),
              const CustomRowTitle(
                title: 'الاحصائيات ',
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
            Column(
              children: [
                Image.asset(
                  'assets/images/notification.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(
              width: 6,
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
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
        ),
      );
  Widget columncontent(context, String title, String subtitle) => Container(
        width: double.infinity,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.grey),
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
}
