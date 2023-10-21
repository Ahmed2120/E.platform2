import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../../core/utility/global_methods.dart';
import '../../../../model/mainmodel.dart';
import '../../../../widgets/rateIndecator.dart';
import '../../groups/teacher_groups_content.dart';

class TeacherCourses extends StatelessWidget {
   TeacherCourses({required this.model, Key? key, required this.x}) : super(key: key);
   int x;
   MainModel model;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: x==1?model.teacherHomeGroupList.length :model.teacherHomeCourseList.length,
      itemBuilder: (context, index)=> InkWell(
        onTap: (){
          x==1 ? GlobalMethods.navigate(context, TeacherGroupsContentPage(
            model: model,
            group_title:
          model.teacherHomeGroupList[index].GroupName,
            groupId: model.teacherHomeGroupList[index].GroupId ,) ):null;
        },
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(x==0 ? model.teacherHomeCourseList[index].SubjectPicture :
              model.teacherHomeGroupList[index].SubjectPicture,height: 50,width: 50,),
              SizedBox(height: 6,),
              Text(x==0 ?model.teacherHomeCourseList[index].CourseName
                  :model.teacherHomeGroupList[index].GroupName,
                style: TextStyle(fontSize: deviceSize.height * 0.02,
                    fontWeight: FontWeight.bold, color: Colors.black),maxLines: 1,),
              SizedBox(height: 6,),
              Center(child: RateIndicator(rate: x==0 ?model.teacherHomeCourseList[index].Rate
                  :model.teacherHomeGroupList[index].Rate,
                  itemSize:20)),
            ],
          ),
        ),
      ));
  }
}