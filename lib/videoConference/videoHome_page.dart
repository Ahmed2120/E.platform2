// Dart imports:

// Flutter imports:
import 'package:eplatform/session/userSession.dart';
import 'package:flutter/material.dart';

import 'video_conference_page.dart';


class VideoHomePage extends StatefulWidget {
  const VideoHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  /// Users who use the same conferenceID can in the same conference.
  var conferenceDTextCtrl = TextEditingController(text: 'Teaching@Code');
  Map _session={};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: conferenceDTextCtrl,
                  decoration: const InputDecoration(
                      labelText: 'كود اللايف'),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return VideoConferencePage(
                          conferenceID: conferenceDTextCtrl.text,
                          session: _session,
                        );
                      }),
                    );
                  },
                  child: const Text('انضم'))
            ],
          ),
        ),
      ),
    );
  }
  _getUserData() async{
    _session=await UserSession.GetData();

    setState(() {});
  }
}
