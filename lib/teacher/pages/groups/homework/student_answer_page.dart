import 'dart:io';

import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/pages/courses_and_groups/groups_page.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utility/app_colors.dart';
import '../../../../core/utility/global_methods.dart';
import '../../../../model/customModel.dart';
import '../../../../widgets/drop_downs/custom_dropdown.dart';
import '../../../../widgets/dialogs/ok_dialog.dart';
import '../../../../widgets/text_fields/change_value_field.dart';
import '../../teacher_create_exam/teacher_create_exam.dart';

class StudentAnswerPage extends StatefulWidget {
  StudentAnswerPage({Key? key}) : super(key: key);

  @override
  State<StudentAnswerPage> createState() => _StudentAnswerPageState();
}

class _StudentAnswerPageState extends State<StudentAnswerPage> {
  List<Map<String, dynamic>> questions = [
    {
      'quest': 'كم مرة ذكر سيدنا هارون في القرآن؟',
      'rightAns': 'أ- اربع مرات',
      'ans1': 'أ- اربع مرات',
      'ans2': 'ب- ثلاث مرات',
      'ans3': 'ج-مرتان',
      'ans4': 'د-خمس مرات',
      'questScore': '',
    },
    {
      'quest': 'كم مرة ذكر سيدنا هارون في القرآن؟',
      'rightAns': 'أ- اربع مرات',
      'ans1': 'أ- اربع مرات',
      'ans2': 'ب- ثلاث مرات',
      'ans3': 'ج-مرتان',
      'ans4': 'د-خمس مرات',
      'questScore': '',
    },
    {
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
        pageTitle: 'اجابة الواجب',
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'الاسم: احمد اشرف',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 8,
            ),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: questions.length,
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('السؤال ' + (index + 1).toString()),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          questions[index]['quest'],
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                questions[index]['ans1'],
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                questions[index]['ans2'],
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                questions[index]['ans3'],
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                questions[index]['ans4'],
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 10,
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الاجابة:',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                questions[index]['rightAns'],
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الدرجة',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(
                              width: 200,
                              child: ChangeValueField(
                                  hintText: '',
                                  onChange: (val) {
                                    questions[index]['questScore'] = val;
                                  },input:  TextInputType.number),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
                title: 'تم',
                function: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => OkDialog(
                            title: 'سيتم ارسال النتيجة للطالب ',
                            loading: false,
                            onConfirm: () => Navigator.pop(context),
                          ));
                }),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
