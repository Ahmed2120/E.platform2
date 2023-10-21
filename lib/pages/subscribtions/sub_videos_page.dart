import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pod_player/pod_player.dart';
import 'package:video_player/video_player.dart';

import '../../core/utility/app_colors.dart';
import '../components/show_network_image.dart';
import '../../widgets/text_fields/comment_field.dart';
import '../subscribtions/components/data.dart';
import '../videoComponant/videoPlayerScreen.dart';

class SubVideosPage extends StatefulWidget {
  const SubVideosPage({Key? key}) : super(key: key);

  @override
  State<SubVideosPage> createState() => _SubVideosPageState();
}

class _SubVideosPageState extends State<SubVideosPage> {

  late final PodPlayerController controller;
  VoidCallback? onClickedFullScreen;

  final _commentController = TextEditingController();

  PageContent _pageContent = PageContent.videos;

@override
  void initState() {
    super.initState();

    // controller = VideoPlayerController.network(
    //     videoPaths[0]['videoUrl'],)..addListener(() {setState(() {});})
    // ..initialize().then((_) => controller!.play());
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(
        videoPaths[0]['videoUrl'],
      ),
    )..initialise();
  }

  @override
  void dispose() {
    super.dispose();

    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('الدرس الاول'), actions: [IconButton(
          onPressed: ()=> Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
            ),
            child: const Icon(Icons.arrow_forward_ios_sharp,
              color: AppColors.primaryColor, size: 15,),
          ),
        )],
        automaticallyImplyLeading: false,),
        body: Column(
          children: [
            Expanded(child: VideoPlayerScreen(VideoURL: videoPaths[0]['videoUrl'],)),
            videoContent(context),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(onTap: () =>
                    setState(() {
                      _pageContent = PageContent.videos;
                    }),
                    child: Text('المحتويات', style: TextStyle(fontSize: 17,
                        color: typeColor(PageContent.videos)),)),
                GestureDetector(onTap: () =>
                    setState(() {
                      _pageContent = PageContent.comments;
                    }),
                    child: Text('التعليقات', style: TextStyle(fontSize: 17,
                        color: typeColor(PageContent.comments)),)),
                GestureDetector(onTap: () =>
                    setState(() {
                      _pageContent = PageContent.attachments;
                    }),
                    child: Text('المرفقات', style: TextStyle(fontSize: 17,
                        color: typeColor(PageContent.attachments)),)),
              ],
            ),
            const SizedBox(height: 10,),
            // ---------------------- videos ------------------
            if(_pageContent == PageContent.videos) Expanded(
                child: ListView.builder(
                  itemCount: videoPaths.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () => _onTapVideo(index),
                      child: nextVideo(videoPaths[index])),
                )),

            // ---------------------- comments ------------------
            if(_pageContent == PageContent.comments) Expanded(
                child: ListView.builder(
                  itemCount: allComments.length,
                  itemBuilder: (context, index) =>
                      videoComment(allComments[index]),
                )),
            if(_pageContent == PageContent.comments) Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommentField(
                loading: false,
                controller: _commentController, function: () {},),
            ),

            // ---------------------- attachments ------------------
            if(_pageContent == PageContent.attachments) Expanded(
                child: ListView.builder(
                  itemCount: allAttachments.length,
                  itemBuilder: (context, index) =>
                      videoAttachment(allAttachments[index]),
                )),

          ],
        ),
          );
  }

  Widget nextVideo(video) => ListTile(
    trailing: const Icon(Icons.check),
    title: Row(
      children: [
        ShowNetworkImage(img: video['videoImg'],),
        const SizedBox(width: 10,),
        Column(
          children: [
            Text(video['name'], style: Theme.of(context).textTheme.bodySmall,),
            Text(video['duration'], style: Theme.of(context).textTheme.bodySmall,),
          ],
        )
      ],
    ),
  );

  Widget videoComment(comment) => ListTile(
    leading: ShowNetworkImage(img: comment['userImg'], isCircle: true,),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(comment['userName'], style: const TextStyle(color: AppColors.primaryColor),),
        const SizedBox(width: 10,),
        Text(comment['comment']),
        const SizedBox(width: 10,),
        Row(
          children: [
            Text('رد', style: Theme.of(context).textTheme.labelSmall,),
            const SizedBox(width: 20,),
            Text('${comment['likesNo']}'),
            const Icon(Icons.favorite_border),
          ],
        )
      ],
    ),
  );

  Widget videoAttachment(attachment) => ListTile(
    leading: Image.asset(attachment['img'],),
    title: Text(attachment['title']),
    subtitle: Text(attachment['pagesNo']),
  );

  Widget videoContent(context) {
    return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Text('المقدمة', style: Theme.of(context).textTheme.titleMedium,),
                  const Spacer(),
                  IconButton(onPressed: ()=> rateDialog(), icon: const Icon(Icons.star, color: Colors.yellow,)),
                  const SizedBox(width: 40,),
                  Image.asset('assets/icons/ask.png'),
                  const SizedBox(width: 40,),
                  Image.asset('assets/icons/bookmark.png'),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(height: 60, width: 60, color: Colors.black,),
                      const Text('00:00')
                    ],
                  ),
                  Column(
                    children: [
                      Container(height: 60, width: 60, color: Colors.black,),
                      const Text('02:00')
                    ],
                  ),
                  Column(
                    children: [
                      Container(height: 60, width: 60, color: Colors.black,),
                      const Text('04:00')
                    ],
                  ),
                  Column(
                    children: [
                      Container(height: 60, width: 60, color: Colors.black,),
                      const Text('06:00')
                    ],
                  ),
                ],
              )
            ],
          ),
        );
  }

  Widget buildVideo()=> Stack(
    fit: StackFit.expand,
    children: [
      GestureDetector(
          behavior: HitTestBehavior.opaque,
          // onTap: ()=> controller!.value.isPlaying ? controller!.pause() : controller!.play(),
          child: buildVideoPlayer()
      ),
      Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Row(
            children: [
              const Icon(Icons.fullscreen, size: 28, color: Colors.white,),
              const SizedBox(width: 12,),
              // Expanded(child: buildIndicator()),
            ],
          ))
    ],
  );

  Widget buildVideoPlayer() {
    // if(controller != null && controller!.value.isInitialized) {
    return PodVideoPlayer(controller: controller);
    // }else{
    //   return const AspectRatio(
    //     aspectRatio: 16 / 9,
    //     child: Center(child: Text('preparing...'),),
    //   );
    // }
  }


  Color typeColor(PageContent pageContent){
    if(pageContent == _pageContent) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }

  _onTapVideo(int index){

    /* controller = VideoPlayerController.network(
      videoPaths[index]['videoUrl'],)..addListener(() {setState(() {});})
      ..initialize().then((_) => controller!.play()); */
    // controller = VideoPlayerController.network(
    //   videoURL,)..addListener(()
    // {setState(() {});})
    // ..initialize().then((_) => controller!.play());

    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(
        videoPaths[index]['videoUrl'],
      ),
    )..addListener(() {setState(() {});});
  }

  void rateDialog(){
    showDialog(context: context, barrierDismissible: false, builder: (context)=>
        AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: ()=> Navigator.pop(context),
                  child: const Icon(Icons.close, size: 40, color: Colors.black,)),
              Text('قيم الان', style: Theme.of(context).textTheme.titleMedium,),
              const SizedBox(width: 40,)
            ],),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: 3,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                onRatingUpdate: (rating) {},
              ),
              const SizedBox(height: 10,),
              CustomElevatedButton(title: 'تم', function: (){})
            ],
          ),
        )
    );
  }
}

enum PageContent{
  videos,
  comments,
  attachments
}
