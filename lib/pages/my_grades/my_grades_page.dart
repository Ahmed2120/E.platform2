import 'package:eplatform/model/subject/subject.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/degree/Degree.dart';
import '../../model/mainmodel.dart';
import '../components/row_title.dart';
import '../test_yourself/test_yourself_page.dart';


class MyGradesPage extends StatefulWidget {
  MyGradesPage({required this.model ,Key? key}) : super(key: key);
  MainModel model;
  @override
  State<MyGradesPage> createState() => _MyGradesPageState();
}

class _MyGradesPageState extends State<MyGradesPage> {
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.fetchDegrees(null);
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child:
        ScopedModelDescendant<MainModel>(
            builder:(context,child,MainModel model){

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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 10),
              child:model.StudentDegreeLoading==true?
                 Center(child: CircularProgressIndicator())
              :Column(
                children: [

                  SizedBox(height: deviceSize.height * 0.07,),
                  Container(padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.topRight,
                      child: Text('اختر مادة', style: Theme.of(context).textTheme.bodyMedium,)),
                  Container(
                    height: deviceSize.height * 0.17,
                    padding: const EdgeInsets.all(12),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: model.allSubjects.length,
                      itemBuilder: (context, index)=> 
                          InkWell(
                            onTap: ()=>model.fetchDegrees(model.allSubjects[index].Id),
                            child: subjectContainer(context,
                            model.allSubjects[index]),
                          ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: model.allStudentDegreeList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index)=> gradeContainer(context,model.allStudentDegreeList[index]),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ElevatedButton(onPressed: ()=>
                        GlobalMethods.navigate(context,TestYourselfPage(model: model,)), child: Text('اذهب للاختبارات')),
                  ),
                  SizedBox(height: 10,),
                ],
              ),),
              const CustomRowTitle(title: 'درجاتي',),

            ],
        ) ; }),
      ),
    );
  }

  Widget gradeContainer(context , Degree degree) => Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.borderColor))
    ),
    child: Row(
      children: [
        Image.asset(degree.SubjectImage, width: 40, height: 40,),
        SizedBox(width: 6,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text( degree.SubjectName, style: Theme.of(context).textTheme.titleMedium,),
            Text(degree.ExamTitle, style: Theme.of(context).textTheme.titleSmall,),
            Text(degree.StudentDegree.toString()+'/'+ degree.ExamDegree.toString(),
                style: Theme.of(context).textTheme.titleSmall,),
          ],
        ),
        Spacer(),
        CircularPercentIndicator(
          radius: 20.0,
          lineWidth: 4.0,
          percent: (degree.StudentDegree/degree.ExamDegree) <1.0 ?(degree.StudentDegree/degree.ExamDegree):1.0 ,
          reverse: true,
          center: Text("${(degree.StudentDegree/degree.ExamDegree)*100}",
            style: TextStyle(color: AppColors.percentColor),),
          progressColor: AppColors.percentColor,
        ),
      ],
    ),
  );

  Widget subjectContainer(context,Subject subject) => 
      Column(
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



}



