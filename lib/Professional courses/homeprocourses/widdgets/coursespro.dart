import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../../model/mainmodel.dart';
import '../../../../widgets/rateIndecator.dart';

class CoursesPro extends StatelessWidget {
  CoursesPro({required this.model, Key? key, required this.x})
      : super(key: key);
  int x;
  MainModel model;
  List<String> courseptext = [
    'كورس تصميم',
    '  كورس برمجه',
  ];
  List<String> courseptext2 = [
    'د:احمد ابراهيم  ',
    '   د:محمد احمد ',
  ];

  List<String> coursespimags = [
    'assets/images/digital-marketing 1.png',
    'assets/images/coding 1.png',
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: x == 1 ? model.teacherHomeGroupList.length : 2,
        itemBuilder: (context, index) => coursesandgroupschildrenitem(index));
  }

  InkWell coursesandgroupschildrenitem(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
              x == 0
                  ? Image.asset(coursespimags[index])
                  : Image.network(
                      model.teacherHomeGroupList[index].SubjectPicture,
                      height: 20,
                      width: 50,
                    ),
              SizedBox(
                height: 4,
              ),
              Text(
                x == 0
                    ? courseptext[index]
                    : model.teacherHomeGroupList[index].GroupName,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                maxLines: 1,
              ),
              Text(
                x == 0
                    ? courseptext2[index]
                    : model.teacherHomeGroupList[index].GroupName,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                maxLines: 1,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  x == 0
                      ? 'اشترك الان '
                      : model.teacherHomeGroupList[index].GroupName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
              )
            ]),
      ),
    );
  }
}
