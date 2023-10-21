import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/model/subject/subject.dart';
import 'package:eplatform/model/teacher/teacher.dart';
import 'package:eplatform/pages/components/row_title.dart';
import 'package:eplatform/pages/teachers/teacher_content.dart';
import 'package:eplatform/parent/homescreen/widgets/teachercontpent.dart';
import 'package:eplatform/widgets/rateIndecator.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

List<String> subjecttext = [
  'الجغرافيا',
  'الرياضيات',
  'الانجليزي  ',
  'العلوم',
  ' اللغه العربيه',
];
List<String> subsubjecttext = [
  'نصوص ',
  'نحو ',
  'بلاغه  ',
  'ادب',
];
List<String> teachersnamestext = [
  'أ:احمد خالد ',
  'أ:محمد علي ',
  'أ:محمود عمر  ',
];
List<String> teachersSubjectstext = [
  'لغه عربيه ورياضيات ',
  'لغه عربيه ',
  'لغه عربيه'
];

class TeachersPPage extends StatelessWidget {
  TeachersPPage({Key? key}) : super(key: key);

  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: AppColors.primaryColor,
            ),
            Container(
              margin: EdgeInsets.only(top: deviceSize.height * 0.10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Padding(
                padding: EdgeInsets.only(
                    top: deviceSize.height * 0.04, left: 15, right: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) =>
                            subjectContainer(context, index),
                      ),
                    ),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.all(12),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) =>
                            subSubjectContainer(index),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                            onTap: () => GlobalMethods.navigate(
                                context, TeacherContentPPage()),
                            child: teacherContainer(context, index)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 20, top: deviceSize.height * 0.08, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 6, spreadRadius: 3)
                ],
              ),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'بحث باسم المدرس',
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 25,
                      )),
                ),
              ),
            ),
            const CustomRowTitle(
              title: 'المدرسين',
            ),
          ],
        ),
      ),
    );
  }
}

Widget subjectContainer(context, int i) => Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFBBDDF8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            'assets/icons/arabic_book.png',
            width: 40,
            height: 40,
          ),
        ),
        Text(
          subjecttext[i],
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        )
      ],
    );

Widget subSubjectContainer(int i) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryColor),
        // color: Colors.white
      ),
      child: Center(child: Text(subsubjecttext[i])),
    );

Widget teacherContainer(context, int i) => Container(
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
              Text(
                '200' + ' متابع',
                style: Theme.of(context).textTheme.bodySmall,
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
                teachersnamestext[i],
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                teachersSubjectstext[i],
                style: Theme.of(context).textTheme.titleSmall,
              ),
              RateIndicator(rate: 4, itemSize: 25)
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
