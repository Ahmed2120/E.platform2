import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../core/utility/app_colors.dart';

class AnswerPage extends StatelessWidget {
  AnswerPage({Key? key}) : super(key: key);

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
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
              child: Column(
                children: [
                  Row(
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
                  SizedBox(height: deviceSize.height * 0.07,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index)=> answerContainer(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ElevatedButton(onPressed: (){}, child: Text('حاول مرة اخرى')),
                  ),
                  SizedBox(height: 10,),
                ],
              ),),
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('اجابة السؤال الاول :', style: Theme.of(context).textTheme.bodyLarge,),
        Text('كم مرة ذكر سيدنا هارون في القرآن؟', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),),
        Text('أ- اربع مرات', style: Theme.of(context).textTheme.titleSmall,),
        Text('اجابة صحيحة '),
      ],
    ),
  );
}