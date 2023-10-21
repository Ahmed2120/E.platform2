import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:eplatform/widgets/dialogs/confirm_dialog.dart';
import 'package:flutter/material.dart';

import '../../../core/utility/app_colors.dart';
import '../../pages/components/custom_elevated_button.dart';
import 'student_add_requests/student_requests_content_page.dart';

class TeacherAvailableGroupsPage extends StatelessWidget {
  TeacherAvailableGroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'درجات الطلاب',
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'اختر المجموعة التي تريد اضافة احمد حسين فيها',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 8,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) =>
                  InkWell(onTap: () {}, child: groupContainer(context)),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomElevatedButton(
                title: 'اضافة',
                function: () => showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => ConfirmDialog(
                        title: 'سيتم ارسال الطلب للادمن للمراجعة',
                      onConfirm: (){}
                    ))),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget groupContainer(
    context,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(offset: Offset(0, 2), blurRadius: 5, color: Colors.grey)
          ]),
      child: Row(
        children: [
          Image.asset(
            'assets/images/notification.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(
            width: 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'مجموعة أ',
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              Text(
                '3/6 طالب',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text('50' + ' \$'),
              Text('12' + ' حصة'),
            ],
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }

}
