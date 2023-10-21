import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/school/school.dart';
import 'package:eplatform/parent/homescreen/widgets/schoolp.dart';
import 'package:flutter/material.dart';

class NearestSchoolParent extends StatelessWidget {
  NearestSchoolParent({Key? key}) : super(key: key);
  List<String> schooltext = [
    'السلام الثانويه',
    'قاسم امين الثانويه ',
    'الثانويه العسكريه',
  ];

  List<String> schoolimages = [
    'assets/images/school-map.png',
    'assets/images/school.png',
    'assets/images/school-map.png',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) => nearstschoolItem(index));
  }

  InkWell nearstschoolItem(int index) {
    return InkWell(
      onTap: () {},
      //=> GlobalMethods.navigate(context, SchoolPPage()),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                    color: const Color(0xFF000000).withOpacity(0.12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 1,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset(
                schoolimages[index],
                width: 70,
                height: 70,
              )),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: SizedBox(
              child: Text(
                schooltext[index],
                style: TextStyle(fontSize: 12, color: AppColors.titleColor),
                maxLines: 3,
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
