import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';

import '../../../../core/utility/app_colors.dart';
import 'student_requests_content_page.dart';

class StudentAddRequestsPage extends StatelessWidget {
  StudentAddRequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'طلبات الاضافة للطلاب',
        child: ListView(
          shrinkWrap: true,
          children: [

            ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index)=>
                  InkWell(
                    onTap: ()=> GlobalMethods.navigate(context, StudentRequestsContentPage()),
                      child: studentContainer(context,
                        name: 'احمد ابراهيم',
                        img: 'assets/images/student-profile.png'
                        ,)),

            ),

            const SizedBox(height: 15,),

          ],
        ),
      ),
    );
  }

  Container studentContainer(context, {
    required String name,
    required String img,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      decoration: BoxDecoration(
        border: const Border(right: BorderSide(color: AppColors.primaryColor, width: 5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(img, width: 70,),
          const SizedBox(width: 8,),
          Column(
            children: [
              Text(name, style: Theme.of(context).textTheme.titleMedium,),
              const SizedBox(height: 5,),
              Text('يريد الانضمام الى مجموعتك', style: Theme.of(context).textTheme.titleSmall,),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10)
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
          ),
        ],
      ),
    );
  }

}