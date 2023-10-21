import 'dart:async';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import '../../core/utility/app_colors.dart';
import '../components/row_title.dart';
import 'components/data.dart';

class ExamPage extends StatefulWidget {
  ExamPage({required this.model, Key? key}) : super(key: key);
   MainModel model;
  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  Duration remainTimer = const Duration(minutes: 50);

  Timer? timer;
  int currentQuest = 0;

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery
        .of(context)
        .size;
    String timerText =
        '${remainTimer.inMinutes.remainder(60).toString()}:${remainTimer
        .inSeconds.remainder(60).toString().padLeft(2, '0')}';


    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              color: AppColors.primaryColor,
            ),
            Container(
              margin: EdgeInsets.only(top: deviceSize.height * 0.15),
              width: double.infinity,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.timer, color: AppColors.primaryColor,),
                              const SizedBox(height: 5,),
                              Text('الوقت المتبقي : $timerText'),
                            ],
                          ),
                          _questionWidget(questions[currentQuest]),
                          _answerList(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              nextBackBtn(true, () =>
                                  setState(() {
                                    if (currentQuest > 0) currentQuest--;
                                  })),
                              nextBackBtn(false, () =>
                                  setState(() {
                                    if (currentQuest !=
                                        questions.length - 1) currentQuest++;
                                  })),
                            ],),
                          Center(
                            child: SizedBox(
                              height: 50,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: questions.length,
                                itemBuilder: (context, index) => questNum(index),
                              ),
                            ),
                          ),
                          CustomElevatedButton(
                              function: () =>endExamDialog(), title: ' انهاء الاختبار'),
                        ],
                      ),
                    )
                  ],
                ),),
            ),
            const CustomRowTitle(title: 'اختبار الوحدة الاولى',),

          ],
        ),
      ),
    );
  }

  Widget questNum(int num) =>
      InkWell(onTap:()=> setState(() {
        currentQuest = num;
      }),
          child: Chip(label: Text((num + 1).toString()),
            backgroundColor: num == currentQuest
                ? AppColors.primaryColor
                : null,
            labelStyle: TextStyle(color: num == currentQuest
                ? Colors.white
                : null,),
          ));

  Widget _questionWidget(quest) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.borderColor)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('السؤال ${quest['id']}:'),
          Text(quest['question'], style: Theme
              .of(context)
              .textTheme
              .titleMedium,),
        ],
      ),
    );
  }

  _answerList() {
    return Column(
      children: questions[currentQuest]['options'].map<Widget>(
              (e) => _answerBtn(e)
      ).toList(),
    );
  }

  Widget _answerBtn(String answer) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        child: ElevatedButton(child: Text(answer), onPressed: () {
          setState(() => questions[currentQuest]['answer'] = answer);
        },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(10),
              shape: StadiumBorder(
                  side: BorderSide(color: AppColors.borderColor)),
              backgroundColor: questions[currentQuest]['answer'] == answer ? AppColors.primaryColor : Colors.white,
              foregroundColor: questions[currentQuest]['answer'] == answer ? Colors.white : Colors.black,
          ),)
    );
  }

  Widget nextBackBtn(bool isNext, Function function) {
    return IconButton(onPressed: () => function(),
      icon: isNext ? Icon(Icons.arrow_circle_right_rounded) : Icon(
          Icons.arrow_circle_left),
      iconSize: 40,
      color: AppColors.primaryColor,);
  }

  void endExamDialog(){
    showDialog(context: context, barrierDismissible: false, builder: (context)=>
        AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: ()=> Navigator.pop(context),
                    child: const Icon(Icons.close, size: 40, color: Colors.black,)),
                Text('', style: Theme.of(context).textTheme.titleMedium,),
                SizedBox(width: 40,)
              ],),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('هل انت متأكد من انك تريد ارسال الاجابات', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomElevatedButton(title: 'تأكيد', function: (){
                      final navigator = Navigator.of(context);
                      navigator.pop();
                      navigator.pop();
                    }),
                    CustomElevatedButton(title: 'الغاء', function: (){}, color: AppColors.cancelColor,),
                  ],
                )
              ],
            )
        ));
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      remainTimer = remainTimer - const Duration(seconds: 1);
      setState(() {});
    });
  }
}