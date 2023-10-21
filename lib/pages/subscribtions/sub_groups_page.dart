import 'package:eplatform/model/group/group.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/courses_and_groups/book_appointment_page.dart';
import 'package:eplatform/pages/subscribtions/sub_groupsContant_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/group/teacherGroups.dart';
import '../../widgets/custom_stack.dart';


class SubGroupsPage extends StatelessWidget {
  SubGroupsPage({required this.model,required this.group,  Key? key}) : super(key: key);
  MainModel model;
  Group group;

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    model.fetchTeacherGroup(group.TeacherId, group.SubjectId);

    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
          builder:(context,child,MainModel model){
            return CustomStack(
              pageTitle: 'اشتراكاتي',
              child: model.TeacherGroupsLoading==true?
               Center(child: CircularProgressIndicator())
               : Column(
                  children: [
               CircleAvatar(radius: 30, child: Image.asset('assets/images/teacher.png')),
               Text(model.groupTeacherName, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
               const SizedBox(height: 12,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   descriptionContainer(model.groupSubjectName, 'assets/icons/book-description.png'),
                   descriptionContainer(model.groupGradeName, 'assets/icons/level-description.png'),
                   descriptionContainer('مجموعات', 'assets/icons/course-description.png'),
                 ],
               ),
               const SizedBox(height: 12,),
               const SizedBox(height: 12,),
               model.TeacherGroupsList.length>0?
               ListView.builder(
                 shrinkWrap: true,
                 itemCount: model.TeacherGroupsList.length,
                 itemBuilder: (context, index)=> InkWell(
                     onTap: (){ GlobalMethods.navigate(context,
                         SubGroupsContentPage(model, teacherName:model.groupTeacherName,
                             subName:model.groupSubjectName,gradeName:model.groupGradeName, groupName: model.TeacherGroupsList[index].Title, groupId: model.TeacherGroupsList[index].GroupId,));
                         //    model.fetchGroupDetails(model.TeacherGroupsList[index].GroupId);
                     },
                     child: groupContainer(context,model.TeacherGroupsList[index]  )

                 ),
               ):
               Image.asset('assets/images/no_data.png'),

                  ],
                ),
      ); })
    );
  }

  Container groupContainer(context, TeacherGroups teacherGroups) {
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
               Text(teacherGroups.Title, style: TextStyle(fontSize: 14, color: Colors.black),),
              Text((teacherGroups.AvailablePlaces.toString()+'/'+teacherGroups.Limit.toString()+'طالب'),
                style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
          const Spacer(),
          Column(
            children:  [
              Text( GlobalMethods.showPrice(teacherGroups.Price)),
              Text(teacherGroups.SessionsCount.toString()+' حصة'),
            ],
          ),
        ],
      ),
    );
  }

  Container descriptionContainer(String title, String img) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontSize: 10, color: AppColors.descriptionColor),),
          const SizedBox(width: 5,),
          ImageIcon(AssetImage(img)),
        ],
      ),
    );
  }

  Widget subSubjectContainer() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.primaryColor),
      // color: Colors.white
    ),
    child: const Center(child: Text('نحو', style: TextStyle(fontSize: 12),)),
  );

  Widget courseContainer(context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/teacher.png', width: 50, height: 50,),
        const Text('كورس أ/ عاطف محمود', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
        const Text('لغة عربية ', style: TextStyle(color: Color(0xFF888B8E)),),
        ElevatedButton(onPressed: (){}, child: const Text('اشترك الان'))
      ],
    ),
  );

  ElevatedButton buildElevatedButton(String title, Function function) {
    return ElevatedButton(
      onPressed: () => function(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(40),
      ),
      child: Text(title),
    );
  }
}

