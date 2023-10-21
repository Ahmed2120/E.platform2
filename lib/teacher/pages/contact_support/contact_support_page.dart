import 'package:eplatform/pages/courses_and_groups/book_appointment_page.dart';
import 'package:flutter/material.dart';

import '../../../core/utility/app_colors.dart';
import '../../../core/utility/global_methods.dart';
import '../../../widgets/chat/msg_field.dart';
import '../../../widgets/chat/user_img.dart';
import '../../../widgets/custom_stack.dart';


class ContactSupportMsgPage extends StatelessWidget {
  ContactSupportMsgPage({Key? key}) : super(key: key);

  final _msgController = TextEditingController();

  final ScrollController _controller = ScrollController();

  List msgs = [
    {
      'id': 1,
      'msg': 'اهلا بيك , اقدر اساعدك ازاي',
      'isSender': false,
      'time': '09:00 A.M'
    },
    {
      'id': 2,
      'msg': 'لدي مشكلة',
      'isSender': true,
      'time': '04:00 A.M'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'التواصل مع الدعم',
        child: Column(
          children: [
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
      child: Row(
        children: [
          Image.asset('assets/images/Vector.png'),
          const SizedBox(width: 5,),
          Container(
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
        ],
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