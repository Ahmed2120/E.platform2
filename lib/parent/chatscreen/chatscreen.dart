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

class ChatParentPage extends StatefulWidget {
  ChatParentPage({required this.model, Key? key}) : super(key: key);
  MainModel model;
  @override
  State<ChatParentPage> createState() => _ChatParentPageState();
}

class _ChatParentPageState extends State<ChatParentPage> {
  final _searchController = TextEditingController();

  ChatType _chatType = ChatType.users;

  bool _mute = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.fetchTeachersToChat();
    widget.model.fetchGetChatGroups();
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
                child: model.TeachersToChatLoading == true
                    ? Center(child: CircularProgressIndicator())
                    : Column(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: () => setState(() {
                                        _chatType = ChatType.users;
                                      }),
                                  child: Text(
                                    'شات',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: typeColor(ChatType.users)),
                                  )),
                              GestureDetector(
                                  onTap: () => setState(() {
                                        _chatType = ChatType.groups;
                                      }),
                                  child: Text(
                                    'مجموعات',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: typeColor(ChatType.groups)),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //-----------------online users ----------------
                          _chatType == ChatType.users
                              ? Expanded(
                                  child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: model.TeachersToChatList.length,
                                  itemBuilder: (context, index) => onlineUsers(
                                      model.TeachersToChatList[index]),
                                ))
                              : Container(),

                          //-----------------online users ----------------
                          if (_chatType == ChatType.users)
                            Expanded(
                              flex: 3,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: model.TeachersToChatList.length,
                                itemBuilder: (context, index) => InkWell(
                                    onTap: () => GlobalMethods.navigate(
                                        context, ChatMsgPPage()),
                                    child: Dismissible(
                                        direction: DismissDirection.startToEnd,
                                        background: Container(
                                          color: Colors.red,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          margin:
                                              const EdgeInsets.only(left: 16),
                                          alignment: Alignment.centerRight,
                                          child: const Icon(
                                            Icons.volume_off_sharp,
                                            color: Colors.white,
                                          ),
                                        ),
                                        key: Key(model.TeachersToChatList[index]
                                            .TeacherUserId),
                                        confirmDismiss: (direction) async {
                                          setState(() => _mute = !_mute);
                                          return false;
                                        },
                                        child: userChatContainer(
                                            model.TeachersToChatList[index]))),
                              ),
                            ),

                          //-----------------group chat ----------------
                          if (_chatType == ChatType.groups)
                            Expanded(
                              flex: 3,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: model.ChatGroupsList.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () => GlobalMethods.navigate(
                                      context,
                                      GroupChatMsgPage(
                                        model: model,
                                        chatGroup: model.ChatGroupsList[index],
                                      )),
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
                                      key: Key(model
                                          .ChatGroupsList[index].ChatGroupId
                                          .toString()),
                                      confirmDismiss: (direction) async {
                                        setState(() => _mute = !_mute);
                                        return false;
                                      },
                                      child: groupChatContainer(
                                          model.ChatGroupsList[index])),
                                ),
                              ),
                            ),
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

  Widget onlineUsers(TeachersToChat teachersToChat) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          UserImg(img: teachersToChat.ProfilePicture, isActive: true),
          Text(
            teachersToChat.TeacherName,
            style: const TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget userChatContainer(TeachersToChat teachersToChat) {
    return Row(
      children: [
        Row(
          children: [
            Column(
              children: [
                if(teachersToChat.LastMessageTime != null) Text(
                  ConvertDateToTxt.dateConverter(
                      teachersToChat.LastMessageTime!),
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                ),
                teachersToChat.LastMessageSeen ?? true
                    ? const Icon(Icons.done_all)
                    : CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.unSeenMsgColor,
                        foregroundColor: Colors.white,
                        child: Text('1'),
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
              teachersToChat.TeacherName,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              teachersToChat.LastMessage ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(
          width: 6,
        ),
        UserImg(
            img: teachersToChat.ProfilePicture,
            isActive: false),
      ],
    );
  }

  Widget groupChatContainer(ChatGroup chatGroup) {
    return Row(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  chatGroup.LastMessageTime,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                chatGroup.LastMessageSeen
                    ? const Icon(Icons.done_all)
                    : CircleAvatar(
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
            if (_mute) const Icon(Icons.volume_off)
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chatGroup.ChatGroupName,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Row(
              children: [
                Text(
                  '${chatGroup.LastSenderName}: ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  chatGroup.LastMessage,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          width: 6,
        ),
        UserImg(img: chatGroup.GroupImage, isActive: false),
      ],
    );
  }
}

enum ChatType { users, groups }
