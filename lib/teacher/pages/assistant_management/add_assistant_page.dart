import 'dart:convert';

import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../api/teacherCall.dart';
import '../../../core/utility/app_colors.dart';
import '../../../pages/components/custom_elevated_button.dart';
import '../../../widgets/dialogs/alertMsg.dart';

class AddAssistantPage extends StatefulWidget {
  const AddAssistantPage({Key? key, required this.assistantId})
      : super(key: key);

  final int assistantId;

  @override
  State<AddAssistantPage> createState() => _AddAssistantPageState();
}

class _AddAssistantPageState extends State<AddAssistantPage> {
  List<Authorization> authorizations = [
    Authorization(1, 'انشاء كورس ', false),
    Authorization(2, 'تعديل كورس ', false),
    Authorization(3, 'حذف كورس ', false),
    Authorization(4, 'انشاء مجموعة  ', false),
    Authorization(5, 'تعديل مجموعة', false),
    Authorization(6, 'حذف مجموعة', false),
    Authorization(7, 'انشاء اختبار', false),
    Authorization(8, 'تعديل اختبار', false),
    Authorization(9, 'حذف اختبار', false),
    Authorization(11, 'تصحيح اختبار', false),
    Authorization(12, 'انشاء لايف', false),
    Authorization(13, 'تعديل لايف', false),
    Authorization(15, 'حذف لايف', false),
    Authorization(16, 'انشاء مذكرة', false),
    Authorization(17, 'تعديل مذكرة', false),
    Authorization(18, 'حذف مذكرة', false),
    Authorization(19, 'انشاء الواجب', false),
    Authorization(20, 'تعديل الواجب', false),
    Authorization(21, 'حذف الواجب', false),
    Authorization(22, 'تصحيح الواجب', false),
    Authorization(23, 'انشاء الاسئلة', false),
    Authorization(24, 'تعديل الاسئلة', false),
    Authorization(25, 'حذف الاسئلة', false),
    Authorization(26, 'انشاء ولي امر ', false),
    Authorization(27, 'حذف ولي امر', false),
    Authorization(28, 'انشاء طالب', false),
    Authorization(29, 'حذف طالب', false),
    Authorization(30, 'انشاء شات مجموعة', false),
    Authorization(31, 'انشاء شات خاص', false),
    Authorization(32, 'مشاهدة درجات الطلاب', false),
    Authorization(33, 'اداء الهام', false),
    Authorization(34, 'انشاء التحديات', false),
    Authorization(35, 'تعديل التحديات', false),
    Authorization(36, 'حذف التحديات', false),
  ];

  List<Map<String, int>> priviliges = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomStack(
        pageTitle: 'ادارة المساعدين',
        child: ListView(
          shrinkWrap: true,
          children: [
            CircleAvatar(
                radius: 40, child: Image.asset('assets/images/teacher.png')),
            Text(
              'احمد حسين',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'رقم الهاتف',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '01129876542',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
            Divider(
              color: AppColors.borderColor,
            ),
            Text(
              'الدولة',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'مصر',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
            Divider(
              color: AppColors.borderColor,
            ),
            Text(
              'نوع التعليم',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'عربي',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
            Divider(
              color: AppColors.borderColor,
            ),
            Text(
              'نوع المنهج',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'مصري',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
            Divider(
              color: AppColors.borderColor,
            ),
            Text(
              'الصلاحيات',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.right,
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 3),
                itemCount: authorizations.length,
                itemBuilder: (context, index) => CheckboxListTile(
                    title: Text(
                      authorizations[index].name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    value: authorizations[index].isActive,
                    onChanged: (val) {
                      authorizations[index].isActive = val!;

                      setState(() {});
                    })),
            const SizedBox(
              height: 15,
            ),
            ScopedModelDescendant<MainModel>(
                builder: (context, child, MainModel model) {
              return model.addPriviligeLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomElevatedButton(
                      title: 'تم',
                      function: () {
                        priviliges = [];
                        for (var e in authorizations) {
                          if (e.isActive)
                            priviliges
                                .add({'AssistantId': widget.assistantId, 'PriviligeId': e.id});
                        }
model.addTeacherAssistantPrivilige(assistantId: widget.assistantId, priviliges: priviliges);
                        print(priviliges);
                      });
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

class Authorization {
  int id;
  String name;
  bool isActive;

  Authorization(this.id, this.name, this.isActive);
}
