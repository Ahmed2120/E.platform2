import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../pages/components/custom_elevated_button.dart';
import '../../../widgets/custom_stack.dart';
import '../../../widgets/text_fields/change_value_field.dart';

class TeacherQuestionPage extends StatelessWidget {
  TeacherQuestionPage({Key? key}) : super(key: key);

 final List<Map<String, dynamic>> questions = [
    {
      'studentName': '',
      'quest': '',
      'ans': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomStack(
        pageTitle: 'الاسئلة',
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: questions.length,
              separatorBuilder: (context, index)=> const SizedBox(height: 13,),
              itemBuilder: (context, index)=> questContainer(
                studentName: questions[index]['studentName'],
                  quest:questions[index]['quest'],
                  onChange: (val){
                questions[index]['ans'] = val;
              } ),
            ),

            const SizedBox(height: 20,),
            CustomElevatedButton(title: 'ارسال',function:(){},),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }

  Widget questContainer({required String quest, required String studentName, required Function onChange, }){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/icons/questions 2.png'),
                const SizedBox(width: 20,),
                Column(
                  children: [
                    Text(studentName),
                    const SizedBox(height: 5,),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: Text(quest),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 15,),
            ChangeValueField(hintText: 'اكتب الاجابة هنا', onChange: onChange, input: TextInputType.text,)
          ],
        ),
      ),
    );
  }
}
