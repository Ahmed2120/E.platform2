import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/pages/login_page/login_page.dart';
import 'package:eplatform/pages/role_page/role_page.dart';
import 'package:eplatform/pages/schedule/schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../model/mainmodel.dart';
import 'chat/chat_users_page.dart';
import 'home/home_page.dart';
import 'more/more_page.dart';
import 'subscribtions/subscriptions.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {

  final _selectedItemColor = Colors.green;
  final _unselectedItemColor = Colors.white30;

  int _selectedIndex = 2;

  int get tabIndex => _selectedIndex;
  set tabIndex(int v) {
    _selectedIndex = v;
    setState(() {});
  }

  List<Widget> pages = [
    MorePage(),
    // LoginPage(),
    ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return ChatUsersPage(model: model,) ;}) ,
    ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return HomePage(model: model,); }) ,
    ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Subscriptions(model: model,); }) ,
    ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
        return SchedulePage(model: model,);
      }
    ),
  ];

  final items = <Widget>[
    const Icon(Icons.more_horiz, size: 30,),
    const Icon(Icons.home, size: 30,),
    const Icon(Icons.home, size: 30,),
    const Icon(Icons.home, size: 30,),
  ];

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        if(_selectedIndex != 2) {
          _selectedIndex = 2;
          print(_selectedIndex );
          setState(() {});
          pageController.jumpToPage(_selectedIndex);
          return false;
        }else {
          return true;
        }
      },
      child: Scaffold(
        // extendBody: true,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (v) {
            print('onPageChanged: $v');
            _selectedIndex = v;
          },
          children: pages,
        ),
        // pages[_selectedIndex],
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.ltr,
          child: CircleNavBar(
            activeIcons: [
              const Icon(Icons.more_horiz, color: AppColors.primaryColor, size: 40,),
              Image.asset('assets/icons/chat.png', color: AppColors.primaryColor,),
              const Icon(Icons.home, color: AppColors.primaryColor, size: 40,),
              Image.asset('assets/icons/subjects.png', color: AppColors.primaryColor,),
              Image.asset('assets/icons/cells 1.png', color: AppColors.primaryColor,),
            ],
            inactiveIcons: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.more_horiz, color: Colors.white),
                  Text("المزيد", style: TextStyle(fontSize: 15, color: Colors.white),),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
              ImageIcon(AssetImage('assets/icons/chat.png'), color: Colors.white,),
                  Text("الدردشة", style: TextStyle(fontSize: 15, color: Colors.white),),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.home, color: Colors.white),
                  Text("الرئيسية", style: TextStyle(fontSize: 15, color: Colors.white),),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                ImageIcon(AssetImage('assets/icons/subjects.png'), color: Colors.white,),
                  Text("المواد", style: TextStyle(fontSize: 15, color: Colors.white),),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  ImageIcon(AssetImage('assets/icons/cells 1.png'), color: Colors.white,),
                  Text("الجدول", style: TextStyle(color: Colors.white),),
                ],
              ),
            ],
            color: AppColors.primaryColor,
            circleColor: Colors.transparent,
            height: 60,
            circleWidth: 60,
            activeIndex: tabIndex,
            onTap: (index) {
              tabIndex = index;
              print('onTap: $index');
              _selectedIndex = index;
              pageController.jumpToPage(tabIndex);
            },
            // tabCurve: ,
            // padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
            cornerRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            // shadowColor: Colors.deepPurple,
            // circleShadowColor: Colors.deepPurple,
            elevation: 10,
          ),
        ),
      ),
    );
  }

  // List<BottomNavigationBarItem> bottomNavigationBarItems() {
  //   return [
  //       BottomNavigationBarItem(
  //           icon:
  //       _buildIcon(_selectedIndex == 0 ? IconlyBold.home : IconlyLight.home, '', 0),
  //           label: ''),
  //       BottomNavigationBarItem(
  //           icon: _buildIcon(_selectedIndex == 1 ? IconlyBold.search : IconlyLight.search, '', 1),
  //           label: ''),
  //       BottomNavigationBarItem(
  //           icon: _buildIcon(
  //                   _selectedIndex == 2 ? IconlyBold.notification : IconlyLight.notification, '', 2),
  //           label: ''),
  //       BottomNavigationBarItem(
  //           icon: _buildIcon(
  //               _selectedIndex == 3 ? IconlyBold.user_2 : IconlyLight.user_1, '', 3),
  //           label: ''),
  //     ];}

  // Color _getItemColor(int index) =>
  //     _selectedIndex == index ? _selectedItemColor : _unselectedItemColor;
  // Color? _getBgColor(int index) =>
  //     _selectedIndex == index ? _selectedBgColor : null;

  // Widget _buildIcon(IconData iconData, String text, int index) => Container(
  //   width: 60,
  //   child: Material(
  //     child: InkWell(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Icon(iconData),
  //           Text(text,
  //               style: TextStyle(fontSize: 12, color: _getItemColor(index))),
  //         ],
  //       ),
  //     ),
  //   ),
  // );
}
