import 'package:eplatform/pages/courses_and_groups/book_appointment_page.dart';
import 'package:flutter/material.dart';

import '../../../core/utility/app_colors.dart';
import '../../../core/utility/global_methods.dart';
import '../../../widgets/chat/msg_field.dart';
import '../../../widgets/chat/user_img.dart';


class TeacherChatMsgPage extends StatelessWidget {
  TeacherChatMsgPage({Key? key}) : super(key: key);

  final _msgController = TextEditingController();

  final ScrollController _controller = ScrollController();

  List msgs = [
    {
      'id': 1,
      'msg': 'hello world',
      'isSender': true,
      'time': '09:00 A.M'
    },
    {
      'id': 2,
      'msg': 'hello world',
      'isSender': false,
      'time': '04:00 A.M'
    },
    {
      'id': 3,
      'msg': 'hello world',
      'isSender': true,
      'time': '10:00 A.M'
    },
  ];

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
              margin: EdgeInsets.only(top: deviceSize.height * 0.15),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: AppColors.pageBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      const Spacer(),
                      Column(
                        children: const [
                          Text('احمد محمد',
                              style:
                              TextStyle(fontSize: 15, color: Colors.white)),
                          Text('متصل الان',
                              style:
                              TextStyle(fontSize: 13, color: Colors.white)),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const UserImg(
                        img:
                        'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1600',
                        isActive: true,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: AppColors.primaryColor,
                              size: 15,
                            )),
                      )
                    ],
                  ),
                  SizedBox(height: deviceSize.height * 0.09,),
                  Expanded(
                    child: ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        itemCount: msgs.length,
                        itemBuilder: (context, index) {
                          return msgs[index]['isSender'] ? senderContainer(msgs[index]) : receiverContainer(msgs[index]);
                        }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MsgField(
                      controller: _msgController, function: () {
                      _scrollDown();
                    }, MsgLoading: false,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget senderContainer(msg) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            color: AppColors.senderColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: Text(msg['msg'], style: const TextStyle(color: Colors.white), textDirection: GlobalMethods.rtlLang(msg['msg']) ? TextDirection.rtl : TextDirection.ltr,)),
            const SizedBox(width: 6,),
            Column(children: [
              const Icon(Icons.done_all, color: Colors.white,),
              Text(msg['time'], style: const TextStyle(fontSize: 10, color: Colors.white),)
            ],),
          ],
        ),
      ),
    );
  }

  Widget receiverContainer(msg) {
    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            color: AppColors.receiverColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: Text(msg['msg'], style: const TextStyle(color: Colors.black), textDirection: GlobalMethods.rtlLang(msg['msg']) ? TextDirection.rtl : TextDirection.ltr,)),
            const SizedBox(width: 6,),
            Text(msg['time'], style: const TextStyle(fontSize: 10, color: Colors.black),),
          ],
        ),
      ),
    );
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}