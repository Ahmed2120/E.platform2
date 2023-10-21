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
    Authorization(1, 'اضافة طالب ', false),
    Authorization(1, 'حذف طالب ', false),
    Authorization(2, 'اضافة ولي امر ', false),
    Authorization(3, 'حذف ولي امر  ', false),
    Authorization(4, 'لغة عربية  ', false),
    Authorization(5, 'رياضيات', false),
    Authorization(6, 'منهج مصري', false),
    Authorization(7, 'منهج كويتي', false),
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
                                .add({'AssistantId': 1, 'PriviligeId': e.id});
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
