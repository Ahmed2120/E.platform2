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
import 'package:eplatform/parent/coursesass.dart';
import 'package:eplatform/parent/followingteachers/followingteachers.dart';
import 'package:eplatform/parent/homescreen/widgets/coursesparents.dart';
import 'package:eplatform/parent/homescreen/widgets/coursesAndGroups.dart';
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

import 'widgets/filterparentdialog.dart';
import 'widgets/nearstschollsass.dart';

class HomeParentPage extends StatefulWidget {
  HomeParentPage({Key? key}) : super(key: key);

  @override
  State<HomeParentPage> createState() => _HomeParentPageState();
}

class _HomeParentPageState extends State<HomeParentPage> {
  String profilePicture = '';
  List<String> texts = [
    'اضافه ابناء',
    'اضافه معلم ',
    'متابعه مدرس ',
  ];

  List<String> imags = [
    'assets/images/fatherhood 1.png',
    'assets/images/add (4) 1.png',
    'assets/images/teacher.png',
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
                          onTap: () => GlobalMethods.navigate(
                              context, const ParentPage()),
                          child: CircleAvatar(
                              radius: deviceSize.height > 500 ? 25 : 20,
                              child: Image.asset('assets/images/parent.png')),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                            child: Text(
                          'مرحبا  ',
                          style: TextStyle(
                              fontSize: deviceSize.height > 500 ? 20 : 15,
                              color: Colors.white,
                              height: 1),
                          textAlign: TextAlign.right,
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
                  const PageParentHeader(),
                  const SizedBox(
                    height: 12,
                  ),
                  const SponsorsASS(),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const CustomTitle('اقرب مدارس لك'),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset('assets/icons/bus.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(height: 160, child: NearestSchoolParent()),
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
                      GlobalMethods.navigate(context, ChildrensSubscriptions());
                    },
                    child: Row(
                      children: [
                        const CustomTitle('اشتراكات الابناء '),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/icons/coursesAndGroups.png'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    height: 220,
                    width: deviceSize.width,
                    child: ChildrenSubscription(
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
                        const CustomTitle("كورسات ومجموعات "),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/icons/people.png'),
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
                          : CoursesAndGroupsParnt(
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
                      return TeachersPPage();
                    })),
                    child: Row(
                      children: [
                        const CustomTitle("المدرسين "),
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

                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const CustomTitle('المميزات'),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/images/insignia 1.png'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 700,
                    child: GridView.builder(
                        itemCount: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // عدد الأعمدة المطلوبة
                          mainAxisSpacing: 15.0, // التباعد الرأسي بين العناصر
                          crossAxisSpacing: 16.0, // التباعد الأفقي بين العناصر
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: InkWell(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    GlobalMethods.navigate(
                                        context, AddingChildren());
                                    break;
                                  case 1:
                                    GlobalMethods.navigate(
                                        context, AddingTeachers());
                                    break;

                                  case 2:
                                    GlobalMethods.navigate(
                                        context, FollowingTeachers());
                                    break;
                                }
                              },
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.12)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 1,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(imags[index], width: 35),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      texts[index],
                                      style:
                                          const TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        );
      }),
      drawer: const Drawer(),
    );
  }

  _getProfilePicture() async {
    Map session = await UserSession.GetData();
    profilePicture = session['profilePicture'];
    setState(() {});
  }
}
