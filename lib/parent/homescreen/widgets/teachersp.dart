import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../../model/mainmodel.dart';
import '../../../../widgets/rateIndecator.dart';

class TeachersProCourses extends StatelessWidget {
  TeachersProCourses({required this.model, Key? key, required this.x})
      : super(key: key);
  int x;
  MainModel model;
  List<String> Teachersname = [
    'د/ احمد خالد',
    ' أ/ معتز محمد',
    ' أ/ محمود عمر',
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: x == 1 ? model.teacherHomeGroupList.length : 3,
        itemBuilder: (context, index) => tacheritem(index));
  }

  InkWell tacheritem(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 150,
        width: 150,
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
                ? Image.asset(
                    'assets/images/teachers.png',
                    width: 39,
                  )
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
                  ? Teachersname[index]
                  : model.teacherHomeGroupList[index].GroupName,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              maxLines: 1,
            ),
            Center(
                child: RateIndicator(
                    rate: x == 0 ? 4.0 : model.teacherHomeGroupList[index].Rate,
                    itemSize: 15)),
          ],
        ),
      ),
    );
  }
}
