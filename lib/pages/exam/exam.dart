import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eplatform/api/api.dart';
import 'package:eplatform/api/teacherCall.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../core/utility/app_colors.dart';
import '../../model/exam/exam_question.dart';
import '../../model/teacherModels/teacher_examDetails.dart';
import '../../widgets/dialogs/alertMsg.dart';
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

  List<Map> examAnswers = [];

  bool _Loading = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async{
    await widget.model.fetchStudentExamById(24);
    startTimer(widget.model.examQuestion?.ExamDuration);

    if(widget.model.examQuestion!.ExamQuestions != null) {
      for (var i in widget.model.examQuestion!.ExamQuestions!) {
        examAnswers.add(
            {
              "QuestionId": i.QuestionId,
              "Answer": ""
            }
        );
      }
    }
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
      body: ScopedModelDescendant<MainModel>(
          builder:(context,child,MainModel model){
          return CustomStack(
            pageTitle: 'ffff',
            child: model.examQuestionLoading
                ? const Center(child: CircularProgressIndicator(),)
                : Column(
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
                      _questionWidget(model.examQuestion!.ExamQuestions![currentQuest], currentQuest),
                      _answerList(model.examQuestion!.ExamQuestions![currentQuest]),
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
                                    model.examQuestion!.ExamQuestions!.length - 1) currentQuest++;
                              })),
                        ],),
                      Center(
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: model.examQuestion!.ExamQuestions!.length,
                            itemBuilder: (context, index) => questNum(index),
                          ),
                        ),
                      ),
                      CustomElevatedButton(
                          function: timer!.isActive?() =>endExamDialog():(){},
                          title: ' انهاء الاختبار'),
                    ],
                  ),
                )
              ],
            ),
          );
        }
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

  Widget _questionWidget(ExamQuestion quest, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.borderColor)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('السؤال $index:'),
          Text(quest.Text??'', style: Theme
              .of(context)
              .textTheme
              .titleMedium,),
        ],
      ),
    );
  }

  _answerList(ExamQuestion quest) {
    return Column(
      children: quest.Choices.map<Widget>(
              (e) => _answerBtn(e.ChoiceText??'')
      ).toList(),
    );
  }

  Widget _answerBtn(String answer) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        child: ElevatedButton(child: Text(answer), onPressed: () {
          setState(() => examAnswers[currentQuest]['Answer'] = answer);
        },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(10),
              shape: StadiumBorder(
                  side: BorderSide(color: AppColors.borderColor)),
              backgroundColor: examAnswers[currentQuest]['Answer'] == answer ? AppColors.primaryColor : Colors.white,
              foregroundColor: examAnswers[currentQuest]['Answer'] == answer ? Colors.white : Colors.black,
          ),)
    );
  }

  Widget nextBackBtn(bool isNext, Function function) {
    return IconButton(onPressed: () => function(),
      icon: isNext ? const Icon(Icons.arrow_circle_right_rounded) : const Icon(
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
                const SizedBox(width: 40,)
              ],),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('هل انت متأكد من انك تريد ارسال الاجابات', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _Loading ? const Center(child: CircularProgressIndicator(),)
                        : CustomElevatedButton(title: 'تأكيد', function: () async{
                      await _submitExamAnswer();
                      final navigator = Navigator.of(context);
                      navigator.pop();
                      navigator.pop();
                    }),
                    CustomElevatedButton(title: 'الغاء', function: (){
                      Navigator.pop(context);
                    }, color: AppColors.cancelColor,),
                  ],
                )
              ],
            )
        ));
  }

  void startTimer(int? duration) {
    remainTimer = Duration(minutes: duration??1);

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if(remainTimer.inSeconds > 0) {
        remainTimer = remainTimer - const Duration(seconds: 1);
      }else{
        endExam();
        stopTimer();
      }
      setState(() {});
    });
  }

  void stopTimer() {


    timer?.cancel();
  }

  endExam()async{
    _submitExamAnswer();

    AwesomeDialog(
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.warning,
      body: const Center(child: Text(
        'الوقت انتهى',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
      ),),
      title: 'This is Ignored',
      desc:   'This is also Ignored',
      btnOkOnPress: (){
        Navigator.pop(context);
      },
    ).show();
  }

  Future _submitExamAnswer()  async{

    setState(() {
      _Loading=true;
    });




    Map data={
      "ExamId": widget.model.examQuestion!.ExamId,
      "QuestionAnswers": examAnswers
    };
    print('data   '+data.toString());
    try {
      var response = await TeacherCall().postData(json.encode(data), "/api/StudentExam/SubmitExamAnswer", 1);
      var body = json.decode(response.body);
      print ('body '+body.toString());

      if (response != null && response.statusCode == 200) {
        if(body['Success']) {

          ShowMyDialog.showMsg("تم إرسال الاجابات بنجاح");


           Navigator.of(context).pop();
        }
      }
      else {
        ShowMyDialog.showMsg(body['Message']);
      }
      setState(() {
        _Loading=false;
      });
    }
    catch(e){
      setState(() {
        _Loading=false;
      });
      print(' add Group  ee '+e.toString());
    }
  }
}