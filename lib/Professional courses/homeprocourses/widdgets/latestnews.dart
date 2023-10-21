import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../../model/mainmodel.dart';
import '../../../../widgets/rateIndecator.dart';

class LatestNews extends StatelessWidget {
  LatestNews({required this.model, Key? key, required this.x})
      : super(key: key);
  int x;

  MainModel model;
  List<String> latestnewstexts = [
    ' لايف جديد في كورس ',
    '  اختبار جديد في   ',
  ];
  List<String> latestnewstext2 = [
    '     التصميم',
    '     البرمجة  ',
  ];
  List<String> latestnewsimges = [
    'assets/images/live.png',
    'assets/images/score.png',
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: x == 1 ? model.teacherHomeGroupList.length : 2,
        itemBuilder: (context, index) => latestnewsItem(index));
  }

  InkWell latestnewsItem(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 200,
        width: 160,
        padding: const EdgeInsets.all(5),
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
                ? Image.asset(latestnewsimges[index])
                : Image.network(
                    model.teacherHomeGroupList[index].SubjectPicture,
                    height: 20,
                    width: 50,
                  ),
            Column(
              children: [
                Text(
                  x == 0
                      ? latestnewstexts[index]
                      : model.teacherHomeGroupList[index].GroupName,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  maxLines: 1,
                ),
                Text(
                  x == 0
                      ? latestnewstext2[index]
                      : model.teacherHomeGroupList[index].GroupName,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
