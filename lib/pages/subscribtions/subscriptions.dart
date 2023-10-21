import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/pages/subscribtions/sub_groups_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../core/utility/app_colors.dart';
import '../../model/courses/course.dart';
import '../../model/group/group.dart';
import '../../model/subject/subject.dart';
import '../components/row_title.dart';
import '../courses_and_groups/coursesAndGroups_page.dart';
import 'sub_course_content_page.dart';
import 'sub_groupsContant_page.dart';


class Subscriptions extends StatefulWidget {
   Subscriptions( { required this.model,Key? key}) : super(key: key);
     MainModel model;

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {

  ContentType type = ContentType.course;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.fetchStudentSubscriptions(null);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ScopedModelDescendant<MainModel>(
            builder:(context,child,MainModel model){
              return Stack(
               children: [
                Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: AppColors.primaryColor,
                 ),
                Container(
              margin: EdgeInsets.only(top: deviceSize.height * 0.08),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
              ),
                 child:  Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child:
                  Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 130,
                      child: model.subLoading==true?
                      const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: model.allSubjects.length,
                        itemBuilder: (context, index)=> subjectContainer(context,    model.allSubjects[index] ),
                      ),
                    ),
                    Container(
                      height: 60,
                      child: model.branchLoading==true? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.model.allBranches.length,
                        itemBuilder: (context, index)=>
                            subSubjectContainer(widget.model.allBranches[index]),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(onTap: () =>
                            setState(() {
                              type = ContentType.course;
                            }),child: Text('كورساتي', style: TextStyle(fontSize: 17, color: typeColor(ContentType.course)),)),
                        GestureDetector(onTap: () =>
                            setState(() {
                              type = ContentType.group;
                            }),child: Text('مجموعاتي', style: TextStyle(fontSize: 17, color: typeColor(ContentType.group)),)),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    // ---------------------- courses ------------------
                    if (type == ContentType.course) model.StudentSubscriptionsLoading==true?
                    const Center(child: CircularProgressIndicator())
                        : Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 9.0,
                          mainAxisSpacing: 9.0,
                          childAspectRatio: 0.9
                        ),
                              itemCount: model.StudentSubscriptionsCoursesList.length,
                        itemBuilder: (context, index)=> courseContainer(context ,
                            model.StudentSubscriptionsCoursesList[index], onStart: ()=>
                            GlobalMethods.navigate(context, SubCourseContentPage(model:model ,
                              course: model.StudentSubscriptionsCoursesList[index] ,
                            ))),
                      ),
                    )

                    // ---------------------- groups ------------------
                    else Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 9.0,
                          mainAxisSpacing: 9.0,
                          childAspectRatio: 0.9

                        ),
                        itemCount: model.StudentSubscriptionsGroupsList.length,
                        itemBuilder: (context, index)=>
                            groupContainer(context ,model.StudentSubscriptionsGroupsList[index], onStart: ()=>
                                GlobalMethods.navigate(context, SubGroupsPage(model:model,group:model.StudentSubscriptionsGroupsList[index] ,))),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    type == ContentType.course ? CustomElevatedButton(title: 'متجر الكورسات', function: (){
                      GlobalMethods.navigate(context, CoursesAndGroupsPage(
                        model: model, ));
                    }) : CustomElevatedButton(title: 'متجر المجموعات', function: (){
                      GlobalMethods.navigate(context, CoursesAndGroupsPage(model: model, flag: 1,))  ;
                    }),
                    const SizedBox(height: 10,),
                  ],
                ),),
            ),

                 const CustomRowTitle(title: 'اشتراكاتي',),
          ],
        );}),
      ),
    );
  }

  Widget subjectContainer(context,Subject subject) => InkWell(
    onTap: (){
      widget.model.fetchStudentSubscriptions(subject.Id);
      widget.model.fetchgroups(subject.Id, '');
      widget.model.fetchBranch(subject.Id);
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
        Text(subject.Name, style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,)
      ],
    ),
  );

  Widget subSubjectContainer(CustomModel subject) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.primaryColor),
      // color: Colors.white
    ),
    child:  Center(child: Text(subject.Name)),
  );


  Widget courseContainer(context,Course course, {required Function onStart}) => Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        course.TeacherPicture==''?
        Image.asset('assets/images/teacher.png', width: 50, height: 50,):
        Image.network(course.TeacherPicture!, width: 50, height: 50,),
        Text(course.TeacherName!, style: const TextStyle(fontSize: 15,
            fontWeight: FontWeight.bold, color: Colors.black),),
         Text(course.SubjectName, style: const TextStyle(color: Color(0xFF888B8E)),),
        ElevatedButton(onPressed: ()=> onStart(), child: const Text('ابدا'))
      ],
    ),
  );

  Widget groupContainer(context,Group group, {required Function onStart}) => Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        group.TeacherPicture==''?
        Image.asset('assets/images/teacher.png', width: 50, height: 50,):
        Image.network(group.TeacherPicture!, width: 50, height: 50,),
        Text(group.TeacherName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
         Text(group.SubjectName, style: const TextStyle(color: Color(0xFF888B8E)),),
        ElevatedButton(onPressed: ()=> onStart(), child: const Text('ابدا'))
      ],
    ),
  );

  Color typeColor(ContentType contentType){
    if(contentType == type) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }
}

enum ContentType{
  course,
  group

}




