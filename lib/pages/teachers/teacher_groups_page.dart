import 'package:eplatform/model/group/group.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/courses_and_groups/book_appointment_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/group/teacherGroups.dart';
import '../courses_and_groups/group_content_page.dart';

class TeacherGroupsPage extends StatelessWidget {
  TeacherGroupsPage({required this.model,required this.teacherId,  Key? key}) : super(key: key);
  MainModel model;
  int teacherId;


  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    model.fetchTeacherGroup(teacherId, null);

    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
          builder:(context,child,MainModel model){
            return SafeArea(
              child: Stack(
                children: [
               Container(
               width: double.infinity,
               height: MediaQuery.of(context).size.height,
               color: AppColors.primaryColor,
            ),
               Container(
                 padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  margin: EdgeInsets.only(top: deviceSize.height * 0.08),
                 width: double.infinity,
                 height: MediaQuery.of(context).size.height,
                 decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
              ),

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
                     Expanded(
                       child: ListView.builder(
                         shrinkWrap: true,
                         itemCount: model.TeacherGroupsList.length,
                         itemBuilder: (context, index)=> InkWell(
                             onTap: ()=> GlobalMethods.navigate(context,
                                 GroupContentPage( model:model,teacherGroups: model.TeacherGroupsList[index],
                                   index: index,)),
                             child: groupContainer(context,model.TeacherGroupsList[index]  )),
                       ),
                     ),
                     const SizedBox(height: 12,),
                     buildElevatedButton('احجز موعد', ()=>
                         GlobalMethods.navigate(context,
                             BookAppointmentPage(teacherId:
                             model.TeacherPrivateGroupList[0].TeacherId ,
                               teacherName: model.TeacherPrivateGroupList[0].TeacherName ,
                             ))),
                   ],
                 ),
                 ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 32.0),
                        const Text('كورسات ومجموعات', style: TextStyle(fontSize: 20, color: Colors.white, height: 1.5, fontWeight: FontWeight.bold)),

                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: InkWell(onTap: ()=> Navigator.pop(context),
                              child: const Icon(Icons.arrow_forward_ios_sharp,
                                color: AppColors.primaryColor, size: 15,)),
                        )
                      ],
                    ),
                  ),
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
               Text(teacherGroups.Title, style: TextStyle(fontSize: 14, color: Colors.black),),
              Text((teacherGroups.AvailablePlaces.toString()+'/'+teacherGroups.Limit.toString()+'طالب'),
                style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
          const Spacer(),
          Column(
            children:  [
              Text( teacherGroups.Price.toString()),
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

