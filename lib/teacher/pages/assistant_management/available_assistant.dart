import 'dart:io';

import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/pages/courses_and_groups/groups_page.dart';
import 'package:eplatform/widgets/chat/user_img.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../../core/utility/app_colors.dart';
import '../../../model/mainmodel.dart';
import 'add_assistant_page.dart';

class AvailableAssistantPage extends StatefulWidget {
  AvailableAssistantPage({Key? key, required this.model}) : super(key: key);

  final MainModel model;

  @override
  State<AvailableAssistantPage> createState() => _AvailableAssistantPageState();
}

class _AvailableAssistantPageState extends State<AvailableAssistantPage> {

  @override
  void initState() {
    super.initState();

    widget.model.fetchAssistantTeachers();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        // pageTitle: 'اضافة مساعد',
        pageTitle: 'المدرسين',
        child: ScopedModelDescendant<MainModel>(
            builder:(context,child,MainModel model){
            return model.assistTeacher_loading ? const Center(child: CircularProgressIndicator(),) : ListView.builder(
              shrinkWrap: true,
              itemCount: model.assistantTeachers.length,
              itemBuilder: (context, index)=>
                  InkWell(
                    // onTap: ()=> GlobalMethods.navigate(context, AddAssistantPage(assistantId: 1,)),
                    onTap: ()=> model.addAssistantRequest(teacherId: model.assistantTeachers[index].Id),
                      child: assistantContainer(context,
                        name: model.assistantTeachers[index].Name,
                        img: model.assistantTeachers[index].ProfileImage,
                        )),

            );
          }
        ),
      ),
    );
  }

  Container assistantContainer(context, {
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
          UserImg(img: img, ),
          const SizedBox(width: 8,),
          Text(name, style: Theme.of(context).textTheme.titleMedium,),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(15)
            ),
            child: const Text('اضافة', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}