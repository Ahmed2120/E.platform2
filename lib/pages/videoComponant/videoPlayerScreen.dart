import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.VideoURL});
  final String VideoURL;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final PodPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(widget.VideoURL),
    )..initialise();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(controller: controller);
  }

  _onTapVideo(String videoURL) {
    /*  controller = VideoPlayerController.network(
      videoPaths[index]['videoUrl'],)..addListener(() {setState(() {});})
      ..initialize().then((_) => controller!.play());*/
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(
        videoURL,
      ),
    )..addListener(() {
        setState(() {});
      });
  }
}
