import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../core/utility/app_colors.dart';
import '../../model/homework/homeWork.dart';
import '../../model/homework/notDeliveredHomeWork.dart';
import '../../model/mainmodel.dart';
import '../../model/subject/subject.dart';
import '../exam/exam.dart';
import 'homework_answer_page.dart';
import 'homework_exam_page.dart';



class HomeworkPage extends StatefulWidget {

  HomeworkPage({ required this.model, Key? key}) : super(key: key);
  MainModel model;

  @override
  State<HomeworkPage> createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage> {
  DeliveryType type = DeliveryType.delivered;
  Subject ?  _selectedSubject;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedSubject=widget.model.allSubjects[0];
    widget.model.fetchHomeWork(_selectedSubject!.Id);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: ScopedModelDescendant<MainModel>(
            builder:(context,child,MainModel model){
              return CustomStack(
                pageTitle: 'الواجب',
                  child: Column(
                    children: [
                      Align(alignment: Alignment.center, child: Text('لغة عربية',
                        style: Theme.of(context).textTheme.bodyMedium,)),
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: model.allSubjects.length,
                          itemBuilder: (context, index)=> subjectContainer(context,model.allSubjects[index]),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(onTap: () =>
                              setState(() {
                                type = DeliveryType.delivered;
                              }),child: Text('تم التسليم', style: TextStyle(fontSize: 17, color: typeColor(DeliveryType.delivered)),)),
                          GestureDetector(onTap: () =>
                              setState(() {
                                type = DeliveryType.unDelivered;
                              }),child: Text('لم يتم التسليم', style: TextStyle(fontSize: 17, color: typeColor(DeliveryType.unDelivered)),)),
                        ],
                      ),
                      // ---------------------- passed ------------------
                      if (type == DeliveryType.delivered)
                        Expanded(
                         child:
                        model.homeWorkLoading1 ?
                        Center(child: CircularProgressIndicator()):
                        model.allDeliveredHomeworks.isNotEmpty ? ListView.builder(
                          itemCount: model.allDeliveredHomeworks.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index)=>
                              InkWell(onTap: ()=>
                                  GlobalMethods.navigate(context,
                                      HomeworkAnswerPage()),
                                  child: deliveredContainer(context,
                                      model.allDeliveredHomeworks[index])),
                        ) : Image.asset('assets/images/no_data.png'),
                      )
                      // ---------------------- not passed ------------------
                      else Expanded(
                        child: model.allNotDeliveredHomeworks.isNotEmpty ? ListView.builder(
                          itemCount: model.allNotDeliveredHomeworks.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index)=>
                              InkWell(onTap: ()=>
                                  GlobalMethods.navigate(context, HomeworkExamPage()),
                                  child: unDeliveredContainer(context,model.allNotDeliveredHomeworks[index])),
                        ): Image.asset('assets/images/no_data.png'),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  )

              ); }));
  }

  Widget unDeliveredContainer(context,NotDeliveredHomework notDeliveredHomework) => Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: AppColors.primaryColor, width: 5)),
        color: Colors.white
    ),
    child: Row(
      children: [
        Image.asset('assets/icons/homework.png', width: 40, height: 40,),
        const SizedBox(width: 6,),
        Column(
          children: [
            Text(notDeliveredHomework.Title, style: Theme.of(context).textTheme.titleMedium,),
            Text(_selectedSubject!.Name, style: Theme.of(context).textTheme.titleSmall,),
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

  Widget deliveredContainer(context,HomeWork homeWork) => Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: AppColors.primaryColor, width: 5)),
        color: Colors.white
    ),
    child: Row(
      children: [
        Image.asset('assets/icons/homework.png', width: 40, height: 40,),
        const SizedBox(width: 6,),
        Column(
          children: [
            Text(homeWork.Title, style: Theme.of(context).textTheme.titleMedium,),
            Text(homeWork.EndDate, style: Theme.of(context).textTheme.titleSmall,),
          ],
        ),
        const Spacer(),
        CircularPercentIndicator(
          radius: 20.0,
          lineWidth: 4.0,
          percent: (homeWork.Degree/homeWork.MaxDegree) <=1.0 ?(homeWork.Degree/homeWork.MaxDegree): 1.0,
          reverse: true,
          center: Text("${( (homeWork.Degree/homeWork.MaxDegree) * 100).toInt()}", style: const TextStyle(color: AppColors.percentColor),),
          progressColor: AppColors.percentColor,
        ),
      ],
    ),
  );

  Widget subjectContainer(context ,Subject subject) =>
      InkWell(
        onTap: (){
          widget.model.fetchHomeWork(subject!.Id);
        },
        child: Column(
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
  ),
      );

  Color typeColor(DeliveryType passingType){
    if(passingType == type) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }
}



enum DeliveryType{
  delivered,
  unDelivered
}