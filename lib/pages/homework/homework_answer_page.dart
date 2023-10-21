import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../core/utility/app_colors.dart';

class HomeworkAnswerPage extends StatelessWidget {
  HomeworkAnswerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'اجابة امتحان الوحدة الاولى',
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index)=> answerContainer(context),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  Widget answerContainer(context) => Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderColor))
    ),
    child: Column(
      children: [
        Text('اجابة السؤال الاول :', style: Theme.of(context).textTheme.bodyLarge,),
        Text('كم مرة ذكر سيدنا هارون في القرآن؟', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),),
        Text('أ- اربع مرات', style: Theme.of(context).textTheme.titleSmall,),
        Text('اجابة صحيحة '),
      ],
    ),
  );
}