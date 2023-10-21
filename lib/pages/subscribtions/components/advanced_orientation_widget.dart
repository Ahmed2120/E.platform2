import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../core/utility/app_colors.dart';

class AdvancedOrientationWidget extends StatelessWidget {
  const AdvancedOrientationWidget({Key? key, required this.controller, required this.onClickedFullScreen}) : super(key: key);

  final VideoPlayerController controller;
  final VoidCallback onClickedFullScreen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
        onTap: ()=> controller.value.isPlaying ? controller.pause() : controller.play(),
        child: buildVideo()
    );
  }

  Widget buildVideoPlayer() {
    if(controller != null && controller!.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller!),
      );
    }else{
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: Text('preparing...'),),
      );
    }
  }

  Widget buildVideo()=> Stack(
    fit: StackFit.expand,
    children: [
      GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: ()=> controller!.value.isPlaying ? controller!.pause() : controller!.play(),
          child: buildVideoPlayer()
      ),
      Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Row(
            children: [
              GestureDetector(child: Icon(Icons.fullscreen, size: 28, color: Colors.white,),
              onTap: onClickedFullScreen,
              ),
              SizedBox(width: 12,),
              Expanded(child: buildIndicator()),
            ],
          ))
    ],
  );

  Widget buildIndicator() => Container(
    height: 10,
    margin: const EdgeInsets.all(8).copyWith(right: 0),
    child: Directionality(textDirection: TextDirection.ltr,
        child: VideoProgressIndicator(controller!, allowScrubbing: true,
          colors: const VideoProgressColors(playedColor: AppColors.primaryColor),)),
  );
}
