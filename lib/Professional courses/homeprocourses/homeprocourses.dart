import 'package:eplatform/Professional%20courses/homeprocourses/widdgets/coursespro.dart';
import 'package:eplatform/Professional%20courses/homeprocourses/widdgets/fieldsitems.dart';
import 'package:eplatform/Professional%20courses/homeprocourses/widdgets/latestnews.dart';
import 'package:eplatform/Professional%20courses/homeprocourses/widdgets/mysubscriptions.dart';
import 'package:eplatform/Professional%20courses/homeprocourses/widdgets/subscriptions.dart';
import 'package:eplatform/Professional%20courses/homeprocourses/widdgets/teacherpcourses.dart';
import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/components/custom_title.dart';
import 'package:eplatform/parent/addingchildren/addchildren.dart';
import 'package:eplatform/parent/addingteacherspage/addingteacherpage.dart';
import 'package:eplatform/parent/analysispage/analysis.dart';
import 'package:eplatform/parent/attendanceandabsence/attendanceandabsence.dart';
import 'package:eplatform/parent/childrenssubscriptions.dart';
import 'package:eplatform/parent/coursesandgroupsppage/coursesandgroupsparents.dart';

import 'package:eplatform/parent/homescreen/widgets/filterparentdialog.dart';
import 'package:eplatform/parent/homescreen/widgets/notivication.dart';
import 'package:eplatform/parent/homescreen/widgets/pageassheader.dart';
import 'package:eplatform/parent/homescreen/widgets/parentwallet.dart';
import 'package:eplatform/parent/homescreen/widgets/sponsorsass.dart';
import 'package:eplatform/parent/homescreen/widgets/subscriptiptionparent.dart';
import 'package:eplatform/parent/homescreen/widgets/teachersp.dart';
import 'package:eplatform/parent/parent.dart';
import 'package:eplatform/pages/teachers/teachers_page.dart';
import 'package:eplatform/session/userSession.dart';
import 'package:eplatform/widgets/chat/user_img.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../parent/homescreen/widgets/nearstschollsass.dart';
import './widdgets/profile.dart';
import 'widdgets/pageprecourseheader.dart';

class HomeProCoursesPage extends StatefulWidget {
  HomeProCoursesPage({Key? key}) : super(key: key);

  @override
  State<HomeProCoursesPage> createState() => _HomeProCoursesPageState();
}

class _HomeProCoursesPageState extends State<HomeProCoursesPage> {
  String profilePicture = '';

  List<String> imags = [
    'assets/images/fatherhood 1.png',
    'assets/images/add (4) 1.png',
    'assets/images/fatherhood 2.png',
    'assets/images/teacher.png',
    'assets/images/fatherhood 2.png',
    'assets/images/fatherhood 2.png',
  ];

  final _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: ScopedModelDescendant<MainModel>(
          builder: (context, child, MainModel model) {
        return Column(
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // IconButton(onPressed: ()=> _scaffoldKey.currentState!.openDrawer(), icon: Icon(Icons.menu)),
                        InkWell(
                          onTap: () =>
                              GlobalMethods.navigate(context, ProfilScreen()),
                          child: CircleAvatar(
                              radius: deviceSize.height > 500 ? 25 : 20,
                              child: Image.asset('assets/images/parent.png')),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                            child: Column(
                          children: [
                            Text(
                              '  مرحبا بك ',
                              style: TextStyle(
                                  fontSize: deviceSize.height > 500 ? 20 : 15,
                                  color: Colors.white,
                                  height: 1),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              'محمود',
                              style: TextStyle(
                                  fontSize: deviceSize.height > 500 ? 20 : 15,
                                  color: Colors.white,
                                  height: 1),
                              textAlign: TextAlign.right,
                            )
                          ],
                        )),

                        const SizedBox(
                          height: 2,
                        ),
                        const Spacer(),

                        IconButton(
                            onPressed: () =>
                                GlobalMethods.navigate(context, ParentWallet()),
                            icon: const Icon(
                              Icons.wallet_giftcard_outlined,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () => GlobalMethods.navigate(
                                context, const NotificationParentPage()),
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 20, top: deviceSize.height * 0.13, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12, blurRadius: 6, spreadRadius: 3)
                    ],
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            size: 25,
                          )),
                      suffixIcon: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => FilterParentDialog(),
                                barrierDismissible: false);
                          },
                          icon: const Icon(
                            Icons.list,
                            size: 25,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                shrinkWrap: true,
                children: [
                  //   const SizedBox(height: 12,),
                  const PagePrecoursesHeader(),
                  const SizedBox(
                    height: 12,
                  ),
                  const SponsorsASS(),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const CustomTitle(' المجالات'),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset('assets/images/input 1.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(height: 160, child: FieldsItems()),
                  const SizedBox(
                    height: 6,
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  const SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () {
                      GlobalMethods.navigate(context, MySubscription());
                    },
                    child: Row(
                      children: [
                        const CustomTitle('كورساتي'),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/images/notification.png'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    height: 220,
                    width: deviceSize.width,
                    child: Subscriptions(
                      model: model,
                      x: 0,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () => GlobalMethods.navigate(context,
                        ScopedModelDescendant<MainModel>(
                            builder: (context, child, MainModel model) {
                      return CoursesAndGroupsOfChildrens();
                    })),
                    child: Row(
                      children: [
                        const CustomTitle(" اخر الاخبار "),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/images/paper 1.png'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                      height: 200,
                      child: LatestNews(
                        model: model,
                        x: 0,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => GlobalMethods.navigate(context,
                        ScopedModelDescendant<MainModel>(
                            builder: (context, child, MainModel model) {
                      return TeachersPCoursesPage();
                    })),
                    child: Row(
                      children: [
                        const CustomTitle("المحاضرين  "),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/images/teacher.png',
                          width: 39,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 200,
                      width: 400,
                      child: model.StudentSubscriptionsLoading
                          ? const Center(child: CircularProgressIndicator())
                          : TeachersProCourses(
                              model: model,
                              x: 0,
                            )),
                  const SizedBox(
                    height: 10,
                  ),

                  const SizedBox(height: 50),

                  const SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () => GlobalMethods.navigate(context,
                        ScopedModelDescendant<MainModel>(
                            builder: (context, child, MainModel model) {
                      return MySubscription();
                      //CoursesAndGroupsOfChildrens();
                    })),
                    child: Row(
                      children: [
                        const CustomTitle(" الكورسات "),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/images/insignia 1.png'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                      height: 220,
                      width: deviceSize.width,
                      child: model.StudentSubscriptionsLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CoursesPro(
                              model: model,
                              x: 0,
                            )),
                ],
              ),
            ),
          ],
        );
      }),
      drawer: const Drawer(),
    );
  }
}
