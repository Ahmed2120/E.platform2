import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../../model/mainmodel.dart';
import '../../../../widgets/rateIndecator.dart';

class CoursesAndGroupsParnt extends StatelessWidget {
  CoursesAndGroupsParnt({required this.model, Key? key, required this.x})
      : super(key: key);
  int x;
  MainModel model;
  List<String> subscriptionchildrentexttext = [
    'مجموعات الرياضيات',
    'كورسات اللغة العربية',
  ];
  List<String> childrensubscripimges = [
    'assets/images/mathematics-symbol 2.png',
    'assets/images/arabic 1.png',
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
                ? Image.asset(childrensubscripimges[index])
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
                  ? subscriptionchildrentexttext[index]
                  : model.teacherHomeGroupList[index].GroupName,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              maxLines: 1,
            ),
            SizedBox(),
            Center(
                child: RateIndicator(
                    rate: x == 0 ? 4.0 : model.teacherHomeGroupList[index].Rate,
                    itemSize: 17)),
          ],
        ),
      ),
    );
  }
}
