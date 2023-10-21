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

class FollowingTeachers extends StatefulWidget {
  FollowingTeachers({Key? key}) : super(key: key);

  @override
  State<FollowingTeachers> createState() => _FollowingTeachersState();
}

class _FollowingTeachersState extends State<FollowingTeachers> {
  ContentType type = ContentType.course;
  final TextEditingController _childrenController = TextEditingController();

  final List<String> childrenchoise = [
    'esraa esraa',
    'mahmoud mahmoud ',
    'ahmed ahmed',
    'ali ali'
  ];

  final List<String> TeachersName = [
    'أستاذ احمد خالد',
    'أستاذ احمد علي ',
    'أستاذ محمد خالد',
    ' أستاذ ابراهيم محمود '
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
                        Expanded(
                          child: ListView.separated(
                            itemCount: 4,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return followingteachersitem(context, index);
                            },
                          ),
                        ),
                      ]),
                ),
              ),
              const CustomRowTitle(
                title: 'المدرسون المتابعون ',
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget followingteachersitem(context, int index) => InkWell(
        child: Container(
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
                    'assets/images/teachers.png',
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
                    TeachersName[index],
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
