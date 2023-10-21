import 'dart:convert';

import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/pages/components/row_title.dart';
import 'package:flutter/material.dart';

import '../../api/api.dart';
import '../../model/notifier.dart';
import '../../widgets/dialogs/alertMsg.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {

  bool _Loading=false;
  List <Notificationss> _list=[];
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
              ),
              child:  _Loading ? const Center(child: CircularProgressIndicator())
                  :ListView.builder(itemCount: _list.length,
                  itemBuilder: (context, index)=>
                      wishlistContainer(context , _list[index])),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: CustomRowTitle(title: 'المفضلات ',),
            ),

          ],
        ),
      ),
    );
  }

  Widget wishlistContainer(context ,Notificationss not) {
    return ListTile(
      title: const Text('كورس أ/احمد خالد'),
      subtitle: const Text('رياضيات '),
      leading: Image.asset('assets/images/video-marketing (1) 6.png'),
      trailing: const Icon(Icons.favorite, color: Colors.red,),
    );
  }

  void _getNotification() async{
    setState(() {
      _Loading=true;
    });
    try {
      var response = await CallApi().getData("/api/Notification/GetUserNotifications", 1);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _list=body.map((e) => Notificationss.fromJson(e)).toList();


      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      setState(() {
        _Loading=false;
      });
    }
    catch(e){
      setState(() {
        _Loading=false;
      });

      print('ee '+e.toString());
    }

  }
}
