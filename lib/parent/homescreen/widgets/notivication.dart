import 'dart:convert';

import 'package:eplatform/api/api.dart';
import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/model/notifier.dart';
import 'package:eplatform/pages/components/row_title.dart';
import 'package:eplatform/widgets/dialogs/alertMsg.dart';
import 'package:flutter/material.dart';

class NotificationParentPage extends StatefulWidget {
  const NotificationParentPage({Key? key}) : super(key: key);

  @override
  State<NotificationParentPage> createState() => _NotificationParentPageState();
}

class _NotificationParentPageState extends State<NotificationParentPage> {
  bool _Loading = false;
  List<Notificationss> _list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNotification();
  }

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
              margin: EdgeInsets.only(top: deviceSize.height * 0.1),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: AppColors.pageBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: _Loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _list.length,
                      itemBuilder: (context, index) =>
                          notificationContainer(context, _list[index])),
            ),
            const CustomRowTitle(
              title: 'الاشعارات',
            ),
          ],
        ),
      ),
    );
  }

  Container notificationContainer(context, Notificationss not) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFDEDEDE))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      tooltip: 'Mark as Read ',
                      onPressed: () {},
                    ),
                    Text(not.CreatedAt),
                  ],
                ),
                Text(
                  not.Text,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Image.asset('assets/images/notification.png'),
        ],
      ),
    );
  }

  Widget profilePhoto() {
    return Stack(
      children: [
        Image.asset('assets/images/student-profile.png'),
        Positioned(
          child: Image.asset('assets/images/camera.png'),
          bottom: 0,
          right: 0,
        )
      ],
    );
  }

  Widget buildContainer(String txt, Widget? icon, context) {
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 40,
            width: double.infinity,
            alignment: icon == null ? Alignment.centerRight : null,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black26),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.grey, blurRadius: 1, spreadRadius: 1)
                ]),
            child: Text(
              txt,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Positioned(
            top: 0,
            left: 5,
            child: icon ?? Container(),
          )
        ],
      ),
    );
  }

  void _getNotification() async {
    setState(() {
      _Loading = true;
    });
    try {
      var response =
          await CallApi().getData("/api/Notification/GetUserNotifications", 1);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _list = body.map((e) => Notificationss.fromJson(e)).toList();
      } else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      setState(() {
        _Loading = false;
      });
    } catch (e) {
      setState(() {
        _Loading = false;
      });

      print('ee ' + e.toString());
    }
  }
}
