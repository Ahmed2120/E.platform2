import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/chat/chatGroups.dart';
import 'package:eplatform/model/chat/teachersToChat.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/chat/chat_msg_page.dart';
import 'package:eplatform/pages/chat/convertDateToTxt.dart';
import 'package:eplatform/pages/chat/group_msg_page.dart';
import 'package:eplatform/pages/components/row_title.dart';
import 'package:eplatform/parent/chatscreen/catmessage.dart';
import 'package:eplatform/widgets/chat/user_img.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ChattingParentPage extends StatefulWidget {
  ChattingParentPage({Key? key}) : super(key: key);

  @override
  State<ChattingParentPage> createState() => _ChattingParentPageState();
}

class _ChattingParentPageState extends State<ChattingParentPage> {
  final _searchController = TextEditingController();

  ChatType _chatType = ChatType.users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(child: ScopedModelDescendant<MainModel>(
          builder: (context, child, MainModel model) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: AppColors.primaryColor,
            ),
            Container(
              margin: EdgeInsets.only(top: deviceSize.height * 0.08),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              spreadRadius: 3)
                        ],
                      ),
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.search,
                                size: 25,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //-----------------online users ----------------
                    Expanded(
                        child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) => onlineUsers(),
                    )),

                    //-----------------online users ----------------

                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) => InkWell(
                            onTap: () =>
                                GlobalMethods.navigate(context, ChatMsgPPage()),
                            child: Dismissible(
                                direction: DismissDirection.startToEnd,
                                background: Container(
                                  color: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  margin: const EdgeInsets.only(left: 16),
                                  alignment: Alignment.centerRight,
                                  child: const Icon(
                                    Icons.volume_off_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                                key: Key('1'),
                                confirmDismiss: (direction) async {
                                  return false;
                                },
                                child: userChatContainer())),
                      ),
                    ),

                    //-----------------group chat ----------------
                  ],
                ),
              ),
            ),
            const CustomRowTitle(
              title: 'الدردشة',
            )
          ],
        );
      })),
    );
  }

  Color typeColor(ChatType chatType) {
    if (chatType == _chatType) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }

  Widget onlineUsers() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          UserImg(
              img:
                  'https://img.freepik.com/premium-photo/hand-touching-network-connecting-human-dots-icon-business-project-management_34200-326.jpg',
              isActive: true),
          Text(
            'mahmoud',
            style: const TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget userChatContainer() {
    return Row(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  '05:21',
                  style: TextStyle(color: Colors.orange, fontSize: 10),
                  maxLines: 2,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.unSeenMsgColor,
                  foregroundColor: Colors.white,
                  child: Text(
                    '1',
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            if (true) const Icon(Icons.volume_off)
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'mahmoud',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'صباح الخير',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(
          width: 6,
        ),
        UserImg(
            img:
                'https://img.freepik.com/premium-photo/hand-touching-network-connecting-human-dots-icon-business-project-management_34200-326.jpg',
            isActive: true),
      ],
    );
  }

  Widget groupChatContainer() {
    return Row(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  'chatGroup.LastMessageTime',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.unSeenMsgColor,
                  foregroundColor: Colors.white,
                  child: Text('${1}'),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'chatGroup.ChatGroupName',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Row(
              children: [
                Text(
                  '{chatGroup.LastSenderName}: ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'chatGroup.LastMessage',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          width: 6,
        ),
        UserImg(
            img:
                'https://img.freepik.com/premium-photo/hand-touching-network-connecting-human-dots-icon-business-project-management_34200-326.jpg',
            isActive: false),
      ],
    );
  }
}

enum ChatType { users, groups }
