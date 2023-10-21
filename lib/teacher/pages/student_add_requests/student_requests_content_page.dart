import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../../core/utility/app_colors.dart';
import '../../../core/utility/global_methods.dart';
import '../available_groups_page.dart';

class StudentRequestsContentPage extends StatelessWidget {
  StudentRequestsContentPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomStack(
        pageTitle: 'طلبات الاضافة للطلاب',
        child: ListView(
          shrinkWrap: true,
          children: [

            const SizedBox(height: 12,),
            Text('اسم الطالب',
              style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.right,),

            const SizedBox(height: 8,),
            Text('محمود علاء',
              style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            Divider(color: AppColors.borderColor,),

            Text('المادة',
              style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.right,),

            const SizedBox(height: 8,),
            Text('لغة عربية',
              style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            Divider(color: AppColors.borderColor,),

            Text('المرحلة الدراسية',
              style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.right,),

            const SizedBox(height: 8,),
            Text('الصف الثالث الثانوي',
              style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            Divider(color: AppColors.borderColor,),

            Text('نوع الاشتراك',
              style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.right,),

            const SizedBox(height: 8,),
            Text('مجموعة',
              style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            Divider(color: AppColors.borderColor,),

            Text('مدة الاشتراك',
              style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.right,),

            const SizedBox(height: 8,),
            Text('شهر',
              style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            Divider(color: AppColors.borderColor,),

            Text('التوقيت',
              style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.right,),

            const SizedBox(height: 8,),
            Text('صباحا',
              style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            Divider(color: AppColors.borderColor,),

            Text('نوع التعليم',
              style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.right,),

            const SizedBox(height: 8,),
            Text('عربي',
              style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            Divider(color: AppColors.borderColor,),

            Text('نوع المنهج',
              style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.right,),

            const SizedBox(height: 8,),
            Text('مصري',
              style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            Divider(color: AppColors.borderColor,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomElevatedButton(title: 'قبول', function: ()=> GlobalMethods.navigate(context, TeacherAvailableGroupsPage())),
                CustomElevatedButton(title: 'رفض', color: Colors.red, function: (){}),
              ],
            )
          ]
        ),
      ),
    );
  }

}

