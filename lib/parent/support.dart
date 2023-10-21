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

class SupportParent extends StatefulWidget {
  SupportParent({Key? key}) : super(key: key);

  @override
  State<SupportParent> createState() => _SupportParentState();
}

class _SupportParentState extends State<SupportParent> {
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
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 70),
                        child: Container(
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
                                    constraints: const BoxConstraints(
                                        minWidth: 100, maxWidth: 200),
                                    child: Text(
                                      'اهلا بك اقدر اساعدك ازاي',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    )),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  '',
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Image.asset('assets/images/Vector.png'),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _controller,
                        reverse: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          minWidth: 100, maxWidth: 200),
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: Text(
                                        'صباح الخير',
                                        style: TextStyle(color: Colors.white),
                                        textDirection:
                                            GlobalMethods.rtlLang('صباح الخير')
                                                ? TextDirection.rtl
                                                : TextDirection.ltr,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 70),
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        decoration: const BoxDecoration(
                                            color: AppColors.receiverColor,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                                bottomLeft:
                                                    Radius.circular(15))),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth: 100,
                                                        maxWidth: 200),
                                                child: Text(
                                                  'صباح النور',
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  textDirection:
                                                      GlobalMethods.rtlLang(
                                                              'صباح النور')
                                                          ? TextDirection.rtl
                                                          : TextDirection.ltr,
                                                )),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              '',
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: MsgField(
                      MsgLoading: model.MsgLoading,
                      controller: _msgController,
                      function: () {
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
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text('التواصل مع الدعم ',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                  const SizedBox(
                    width: 20,
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

  Widget senderContainer() {
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
                  'hello',
                  style: const TextStyle(color: Colors.white),
                  textDirection: GlobalMethods.rtlLang('hi')
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
                  'صباح الخير',
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget receiverContainer() {
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
                  'hi',
                  style: const TextStyle(color: Colors.black),
                  textDirection: GlobalMethods.rtlLang('hii')
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                )),
            const SizedBox(
              width: 6,
            ),
            Text(
              'hiiii',
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
  }
}
