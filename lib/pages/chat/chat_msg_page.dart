import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/chat/singleChatMessage.dart';
import '../../model/chat/teachersToChat.dart';
import '../../model/mainmodel.dart';
import '../../session/userSession.dart';
import '../../widgets/chat/msg_field.dart';
import '../../widgets/chat/user_img.dart';
import 'convertDateToTxt.dart';

class ChatMsgPage extends StatefulWidget {
  ChatMsgPage({required this.model, required this.teachersToChat, Key? key})
      : super(key: key);
  MainModel model;
  TeachersToChat teachersToChat;

  @override
  State<ChatMsgPage> createState() => _ChatMsgPageState();
}

class _ChatMsgPageState extends State<ChatMsgPage> {
  final _msgController = TextEditingController();

  final _controller = ScrollController();
  String? _userName;
  String? _userImg;
  int _page = 0;
  bool has_more = true;
  int limit = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.model.fetchSingleChatMessages(
        widget.teachersToChat.TeacherUserId, _page, limit);


    _getUserData();

    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        _fetch();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              //   height: MediaQuery.of(context).size.height,
              color: AppColors.primaryColor,
            ),
            Container(
              margin: EdgeInsets.only(top: deviceSize.height * 0.11),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              decoration: const BoxDecoration(
                  color: AppColors.pageBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                children: [
                  Expanded(
                    child: model.SingleChatMessageLoading
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                controller: _controller,
                                reverse: true,
                                itemCount:
                                    model.AllSingleChatMessageList.length + 1,
                                // itemCount: _allMsg.length+1,
                                itemBuilder: (context, index) {
                                  return index <
                                          model.AllSingleChatMessageList.length
                                      ? model.AllSingleChatMessageList[index]
                                              .IsSender
                                          ? senderContainer(model
                                              .AllSingleChatMessageList[index])
                                          : receiverContainer(model
                                              .AllSingleChatMessageList[index])
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          child: Center(
                                              child: model
                                                      .moreSingleChatMessageLoading
                                                  ? CircularProgressIndicator()
                                                  : Text('')),
                                        );
                                }),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: MsgField(
                      MsgLoading: model.MsgLoading,
                      controller: _msgController,
                      function: () {
                        model.sendSingleChatMessages(
                            widget.teachersToChat.TeacherUserId,
                            _msgController.text,
                            _msgController);

                        setState(() {
                          _page = 0;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              height: deviceSize.height * 0.10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(widget.teachersToChat.TeacherName,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      Text('متصل الان',
                          style: TextStyle(fontSize: 13, color: Colors.white)),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  UserImg(
                    img: widget.teachersToChat.ProfilePicture,
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
            ),
          ],
        );
      })),
    );
  }

  Widget senderContainer(SingleChatMessage singleChatMessage) {
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
                child: Text(
                  singleChatMessage.Text,
                  style: const TextStyle(color: Colors.white),
                  textDirection: GlobalMethods.rtlLang(singleChatMessage.Text)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                )),
            const SizedBox(
              width: 6,
            ),
            Column(
              children: [
                const Icon(
                  Icons.done_all,
                  color: Colors.white,
                ),
                Text(
                  ConvertDateToTxt.dateConverter(singleChatMessage.SentAt),
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget receiverContainer(SingleChatMessage singleChatMessage) {
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
                child: Text(
                  singleChatMessage.Text,
                  style: const TextStyle(color: Colors.black),
                  textDirection: GlobalMethods.rtlLang(singleChatMessage.Text)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                )),
            const SizedBox(
              width: 6,
            ),
            Text(
              ConvertDateToTxt.dateConverter(singleChatMessage.SentAt),
              style: const TextStyle(fontSize: 10, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  void _getUserData() async {
    Map session = await UserSession.GetData();
    _userName = session['name'];
    _userImg = session['profilePicture'];
  }

  void _fetch() async {
    setState(() {
      _page++;
    });

    await widget.model.fetchSingleChatMessages(
        widget.teachersToChat.TeacherUserId, _page, limit);
  }
}
