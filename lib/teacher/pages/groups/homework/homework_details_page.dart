import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';

import '../../../../core/utility/app_colors.dart';
import '../../../../core/utility/global_methods.dart';
import 'homework_srudents_page.dart';

class HomeWorkDetailsPage extends StatefulWidget {
  HomeWorkDetailsPage({Key? key}) : super(key: key);

  @override
  State<HomeWorkDetailsPage> createState() => _HomeWorkDetailsPageState();
}

class _HomeWorkDetailsPageState extends State<HomeWorkDetailsPage> {

  List<Map<String, dynamic>> questions = [
    {
      'quest': 'كم مرة ذكر سيدنا هارون في القرآن؟',
      'rightAns': 'أ- اربع مرات',
      'ans1': 'أ- اربع مرات',
      'ans2': 'ب- ثلاث مرات',
      'ans3': 'ج-مرتان',
      'ans4': 'د-خمس مرات',
      'questScore': '',
    },{
      'quest': 'كم مرة ذكر سيدنا هارون في القرآن؟',
      'rightAns': 'أ- اربع مرات',
      'ans1': 'أ- اربع مرات',
      'ans2': 'ب- ثلاث مرات',
      'ans3': 'ج-مرتان',
      'ans4': 'د-خمس مرات',
      'questScore': '',
    },{
      'quest': 'كم مرة ذكر سيدنا هارون في القرآن؟',
      'rightAns': 'أ- اربع مرات',
      'ans1': 'أ- اربع مرات',
      'ans2': 'ب- ثلاث مرات',
      'ans3': 'ج-مرتان',
      'ans4': 'د-خمس مرات',
      'questScore': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'واجب الحصة الاولى',
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: questions.length,
                  separatorBuilder: (context, index)=> const SizedBox(height: 10,),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('السؤال '+ (index+1).toString()),
                          const SizedBox(height: 5,),
                          Text(questions[index]['quest'], style: Theme.of(context).textTheme.headlineLarge,),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                child: Text(questions[index]['ans1'], style: Theme.of(context).textTheme.bodySmall,),
                              ),
                              const SizedBox(width: 8,),
                              Expanded(
                                child: Text(questions[index]['ans2'], style: Theme.of(context).textTheme.bodySmall,),
                              ),

                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                child: Text(questions[index]['ans3'], style: Theme.of(context).textTheme.bodySmall,),
                              ),
                              const SizedBox(width: 8,),
                              Expanded(
                                child: Text(questions[index]['ans4'], style: Theme.of(context).textTheme.bodySmall,),
                              ),
                            ],
                          ),
                          const Divider(height: 10, thickness: 2,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('الاجابة الصحيحة:', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                              SizedBox(
                                width: 200,
                                child: Text(questions[index]['rightAns'], style: Theme.of(context).textTheme.bodySmall,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
            const SizedBox(height: 10,),
            CustomElevatedButton(title: 'اجابات الطلاب', function: ()=> GlobalMethods.navigate(context, HomeWorkStudentsPage())),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}