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
import 'assistant_content_page.dart';
import 'available_assistant.dart';

class AssistantManagementPage extends StatefulWidget {
  AssistantManagementPage({Key? key, required this.model}) : super(key: key);

  final MainModel model;

  @override
  State<AssistantManagementPage> createState() => _AssistantManagementPageState();
}

class _AssistantManagementPageState extends State<AssistantManagementPage> {

  ContentType type = ContentType.assistant;


  @override
  void initState() {
    super.initState();

    widget.model.fetchAssistants();
    widget.model.fetchAssistantRequests();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'ادارة المساعدين',
        child: Column(
          children: [

            ScopedModelDescendant<MainModel>(
                builder: (context, child, MainModel model) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(onTap: () =>
                        setState(() {
                          type = ContentType.assistant;
                          model.fetchAssistants();

                        }),child: Text('المساعدين', style: TextStyle(fontSize: 17, color: typeColor(ContentType.assistant)),)),
                    GestureDetector(onTap: () =>
                        setState(() {
                          type = ContentType.requests;
                          model.fetchAssistantRequests();
                        }),child: Text(
                      model.assistantRequestList.isNotEmpty ? 'طلبات الاضافة'+ ' (${model.assistantRequestList.length})': 'طلبات الاضافة',
                      style: TextStyle(fontSize: 17, color: typeColor(ContentType.requests)),)),
                  ],
                );
              }
            ),

            if(type == ContentType.assistant) Expanded(
              child: ScopedModelDescendant<MainModel>(
                  builder: (context, child, MainModel model) {
                  return model.assistLoading ? const Center(child: CircularProgressIndicator(),) :
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.assistantList.length,
                    itemBuilder: (context, index)=>
                        InkWell(
                          onTap: ()=> GlobalMethods.navigate(context, AddAssistantPage(assistantId: model.assistantList[index].AssistantId!,)),
                            child: assistantContainer(context,
                              name: model.assistantList[index].AssistantName!,
                              img: model.assistantList[index].Image
                              ,)),

                  );
                }
              ),
            ),

            if(type == ContentType.requests) Expanded(
              child: ScopedModelDescendant<MainModel>(
                  builder: (context, child, MainModel model) {
                  return model.assistRequest_loading ? const Center(child: CircularProgressIndicator(),) :
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.assistantRequestList.length,
                    itemBuilder: (context, index)=>
                        InkWell(
                          onTap: ()=> GlobalMethods.navigate(context, AssistantContentPage(assistant: model.assistantRequestList[index],)),
                            child: assistantContainer(context,
                              name: model.assistantRequestList[index].AssistantName!,
                              img: model.assistantRequestList[index].AssistantImage
                              ,)),

                  );
                }
              ),
            ),

            const SizedBox(height: 15,),
            // CustomElevatedButton(title: 'اضافة مساعد', function: ()=> GlobalMethods.navigate(context, AvailableAssistantPage()),),
            CustomElevatedButton(title: 'اضافة مساعد', function: (){},),
            const SizedBox(height: 15,),

          ],
        ),
      ),
    );
  }

  Container assistantContainer(context, {
    required String name,
    required String? img,
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
          img != null ? UserImg(img: img) : Image.asset( 'assets/images/student-profile.png', width: 70,),
          const SizedBox(width: 8,),
          Text(name, style: Theme.of(context).textTheme.titleMedium,),
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

  Color typeColor(ContentType contentType){
    if(contentType == type) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }

}

enum ContentType{
  assistant,
  requests

}