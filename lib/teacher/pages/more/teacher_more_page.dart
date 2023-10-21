import 'package:eplatform/pages/courses_and_groups/coursesAndGroups_page.dart';
import 'package:eplatform/pages/my_grades/my_grades_page.dart';
import 'package:eplatform/pages/my_wallet/my_wallet_page.dart';
import 'package:eplatform/pages/notification/notification_page.dart';
import 'package:eplatform/pages/subscribtions/subscriptions.dart';
import 'package:eplatform/pages/tasks/tasks_page.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../core/utility/app_colors.dart';
import '../../../core/utility/global_methods.dart';
import '../../../model/mainmodel.dart';
import '../../../pages/components/show_network_image.dart';
import '../../../pages/student/student_page.dart';
import '../../../session/userSession.dart';
import '../contact_support/contact_support_page.dart';
import '../exams/exams_management_page.dart';
import '../groups/groups_management_page.dart';
import '../groups/homework/homework_details_page.dart';
import '../notes/teacher_notes_page.dart';
import '../notification/teacher_notification_page.dart';
import '../student_grades/student_grades_page.dart';
import '../teacher_courses/courses_management_page.dart';
import '../teacher_wallet/teacher_wallet_page.dart';

class TeacherMorePage extends StatefulWidget {
  TeacherMorePage({Key? key}) : super(key: key);

  @override
  State<TeacherMorePage> createState() => _TeacherMorePageState();
}

class _TeacherMorePageState extends State<TeacherMorePage> {
  final _searchController = TextEditingController();

  String? _name;
  String? _profilePicture;
  String ? _walletValue;

  @override
  void initState() {
    super.initState();

    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return  ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
          body: CustomStack(
            pageTitle: 'المزيد',
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap:() =>GlobalMethods.navigate(context, const StudentPage()),
                      child: _profilePicture == null ? Image.asset('assets/images/profile.png') :
                      ShowNetworkImage(img : _profilePicture!) ,

                    ),
                    const SizedBox(width: 6,),
                    Column(
                      children: [
                        Text(_name?? '', style: Theme.of(context).textTheme.titleMedium,),
                        // Text('الصف الثالث الاعدادي', style: Theme.of(context).textTheme.titleSmall,),
                      ],
                    ),
                    const Spacer(),
                    const Column(
                      children: [
                        Icon(Icons.edit, color: AppColors.primaryColor,),
                        Text('تعديل'),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisSpacing: 40.0,
                    mainAxisSpacing: 30.0,
                    childAspectRatio: 2,
                    crossAxisCount: 2,
                    children: [
                      InkWell(
                          onTap: ()=> GlobalMethods.navigate(context, TeacherWalletPage(walletValue: _walletValue!,)),
                          child: buildContainer('المحفظة', 'assets/images/wallet 1.png', context)),
                      InkWell(
                          onTap: ()=> GlobalMethods.navigate(context, CoursesManagementPage(model: model)),
                          child: buildContainer('الكورسات', 'assets/images/online-learning 2.png', context)),
                      InkWell(
                          onTap: ()=> GlobalMethods.navigate(context, TeacherNotificationPage()),
                          child: buildContainer('الاشعارات', 'assets/icons/notification (1) 1.png', context)),
                      InkWell(
                        onTap: ()=> GlobalMethods.navigate(context, GroupsManagementPage(model: model,)),
                          child: buildContainer('المجموعات', 'assets/images/online-learning 2.png', context)),
                      InkWell(
                          onTap: ()=> GlobalMethods.navigate(context, StudentGradesPage()),
                          child: buildContainer('درجات الطلاب', 'assets/images/grades.png', context)),
                      InkWell(
                          onTap: ()=> GlobalMethods.navigate(context, TeacherNotesPage(model:model)),
                          child: buildContainer('المذكرات', 'assets/icons/diary.png', context)),
                      InkWell(
                          // onTap: ()=> GlobalMethods.navigate(context, MyGradesPage()),
                          child: buildContainer('مجموعات برايفت', 'assets/images/secure-data 1.png', context)),
                      InkWell(
                          onTap: (){},
                          child: buildContainer('الاوائل', 'assets/icons/podium 1.png', context)),
                      // InkWell(
                      //     onTap: (){},
                      //     child: buildContainer('التواصل مع الدعم', 'assets/icons/technical-support 1.png', context)),
                      contact('التواصل مع الدعم', context),

                      InkWell(
                          onTap: ()=> GlobalMethods.navigate(context, ExamsManagementPage(model: model,)),
                          child: buildContainer('الاختبارات', 'assets/icons/terms-and-conditions 1.png', context)),
                      InkWell(
                          onTap: ()=> GlobalMethods.navigate(context, HomeWorkDetailsPage()),
                          child: buildContainer('الواجبات', 'assets/icons/homework.png', context)),
                      InkWell(
                          onTap: (){},
                          child: buildContainer('عن المنصة', 'assets/icons/information 1.png', context)),
                    ],),
                ),
                const SizedBox(height: 12,),
              ],
            ),
          ),
        );
      }
    );
  }

  Container buildContainer(String title, String img, context, {bool hasCoins = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(3),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(img, width: 20,),
              Text(title, style: TextStyle(color: Colors.black, fontSize: textSize(context)),)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(hasCoins) Image.asset('assets/icons/coin.png', width: 20,) else Container(),
              const Icon(Icons.arrow_back_ios_new_outlined, color: AppColors.primaryColor, size: 13,)
            ],
          ),
        ],
      ),
    );}

  Container contact(String title, context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(3),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: (){},
                      child: Image.asset('assets/icons/whatsapp.png', width: 20,)),
                  const SizedBox(width: 15,),
                  InkWell(
                    onTap: (){},
                      child: Image.asset('assets/icons/messenger 2.png', width: 20,)),
                  const SizedBox(width: 15,),
                  InkWell(
                    onTap: ()=> GlobalMethods.navigate(context, ContactSupportMsgPage()),
                      child: Image.asset('assets/icons/chat (2) 2.png', width: 20,)),
                ],
              ),
              Text(title, style: TextStyle(color: Colors.black, fontSize: textSize(context)),)
            ],
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.arrow_back_ios_new_outlined, color: AppColors.primaryColor, size: 13,)
            ],
          ),
        ],
      ),
    );}

  double textSize(context){
    final widthSize = MediaQuery.of(context).size.width;
    if(widthSize > 420) {
      return 14;
    }
    else if(widthSize > 378){
      return 12;
    }
    else{
      return 10;
    }
  }

  getUserData() async{
    final data = await UserSession.GetData();

    _name = data['name'];
    _profilePicture = data['profilePicture'];
    _walletValue=data['wallet'];

    setState(() {});
  }
}