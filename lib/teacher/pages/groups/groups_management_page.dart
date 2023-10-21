import 'dart:convert';

import 'package:eplatform/api/api.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/model/teacherModels/teacherCreatedGroup.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:eplatform/widgets/dialogs/alertMsg.dart';
import 'package:eplatform/widgets/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../core/utility/app_colors.dart';
import '../../../model/subject/subject.dart';
import '../../../pages/components/row_title.dart';
import '../../../session/userSession.dart';
import '../../../widgets/drop_downs/custom_dropdown.dart';
import '../create_group/create_group_page.dart';
import 'componant/deleteIconButton.dart';
import 'teacher_groups_content.dart';


class GroupsManagementPage extends StatefulWidget {
  GroupsManagementPage( { required this.model, Key? key}) : super(key: key);
  MainModel model;

  @override
  State<GroupsManagementPage> createState() => _GroupsManagementPageState();
}

class _GroupsManagementPageState extends State<GroupsManagementPage> {

  CustomModel? teacher;
  CustomModel? educationType;
  CustomModel? educationLevel;
  CustomModel? curriculumType;
  int ? _selectedSubectId;


   @override
  void initState() {
  //   // TODO: implement initState
     super.initState();
     widget.model.fetchTeacherEducationType();
     widget.model.fetchTeacherEducationLevels();
   }

  @override
  Widget build(BuildContext context) {
    widget.model.fetchAllTeacherCreatedGroup(
      _selectedSubectId,
      educationType==null?null: educationType!.Id,
      educationLevel==null?null :educationLevel!.Id,);
    final deviceSize = MediaQuery.of(context).size;

    return  ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return  Scaffold(
          body: CustomStack(
            pageTitle: 'المجموعات',
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                 //   Expanded(child: CustomDropDown([], (){}, teacher, 'اسم المدرس'),),

                    Expanded(child:  model.customEducationType?
                     const Center(child: CircularProgressIndicator()):
                     CustomDropDown(model.allCustomEducationType,
                        changeEducationType, educationType, 'نوع التعليم'),),
                    const SizedBox(width: 8,),

                     Expanded(child: model.customEducationProgramsLoading?const Center(child: CircularProgressIndicator()):
                       CustomDropDown(model.allCustomEducationPrograms,
                        change_educationPrograms, curriculumType, 'نوع المنهج'),),
                  ],
                ),
                const SizedBox(height: 8,),
                model.customLevel_loading ?const Center(child: CircularProgressIndicator()):
                CustomDropDown(model.allCustomEducationLevels, selectLevel, educationLevel, 'السنة الدراسية'),
                const SizedBox(height: 10,),
             /*   Row(
                  children: [
                 //   Expanded(child: CustomDropDown([], (){}, curriculumType, 'نوع المنهج'),),
                  //  const SizedBox(width: 8,),
                  ],
                ),
                */
                Container(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.allTeacherSubjects.length,
                    itemBuilder: (context, index)=>
                        subjectContainer(context,model.allTeacherSubjects[index]),
                  ),
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child:
                      model.showAllTeacherCreatedGroupLoading ?
                      Center(child: CircularProgressIndicator())
                  : model.allTeacherCreatedGroups.length >0 ?
                      ListView.builder(
                    shrinkWrap: true,
                      itemCount: model.allTeacherCreatedGroups.length,
                      itemBuilder: (context, index)=>
                          InkWell(onTap: ()=>GlobalMethods.navigate(context,
                              TeacherGroupsContentPage(
                                model: model,
                                group_title:
                              model.allTeacherCreatedGroups[index].Title,
                              groupId:model.allTeacherCreatedGroups[index].GroupId,)),

                              child: groupContainer(context, model.allTeacherCreatedGroups[index],index
                              ))):
                      Image.asset('assets/images/no_data.png'),
                ),

                if(UserSession.hasPrivilege(4)) CustomElevatedButton(title: 'اضافة مجموعة',
                    function: ()=> GlobalMethods.navigate(context, CreateGroupPage(model: model,))),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        );
      }
    );
  }

  changeEducationType(val){
    educationType=val;
    widget.model.fetchTeacherEducationPrograms(educationType!);
    curriculumType=null;
    setState(() {

    });
  }
  selectLevel(val){
    educationLevel=val;
    setState(() {
    });
  }
  change_educationPrograms(val){
    curriculumType=val;
    setState(() {

    });
  }

  Widget subjectContainer(context,CustomModel sub) =>
      InkWell(
        onTap: (){
          print('object');
          setState(() {
            _selectedSubectId=sub.Id;
          });
          setState(() {

          });
       },
      child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFBBDDF8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset('assets/icons/arabic_book.png', width: 40, height: 40,),
        ),
        Text(sub.Name, style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,)
      ],
    ),
  );

  Widget groupContainer(context,TeacherCreatedGroup teacherCreatedGroup,int index) {
    final String st = teacherCreatedGroup.StudentsCount > 1 ? 'طلاب' : 'طالب';

    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric( vertical: 5, horizontal: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 5,
                color: Colors.grey
            )
          ]
      ),
      child: Row(
        children: [
          Image.asset('assets/images/notification.png', width: 40, height: 40,),
          const SizedBox(width: 6,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(teacherCreatedGroup.Title, style: const TextStyle(fontSize: 14, color: Colors.black),),
              Text(teacherCreatedGroup.StudentsCount.toString()+st, style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
          const Spacer(),
          Text(teacherCreatedGroup.SessionsCount.toString()+' حصة'),
         /*  Column(
            children:  [
              Text('50'+' \$'),
            ],
          ),
          */
              //  widget.model.deleteTeacherCreatedGroupLoading? CircularProgressIndicator():
                     IconButton(onPressed: (){
                       if(!UserSession.hasPrivilege(6)) {
                         ShowMyDialog.showMsg(
                             'You do not have the authority');
                         return ;
                       }
                      //  _deleteTeacherCreatedGroup(teacherCreatedGroup.GroupId, index);
                       showDialog(
                           context: context,
                           barrierDismissible: false,
                           builder: (context) => DeleteDialog(
                               title: 'هل تريد حذف مجموعة _ ${widget.model.allTeacherCreatedGroups[index].Title} ؟',
                               onConfirm: () {
                                 widget.model.deleteTeacherCreatedGroup(teacherCreatedGroup.GroupId, index);
                               },
                               loading: false));


                        },
                         icon: Icon(Icons.delete, color: Colors.red,))
             //  DeleteIconButton(onPressed: widget.model.deleteTeacherCreatedGroup(teacherCreatedGroup.GroupId, index)
               //        ,isLoading:model.deleteTeacherCreatedGroupLoading ),
        ],
      ),
    );
  }



}




