import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:flutter/material.dart';

import '../../../core/utility/global_methods.dart';
import '../../courses_and_groups/course_content_page.dart';
import '../../courses_and_groups/group_content_page.dart';
import '../../courses_and_groups/groups_page.dart';

class Courses extends StatelessWidget {
  Courses({required this.model, required this.type, Key? key})
      : super(key: key);
  MainModel model;
  String type;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: type == 'Course'
            ? model.homeCourseList.length
            : model.homeGroupList.length,
        itemBuilder: (context, index) => InkWell(
              onTap: () {},
              child: InkWell(
                onTap: () => GlobalMethods.navigate(
                    context,
                    type == 'Course'
                        ? CourseContentPage(
                            model: model, course: model.homeCourseList[index])
                        : GroupsPage(
                            model: model,
                            group: model.homeGroupList[index],
                          )),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                        color: const Color(0xFF000000).withOpacity(0.12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 1,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/english.png'),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        type == 'Course'
                            ? 'كورس ' +
                                model.homeCourseList[index].SubjectName
                                    .toString()
                            : 'مجموعة ' +
                                model.homeGroupList[index].SubjectName,
                        style: TextStyle(
                            fontSize: deviceSize.height * 0.02,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        type == 'Course'
                            ? model.homeCourseList[index].TeacherName.toString()
                            : model.homeGroupList[index].TeacherName,
                        style: TextStyle(
                            fontSize: deviceSize.height * 0.02,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        maxLines: 1,
                      ),
                      Text(
                        'ابدأ الان',
                        style: TextStyle(
                            fontSize: deviceSize.height * 0.02,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                // child: Stack(
                //   alignment: Alignment.center,
                //   children: [
                //     Container(
                //       height: 140,
                //       padding: const EdgeInsets.all(10),
                //       margin: const EdgeInsets.symmetric(horizontal: 10),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: Colors.white,
                //         border: Border.all(
                //             color: const Color(0xFF000000).withOpacity(0.12)),
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.grey.withOpacity(0.5),
                //             blurRadius: 1,
                //             offset: const Offset(
                //                 0, 3), // changes position of shadow
                //           ),
                //         ],
                //       ),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           SizedBox(
                //             height: 8,
                //           ),
                //           Text(
                //             type == 'Course'
                //                 ? 'كورس ' +
                //                     model.homeCourseList[index].SubjectName
                //                         .toString()
                //                 : 'مجموعة ' +
                //                     model.homeGroupList[index].SubjectName,
                //             style: TextStyle(
                //                 fontSize: deviceSize.height * 0.02,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.black),
                //             maxLines: 1,
                //           ),
                //           SizedBox(
                //             height: 6,
                //           ),
                //           Text(
                //             type == 'Course'
                //                 ? model.homeCourseList[index].TeacherName
                //                     .toString()
                //                 : model.homeGroupList[index].TeacherName,
                //             style: TextStyle(
                //                 fontSize: deviceSize.height * 0.02,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.black),
                //             maxLines: 1,
                //           ),
                //           Text(
                //             'ابدأ الان',
                //             style: TextStyle(
                //                 fontSize: deviceSize.height * 0.02,
                //                 fontWeight: FontWeight.bold),
                //             maxLines: 1,
                //           ),
                //         ],
                //       ),
                //     ),
                //     Positioned(
                //       top: 2,
                //       child: Image.asset('assets/images/english.png'),
                //       width: 40,
                //     ),
                //   ],
                // ),
              ),
            ));
  }
}
