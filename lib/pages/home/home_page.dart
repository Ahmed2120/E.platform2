import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/widgets/chat/user_img.dart';
import 'package:eplatform/pages/subscribtions/subscriptions.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../model/mainmodel.dart';
import '../../session/userSession.dart';
import '../components/custom_title.dart';
import '../components/show_network_image.dart';
import '../courses_and_groups/coursesAndGroups_page.dart';
import '../my_wallet/my_wallet_page.dart';
import '../notification/notification_page.dart';
import '../student/student_page.dart';
import '../teachers/teachers_page.dart';
import 'components/courses.dart';
import 'components/filter_dialog.dart';
import 'components/my_subscriptions.dart';
import 'components/nearest_schools.dart';
import 'components/news.dart';
import 'components/page_header.dart';
import 'components/sponsors.dart';
import 'components/teachers.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.model, Key? key}) : super(key: key);
  MainModel model;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _profilePicture;
  String? _userName;
  String? _walletValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.fetchSub();
    widget.model.fetchHomeSchools();
    widget.model.fetchHomeCourses_AND_Groups();
    widget.model.fetchStudentSubscriptions(null);
    widget.model.fetchAllTeachers(null, null);
    widget.model.fetchLatestBlog();
    _getUserData();
  }

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
                              context, const StudentPage()),
                          child: _profilePicture == null
                              ? Image.asset(
                                  'assets/images/teacher.png',
                                  width: 40,
                                )
                              : ShowNetworkImage(
                                  img: _profilePicture!,
                                  size: 35,
                                ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                            child: Text(
                          _userName ?? '',
                          style: TextStyle(
                              fontSize: deviceSize.height > 500 ? 20 : 15,
                              color: Colors.white,
                              height: 1.5),
                          textAlign: TextAlign.right,
                        )),
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () => GlobalMethods.navigate(
                                context, const NotificationPage()),
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () => GlobalMethods.navigate(
                                context,
                                MyWalletPage(
                                  walletValue: _walletValue!,
                                  model: model,
                                )),
                            icon: const Icon(
                              Icons.wallet_giftcard_outlined,
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
                                builder: (context) => FilterDialog(),
                                barrierDismissible: false);
                          },
                          icon: const Icon(
                            Icons.filter_alt_sharp,
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
                  const PageHeader(),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(height: 110, child: Sponsors(model: model,)),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const CustomTitle('اقرب المدارس لك'),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset('assets/icons/bus.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                      height: 160,
                      child: model.homeSchoolLoading
                          ? const Center(child: CircularProgressIndicator())
                          : NearestSchool(
                              model: model,
                            )),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      const CustomTitle('اخر الاخبار'),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset('assets/icons/paper.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                      height: 150,
                      child: model.allBlogLoading
                          ? const Center(child: CircularProgressIndicator())
                          : News(
                              model: model,
                            )),
                  const SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () => GlobalMethods.navigate(context,
                        ScopedModelDescendant<MainModel>(
                            builder: (context, child, MainModel model) {
                      return CoursesAndGroupsPage(model: model);
                    })),
                    child: Row(
                      children: [
                        const CustomTitle('الكورسات والمجموعات'),
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
                    height: 200,
                    width: deviceSize.width,
                    child: model.homeCoursesLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Courses(
                            model: model,
                            type: 'Course',
                          ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () => GlobalMethods.navigate(
                        context,
                        TeachersPage(
                          model: model,
                        )),
                    child: Row(
                      children: [
                        const CustomTitle('المدرسين'),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/icons/teachers.png'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                      height: 200,
                      child: model.allTecherLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Teachers(
                              model: model,
                            )),
                  const SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () => GlobalMethods.navigate(context,
                        ScopedModelDescendant<MainModel>(
                            builder: (context, child, MainModel model) {
                      return Subscriptions(model: model);
                    })),
                    child: Row(
                      children: [
                        const CustomTitle('اشتراكاتي'),
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
                      height: 200,
                      child: model.StudentSubscriptionsLoading
                          ? const Center(child: CircularProgressIndicator())
                          : MySubscriptions(
                              model: model,
                            )),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      drawer: const Drawer(),
    );
  }

  _getUserData() async {
    Map session = await UserSession.GetData();
    _profilePicture = session['profilePicture'];
    _userName = session['name'];
    _walletValue = session['wallet'];
    setState(() {});
  }
}
