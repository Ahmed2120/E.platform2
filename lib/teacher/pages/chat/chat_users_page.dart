import 'package:flutter/material.dart';

import '../../../core/utility/app_colors.dart';
import '../../../core/utility/global_methods.dart';
import '../../../pages/components/row_title.dart';
import '../../../widgets/chat/user_img.dart';
import 'chat_msg_page.dart';

class TeacherChatUsersPage extends StatefulWidget {
  TeacherChatUsersPage({Key? key}) : super(key: key);

  @override
  State<TeacherChatUsersPage> createState() => _TeacherChatUsersPageState();
}

class _TeacherChatUsersPageState extends State<TeacherChatUsersPage> {
  final _searchController = TextEditingController();

  ChatType _chatType = ChatType.users;

  List users = [
    {
      'userId': 1,
      'userName': 'Mohamed',
      'userImg': 'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1600',
      'isActive': true,
      'lastMsg': 'صباح الخير',
      'time': 'امس',
      'seen': false,
      'unSeenMsg': 4,
      'isMute': true
    },
    {
      'userId': 1,
      'userName': 'Ayman',
      'userImg': 'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1600',
      'isActive': true,
      'lastMsg': 'صباح الخير',
      'time': 'امس',
      'seen': true,
      'unSeenMsg': 0,
      'isMute': false
    },
  ];

  List groups = [
    {
      'groupName': 'جروب مستر احمد لغة عربية ',
      'groupImg': 'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1600',
      'lastMsg': 'صباح الخير',
      'lastMsgUser': 'Ahmad',
      'time': 'امس',
      'seen': false,
      'unSeenMsg': 4,
      'isMute': false
    },
    {
      'groupName': 'جروب مستر احمد لغة عربية ',
      'groupImg': 'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1600',
      'lastMsg': 'صباح الخير',
      'lastMsgUser': 'Mohammad',
      'time': 'امس',
      'seen': true,
      'unSeenMsg': 0,
      'isMute': true
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
              margin: EdgeInsets.only(top: deviceSize.height * 0.08),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
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
                              spreadRadius: 3
                          )
                        ],
                      ),
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.search, size: 25,)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(onTap: () =>
                            setState(() {
                              _chatType = ChatType.users;
                            }),
                            child: Text('شات', style: TextStyle(fontSize: 17,
                                color: typeColor(ChatType.users)),)),
                        GestureDetector(onTap: () =>
                            setState(() {
                              _chatType = ChatType.groups;
                            }),
                            child: Text('مجموعات', style: TextStyle(fontSize: 17,
                                color: typeColor(ChatType.groups)),)),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    //-----------------online users ----------------
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: users.length,
                        itemBuilder: (context, index)=> onlineUsers(users[index]),
                      ),
                    ),

                    //-----------------online users ----------------
                    if(_chatType == ChatType.users) Expanded(
                      flex: 3,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: (context, index)=> InkWell(
                            onTap: ()=> GlobalMethods.navigate(context, TeacherChatMsgPage()),
                            child: Dismissible(
                                direction: DismissDirection.startToEnd,
                                background: Container(color: Colors.red,
                                  padding: const EdgeInsets.symmetric( horizontal: 16),
                                  margin: const EdgeInsets.only(left: 16),
                                  alignment: Alignment.centerRight,
                                  child: const Icon(Icons.volume_off_sharp, color: Colors.white,),),
                                key: Key(users[index]['userId'].toString()),
                                confirmDismiss: (direction)async {
                                  setState(() => users[index]['isMute'] = !users[index]['isMute']);
                                  return false;},
                                child: userChatContainer(users[index]))),
                      ),
                    ),

                    //-----------------group chat ----------------
                    if(_chatType == ChatType.groups) Expanded(
                      flex: 3,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: groups.length,
                        itemBuilder: (context, index)=> InkWell(
                          onTap: ()=> GlobalMethods.navigate(context, TeacherChatMsgPage()),
                          child: Dismissible(
                              direction: DismissDirection.startToEnd,
                              background: Container(color: Colors.red,
                                padding: const EdgeInsets.symmetric( horizontal: 16),
                                margin: const EdgeInsets.only(left: 16),
                                alignment: Alignment.centerRight,
                                child: const Icon(Icons.volume_off_sharp, color: Colors.white,),),
                              key: Key(groups[index]['groupId'].toString()),
                              confirmDismiss: (direction)async {
                                setState(() => groups[index]['isMute'] = !groups[index]['isMute']);
                                return false;},
                              child: groupChatContainer(groups[index])
                          ),
                        ),
                      ),
                    ),

                  ],
                ),),
            ),
            const CustomRowTitle(title: 'الدردشة',)

          ],
        ),
      ),
    );
  }

  Color typeColor(ChatType chatType){
    if(chatType == _chatType) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }

  Widget onlineUsers(user){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          UserImg(img: user['userImg'], isActive: user['isActive']),
          Text(user['userName'], style: const TextStyle(color: Colors.black),)
        ],
      ),
    );
  }

  Widget userChatContainer(user){
    return Row(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(user['time'], style: Theme.of(context).textTheme.bodySmall,),
                user['seen'] ? const Icon(Icons.done_all) : CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.unSeenMsgColor,
                  foregroundColor: Colors.white,
                  child: Text('${user['unSeenMsg']}'),
                ),
              ],
            ),
            const SizedBox(width: 5,),
            if(user['isMute']) const Icon(Icons.volume_off)
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(user['userName'], style: Theme.of(context).textTheme.headlineLarge,),
            Text(user['lastMsg'], style: Theme.of(context).textTheme.bodySmall,),
          ],
        ),
        const SizedBox(width: 6,),
        UserImg(img: user['userImg'], isActive: user['isActive']),
      ],
    );
  }

  Widget groupChatContainer(group){
    return Row(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(group['time'], style: Theme.of(context).textTheme.bodySmall,),
                group['seen'] ? const Icon(Icons.done_all) : CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.unSeenMsgColor,
                  foregroundColor: Colors.white,
                  child: Text('${group['unSeenMsg']}'),
                ),
              ],
            ),
            const SizedBox(width: 5,),
            if(group['isMute']) const Icon(Icons.volume_off)
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(group['groupName'], style: Theme.of(context).textTheme.headlineLarge,),
            Row(
              children: [
                Text('${group['lastMsgUser']}: ', style: Theme.of(context).textTheme.bodySmall,),
                Text(group['lastMsg'], style: Theme.of(context).textTheme.bodySmall,),
              ],
            ),
          ],
        ),
        const SizedBox(width: 6,),
        UserImg(img: group['groupImg'], isActive: false),
      ],
    );
  }

}

enum ChatType{
  users,
  groups
}