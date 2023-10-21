import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:flutter/material.dart';

import '../../../../model/mainmodel.dart';
import '../../school/teacher_school_page.dart';

class TeacherNearestSchool extends StatelessWidget {
  const TeacherNearestSchool({required this.model,Key? key}) : super(key: key);
  final MainModel model;
  @override
  Widget build(BuildContext context) {
    final   height= MediaQuery.of(context).size.height;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index)=> InkWell(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFF000000).withOpacity(0.12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 1,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/parent.png',
                  width: 50,
                  height: 50,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: SizedBox(
                  width: 100,
                  child: Text(
                    'مدرسة قاسم امين المشتركة',
                    style: TextStyle(fontSize: 13, color: AppColors.titleColor),
                    maxLines: 3,
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}