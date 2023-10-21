import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../core/utility/app_colors.dart';
import '../../model/mainmodel.dart';

class TestResultPage extends StatelessWidget {

  TestResultPage({ required this.model, Key? key}) : super(key: key);

  MainModel model;
  List<Subject> subjects = [
    Subject(1, 'لغة عربية', isActive: true),
    Subject(2, 'لغة انجليزية'),
    Subject(3, 'رياضيات'),
    Subject(4, 'علوم'),
    Subject(5, 'لغة فرنسية'),
    Subject(6, 'دراسات اجتماعية'),
  ];

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
              margin: EdgeInsets.only(top: deviceSize.height * 0.15),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: AppColors.pageBackgroundColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 32.0),
                        const Text('اجابة امتحان الوحدة الاولى', style: TextStyle(fontSize: 20, color: Colors.white, height: 1.5, fontWeight: FontWeight.bold)),

                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Icon(Icons.arrow_forward_ios_sharp, color: AppColors.primaryColor, size: 15,),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.07,),
                  Text('نتيجة اختبار الوحدة الاولى', style: Theme.of(context).textTheme.titleMedium,),
                  Text('لغة عربية', style: Theme.of(context).textTheme.titleMedium,),
                  SizedBox(height: deviceSize.height * 0.12,),
                  CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 7.0,
                    percent: 0.8,
                    reverse: true,
                    center: Text("${0.8 * 100}", style: TextStyle(color: AppColors.percentColor),),
                    progressColor: AppColors.percentColor,
                  ),
                  SizedBox(height: 12,),
                  Text('60/40', style: Theme.of(context).textTheme.titleMedium,),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ElevatedButton(onPressed: (){}, child: Text('الاجابات')),
                  ),
                  SizedBox(height: 10,),
                ],
              ),),
          ],
        ),
      ),
    );
  }


  Widget gradeContainer(context) => Container(
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
        border: Border(right: BorderSide(color: AppColors.primaryColor, width: 3)),
        color: Colors.white
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white,),
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('بنك الاسئلة ', style: Theme.of(context).textTheme.titleMedium,),
            Text('لغة عربية ', style: Theme.of(context).textTheme.titleSmall,),
          ],
        ),
        SizedBox(width: 6,),
        Image.asset('assets/images/english.png', width: 40, height: 40,)
      ],
    ),
  );

  Widget subjectContainer(context) => Column(
    children: [
      Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFBBDDF8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset('assets/icons/arabic_book.png', width: 40, height: 40,),
      ),
      Text('اللغة العربية', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,)
    ],
  );
}

class Subject{
  final int id;
  final String name;
  bool isActive;

  Subject(this.id, this.name, {this.isActive = false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Subject && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

}