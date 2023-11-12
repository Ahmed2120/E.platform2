import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/teacherModels/teacherSubModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../model/mainmodel.dart';
import '../../../model/teacherModels/teacherSubModel.dart';
import '../../../model/teacherModels/teacherSubModel.dart';
import '../../../pages/components/custom_title.dart';
import '../../../pages/components/show_network_image.dart';
import '../../../pages/home/components/nearest_schools.dart';
import '../../../pages/notification/notification_page.dart';
import '../../../session/userSession.dart';
import '../../../widgets/chat/user_img.dart';
import '../groups/groups_management_page.dart';
import '../profile_page/teacher_profile_page.dart';
import '../teacher_courses/courses_management_page.dart';
import '../teacher_wallet/teacher_wallet_page.dart';
import 'components/teacher_courses.dart';
import 'components/teacher_feature.dart';
import 'components/teacher_page_header.dart';
import 'components/teacher_sponsors.dart';


class TeacherHomePage extends StatefulWidget {
  TeacherHomePage({required this.model,Key? key}) : super(key: key);
  MainModel model;
  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}
class _TeacherHomePageState extends State<TeacherHomePage> {
  String? _profilePicture;
  String? _userName;
  String ? _walletValue;
  final _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   @override
   void initState() {
  //   // TODO: implement initState
      super.initState();
     widget.model.fetchTeacherSub();
     widget.model.fetchHomeSchools();
     widget.model.fetchTeacherHomeGroups();
     widget.model.fetchTeacherHomeCourses();
  //   widget.model.fetchStudentSubscriptions();
  //   widget.model.fetchAllTeachers();
  //   widget.model.fetchLatestBlog();
      _getUserData();
    }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return  ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
           key: _scaffoldKey,
           body:Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: deviceSize.height * 0.19,
                          color: AppColors.primaryColor,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: deviceSize.height * 0.15),
                          width: double.infinity,
                          height: deviceSize.height * 0.05,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // IconButton(onPressed: ()=> _scaffoldKey.currentState!.openDrawer(), icon: Icon(Icons.menu)),
                                InkWell(
                                  onTap: ()=> GlobalMethods.navigate(context, TeacherProfilePage()),
                                  // child: UserImg(img: profilePicture),
                                  child: _profilePicture == null ? Image.asset('assets/images/teacher.png', width: 40,) : ShowNetworkImage(img: _profilePicture!, size: 40,),
                                ),
                                const SizedBox(width: 5,),
                                SizedBox( child: Text(' مرحبا ${_userName ?? ''}', style: TextStyle(fontSize: deviceSize.height > 500 ? 20 : 15, color: Colors.white, height: 1.5), textAlign: TextAlign.right,)),
                                const Spacer(),
                                IconButton(
                                    onPressed: ()=> GlobalMethods.navigate(context, NotificationPage()), icon: const Icon(Icons.notifications,
                                  color: Colors.white,)),
                                IconButton(onPressed: ()=>GlobalMethods.navigate(context,
                                    TeacherWalletPage(walletValue: _walletValue!, model: model,)), icon: const Icon(Icons.wallet_giftcard_outlined, color: Colors.white,)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,top:deviceSize.height * 0.13,right: 20),
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
                          child: TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.search, size: 25,)),
                              suffixIcon: IconButton(onPressed: (){
                                // showDialog(context: context, builder: (context)=> FilterDialog(), barrierDismissible: false);
                              }, icon: const Icon(Icons.filter_alt_sharp, size: 25,)),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        shrinkWrap: true,
                        children: [
                          //   const SizedBox(height: 12,),
                          const TeacherPageHeader(),
                          const SizedBox(height: 12,),
                          SizedBox( height: 130, child: TeacherSponsors(model: model,)),
                          const SizedBox(height: 12,),
                          Row(
                            children: [
                              const CustomTitle('اقرب المدارس لك'),
                              const SizedBox(width: 5,),
                              Image.asset('assets/icons/bus.png'),
                            ],
                          ),
                          const SizedBox(height: 6,),
                           SizedBox(height: 160,
                              child: model.homeSchoolLoading ?
                              Center(child: CircularProgressIndicator()):
                             // TeacherNearestSchool(model: model,)),
                              NearestSchool(model: model,)),
                           const SizedBox(height: 6,),
                           InkWell(
                            onTap: ()=> GlobalMethods.navigate(context, CoursesManagementPage(model: model,)),
                            child: Row(
                              children: [
                                const CustomTitle('الكورسات'),
                                const SizedBox(width: 5,),
                                Image.asset('assets/icons/coursesAndGroups.png'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6,),
                          SizedBox(
                            height: 160,
                            width: deviceSize.width,
                            child:model.teacherHomeGroupLoading?
                             Center(child: CircularProgressIndicator())
                            :TeacherCourses(model:model , x: 0,),

                          ),
                          const SizedBox(height: 6,),
                          InkWell(
                            onTap: ()=> GlobalMethods.navigate(context, GroupsManagementPage(model: model,)),
                            child: Row(
                              children: [
                                const CustomTitle('المجموعات'),
                                const SizedBox(width: 5,),
                                Image.asset('assets/icons/coursesAndGroups.png'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6,),
                          SizedBox(
                            height: 160,
                            width: deviceSize.width,
                            child:
                            model.teacherHomeGroupLoading?
                            Center(child: CircularProgressIndicator()):
                            TeacherCourses(model:model,x: 1,),

                          ),

                          const SizedBox(height: 6,),
                          InkWell(
                            onTap: (){},
                            child: Row(
                              children: [
                                const CustomTitle('المميزات'),
                                const SizedBox(width: 5,),
                                Image.asset('assets/icons/people.png'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6,),
                          TeacherFeatures(),
                          const SizedBox(height: 6,),
                        ],
                      ),
                    ),
                  ],
                ),

          drawer: Drawer(),

        );
      }
    );
  }

  _getUserData() async{
    Map session=await UserSession.GetData();
    _profilePicture = session['profilePicture'];
    _userName = session['name'];
    _walletValue=session['wallet'];
    setState(() {});
  }
}


