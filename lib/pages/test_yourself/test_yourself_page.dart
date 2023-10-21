import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/exam/passedExam.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../core/utility/app_colors.dart';
import '../../model/exam/notPassedExam.dart';
import '../../model/mainmodel.dart';
import '../../model/subject/subject.dart';
import '../components/row_title.dart';
import '../exam/exam.dart';

class TestYourselfPage extends StatefulWidget {

  TestYourselfPage({ required this.model, Key? key}) : super(key: key);
   MainModel model;

  @override
  State<TestYourselfPage> createState() => _TestYourselfPageState();
}

class _TestYourselfPageState extends State<TestYourselfPage> {
  PassingType type = PassingType.passed;

  @override
  Widget build(BuildContext context) {
    widget.model.fetchExams(1);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
         return SafeArea(
            child: Stack(
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
                  color: AppColors.pageBackgroundColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  children: [
                    Align(alignment: Alignment.center, child: Text('لغة عربية',
                      style: Theme.of(context).textTheme.bodyMedium,)),
                    SizedBox(
                      height: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: model.allSubjects.length,
                        itemBuilder: (context, index)=>
                            subjectContainer(context,model.allSubjects[index]),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(onTap: () =>
                            setState(() {
                              type = PassingType.passed;
                            }),child: Text('تم اجتيازاها',
                          style: TextStyle(fontSize: 17,
                              color: typeColor(PassingType.passed)),)),
                        GestureDetector(onTap: () =>
                            setState(() {
                              type = PassingType.notPassed;
                            }),child: Text('لم تجتاز', style: TextStyle(fontSize: 17, color: typeColor(PassingType.notPassed)),)),
                      ],
                    ),
                    // ---------------------- passed ------------------
                    if (type == PassingType.passed)
                      Expanded(
                       child:model.ExamLoading?
                       Center(child: CircularProgressIndicator())
                       : model.allPassedExam.isNotEmpty ? ListView.builder(
                        itemCount: model.allPassedExam.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index)=> InkWell(onTap: (){

                        },
                            child: passedContainer(context,model.allPassedExam[index])),
                      ) : Image.asset('assets/images/no_data.png'),
                    )
                    // ---------------------- not passed ------------------
                    else Expanded(
                      child:model.ExamLoading?
                      Center(child: CircularProgressIndicator())
                          : model.allNotPassedExam.isNotEmpty ? ListView.builder(
                           itemCount: model.allNotPassedExam.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index)=> InkWell(onTap: ()=>
                              GlobalMethods.navigate(context, ExamPage(model: model,)),
                              child: notPassedContainer(context,model.allNotPassedExam[index])),
                      ) : Image.asset('assets/images/no_data.png'),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),),
            ),
               const CustomRowTitle(title: 'اختبر نفسك',)

          ],
        )

    ); }));
  }

  Widget notPassedContainer(context,NotPassedExam notPassedExam) => Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: AppColors.primaryColor, width: 5)),
      color: Colors.white
    ),
    child: Row(
      children: [
        Image.asset('assets/images/english.png', width: 40, height: 40,),
        const SizedBox(width: 6,),
        Column(
          children: [
            Text(notPassedExam.Title, style: Theme.of(context).textTheme.titleMedium,),
            Text(notPassedExam.SubjectName, style: Theme.of(context).textTheme.titleSmall,),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
        ),
      ],
    ),
  );

  Widget passedContainer(context,PassedExam passedExam) => Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: AppColors.primaryColor, width: 5)),
      color: Colors.white
    ),
    child: Row(
      children: [
        Image.asset('assets/images/english.png', width: 40, height: 40,),
        const SizedBox(width: 6,),
        Column(
          children: [
            Text(passedExam.Title, style: Theme.of(context).textTheme.titleMedium,),
            Text(passedExam.SubjectName, style: Theme.of(context).textTheme.titleSmall,),
          ],
        ),
        const Spacer(),
        CircularPercentIndicator(
          radius: 20.0,
          lineWidth: 4.0,
          percent: passedExam.Degree/passedExam.MaxDegree,
          reverse: true,
          center: Text("${ (passedExam.Degree/passedExam.MaxDegree) * 100}",
                  style: TextStyle(color: AppColors.percentColor),),
                  progressColor: AppColors.percentColor,
        ),
      ],
    ),
  );

  Widget subjectContainer(context ,Subject subject) => Column(
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
      Text(subject.Name, style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,)
    ],
  );

  Color typeColor(PassingType passingType){
    if(passingType == type) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }
}



enum PassingType{
  passed,
  notPassed
}