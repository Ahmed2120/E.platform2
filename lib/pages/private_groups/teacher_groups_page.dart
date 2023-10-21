import 'package:eplatform/model/privateGroup/PrivateGroup.dart';
import 'package:eplatform/pages/courses_and_groups/book_appointment_page.dart';
import 'package:flutter/material.dart';

import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/mainmodel.dart';
import 'pri_group_content_page.dart';

class TeacherGroupsPage extends StatelessWidget {
  TeacherGroupsPage({ required this.model,Key? key}) : super(key: key);
  MainModel model;
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    
    return Scaffold(
      body: SafeArea(
                child: Stack(
                  children: [
                   Container(
                  width: double.infinity,
                 height: MediaQuery.of(context).size.height,
                 color: AppColors.primaryColor,
            ),
                           Container(
                            margin: EdgeInsets.only(top: deviceSize.height * 0.10),
                             width: double.infinity,
                 height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25), )
                    ),
                             child:  Padding(
                               padding:  EdgeInsets.only(top:  deviceSize.height * 0.06, left: 15, right: 15),
                               child:model.TeacherPrivateGroupList.length >0 ?

                                     Column(
                                 children: [
                                             const SizedBox(height: 10,),
                                              CircleAvatar(radius: 30, child: Image.asset('assets/images/teacher.png')),
                                        Text(model.TeacherPrivateGroupList[0].TeacherName,
                                      style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                                         const SizedBox(height: 12,),
                                        Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                          descriptionContainer(model.TeacherPrivateGroupList[0].SubjectName,
                                           'assets/icons/book-description.png'),
                                          descriptionContainer('الصف الثالث الثانوي', 'assets/icons/level-description.png'),
                                          descriptionContainer('مجموعات', 'assets/icons/course-description.png'),
                                     ],
                                   ),
                                         const SizedBox(height: 12,),
                                       Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: model.TeacherPrivateGroupList.length,
                                         itemBuilder: (context, index)=> InkWell(onTap:
                                            ()=>GlobalMethods.navigate(context,
                                                 PriGroupContentPage(model: model,
                                                  teacherGroups: model.TeacherPrivateGroupList[index] ,)),
                                           child: groupContainer(context,model.TeacherPrivateGroupList[index])),
                                       ),
                                       ),
                                         const SizedBox(height: 12,),
                                         buildElevatedButton('احجز موعد', ()=>
                                       GlobalMethods.navigate(context,
                                           BookAppointmentPage(teacherId:
                                           model.TeacherPrivateGroupList[0].TeacherId ,
                                           teacherName: model.TeacherPrivateGroupList[0].TeacherName ,
                                           ))),
                                       const SizedBox(height: 12,),
                                 ],
                               ):const Center(
                                   child:
                                   CircularProgressIndicator()),),
                   ),

           
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 32.0),
                      const Text('برايفت', style: TextStyle(fontSize: 20, color: Colors.white, height: 1.5, fontWeight: FontWeight.bold)),

                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(Icons.arrow_forward_ios_sharp, color: AppColors.primaryColor, size: 15,),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20,top:deviceSize.height * 0.03,right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            spreadRadius: 3
                        )
                      ],
                    ),
                    child:  TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'بحث باسم المجموعة',
                        border: InputBorder.none,
                        prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.search, size: 25,)),
                        suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.filter_alt_sharp, size: 25,)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container groupContainer(context,PrivateGroup privateGroup) {
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
               Text(privateGroup.Title, style: const TextStyle(fontSize: 14, color: Colors.black),),
              Text(privateGroup.StudentsCount.toString()+'طالب ', style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
          const Spacer(),
          Column(
            children:  [
              Text(GlobalMethods.showPrice(privateGroup.Price)),
              Text(privateGroup.SessionsCount.toString()+' حصة'),
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

  ElevatedButton buildElevatedButton(String title, Function function) {
    return ElevatedButton(
      onPressed: () => function(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(40, 40),
      ),
      child: Text(title),
    );
  }
}

