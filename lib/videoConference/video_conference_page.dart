// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

// Project imports:
import 'common.dart';
import 'constants.dart';

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;
   final Map session;

   const VideoConferencePage({
    Key? key,
    required this.conferenceID,required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: 1546517589 /*input your AppID*/,
        appSign: '95dc3be9dc326a2e8fa9aabb30fdaa9a8cf0873e68adcbe73a482ed94ed9e9d5' /*input your AppSign*/,
        userID: session['userId'],
        userName: session['name'],
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig()
          ..avatarBuilder = customAvatarBuilder,
      ),
    );
  }
}
