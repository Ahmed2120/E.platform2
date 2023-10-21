
import 'package:eplatform/model/courses/courseVideoComments.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/courses_and_groups/pdfPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:pod_player/pod_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_player/video_player.dart';
import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/courses/lessonCourseVideos.dart';
import '../../model/courses/courseLessons.dart';
import '../../model/courses/courseVideoAttachments.dart';
import '../components/custom_elevated_button.dart';
import '../components/show_network_image.dart';
import '../../widgets/text_fields/comment_field.dart';
import '../videoComponant/videoPlayerScreen.dart';

class VideosPage extends StatefulWidget {
   VideosPage({ required this.model,
     required this.courseLessons,Key? key}) : super(key: key);
    MainModel model;
   CourseLessons courseLessons;
  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {

  // VideoPlayerController? controller;
  late final PodPlayerController controller;
  VoidCallback? onClickedFullScreen;

  final _commentController = TextEditingController();

  PageContent _pageContent = PageContent.videos;

  int _selected_index=0;
  String _selected_title='';

   @override
  void initState()  {
    super.initState();
       widget.model.fetchCourseLessonDetails(widget.courseLessons.LessonId);

     /* controller = VideoPlayerController.network(
      videoPaths[0]['videoUrl']
      ,)..addListener(() {
        setState(() {});})
    ..initialize().then((_) => controller!.play()); */

    // controller = VideoPlayerController.network(
    //    widget.model.FirstLessonVideoUrl
    //   ,)..addListener(() {
    //        setState(() {});})
    //   ..initialize().then((_) => controller!.play());


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('${widget.courseLessons.LessonTitle}'), actions: [IconButton(
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
        body: ScopedModelDescendant<MainModel>(
            builder:(context,child,MainModel model){
              return  model.CourseLessonDetailsLoading ==true?
              Center(child: CircularProgressIndicator())
              :Column(
                    children: [
                    Expanded(child:
                      // buildVideoPlayer()
                     _selected_index==0?
                      VideoPlayerScreen(
                        VideoURL:  model.FirstLessonVideoUrl):
                        VideoPlayerScreen(VideoURL:  model.allCourseLessonDetails[_selected_index].VideoUrl!,)
                    ),
                      videoContent(context,model),
                   const SizedBox(height: 10,),
                           Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                GestureDetector(onTap: () =>
                                setState(() {
                                _pageContent = PageContent.videos;
                                     }),
                                      child: Text('المحتويات',
                                        style: TextStyle(fontSize: 17,
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
                  itemCount: model.allCourseLessonDetails.length,
                       itemBuilder: (context, index) =>
                      InkWell(
                       onTap: () {
                        setState(() {
                          _selected_index=index!;
                          _selected_title=model.allCourseLessonDetails[index].Title!;

                          model.fetchCourseVideo_Attachments_AND_Comments
                            (model.allCourseLessonDetails[index]
                              .CourseVideoId);
                       /*   if(_selected_index ==0) {
                            _onTapVideo(model.FirstLessonVideoUrl);
                          }
                          else{
                            _onTapVideo(model.allCourseLessonDetails[index].VideoUrl!);
                          }*/
                        });
                        setState(() {

                        });

                      },
                      child: nextVideo(model.allCourseLessonDetails[index],index)),
                )),

             // ---------------------- comments ------------------
                if(_pageContent == PageContent.comments) Expanded(
                  child:model.courseVideoAttachmentsLoading ?
                   Center(child: CircularProgressIndicator())
                  : ListView.builder(
                  itemCount: model.CourseVideoCommentsList.length,
                  //  itemCount: model.FirstLessonVideoComments.length,
                    itemBuilder: (context, index) =>
                     //  videoComment(model.FirstLessonVideoComments[index]),
                    videoComment(model.CourseVideoCommentsList[index]),
                )),
                     if(_pageContent == PageContent.comments) Padding(
                       padding: const EdgeInsets.all(8.0),
                        child: CommentField(
                         controller: _commentController,
                          function: () {
                         model.addCourseVideoComment(
                             model.allCourseLessonDetails[_selected_index].
                             CourseVideoId,
                           _commentController.text,_commentController);
                        },loading: widget.model.AddCourseCommentLoading,),
                     ),

            // ---------------------- attachments ------------------
               if(_pageContent == PageContent.attachments) Expanded(
                child:model.courseVideoAttachmentsLoading ?
                Center(child: CircularProgressIndicator()) :
                ListView.builder(
               //   itemCount: model.FirstLessonVideoAttachments.length,
                  itemCount: model.CourseVideoAttachmentsList.length,
                  itemBuilder: (context, index) =>
                      InkWell(
                        onTap: () async{
                          GlobalMethods.navigate(context, PdfPage(
                           pdfUrl:model.CourseVideoAttachmentsList[index].AttachmentUrl,
                            title:model.CourseVideoAttachmentsList[index].Title ,));
                         // PDF().cachedFromUrl('http://africau.edu/images/default/sample.pdf');
                        },
                          child: videoAttachment(model.CourseVideoAttachmentsList[index])),
                )),
          ],
        ) ;}),
          );
  }

  Widget nextVideo(LessonCourseVideo video,int index) => Container(
    color: index==_selected_index ? Colors.grey[200] : null,
    child: ListTile(
      trailing:  Column(
        children: [
          Icon(
              Icons.check,
            color: index==_selected_index! ? Colors.green : Colors.black38,
          ),
          Text(video.Duration.toString(), style: Theme.of(context).textTheme.bodySmall,),
        ],
      ),
      title: Row(
        children: [
          ShowNetworkImage(img: video.videoImg,),
          const SizedBox(width: 10,),
          Text(video.Title.toString(), style: Theme.of(context).textTheme.bodySmall,)
        ],
      ),
    ),
  );

  Widget videoComment(CourseVideoComments comment) => ListTile(
    leading: ShowNetworkImage(img:
    'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1600',
      isCircle: true,),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(comment.UserName, style: const TextStyle(color: AppColors.primaryColor),),
        const SizedBox(width: 10,),
        Text(comment.Comment),
        const SizedBox(width: 10,),
        Row(
          children: [
            Text('رد', style: Theme.of(context).textTheme.labelSmall,),
            const SizedBox(width: 20,),
            Text('${5.toString()}'),
            const Icon(Icons.favorite_border),
          ],
        )
      ],
    ),
  );

  Widget videoAttachment(CourseVideoAttachments attachment) =>
      ListTile(
         leading: Image.asset('assets/icons/pdf.png',),
          title: Text(attachment.Title),
           subtitle: Text(attachment.Description),
  );

  Widget videoContent(context,model) {
    return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    _selected_index==0? widget.model.FirstVideoTitle :
                        _selected_title
                    , style: Theme.of(context).textTheme.titleMedium,),
                  const Spacer(),
                  Column(
                    children: [
                      InkWell(onTap: ()=>
                          rateDialog(_selected_index),
                          child: const Icon(Icons.star, color: Colors.yellow,)),
                      Text('قيم', style: TextStyle(color: Colors.black),)
                    ],
                  ),
                  const SizedBox(width: 40,),
                  Column(
                    children: [
                      Image.asset('assets/icons/ask.png'),
                      Text('اسئل', style: TextStyle(color: Colors.black),)
                    ],
                  ),
                  const SizedBox(width: 40,),
                  Column(
                    children: [
                      Image.asset('assets/icons/bookmark.png'),
                      Text('حفظ', style: TextStyle(color: Colors.black),)
                    ],
                  ),
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

  // Widget buildIndicator() => Container(
  //   height: 10,
  //       margin: const EdgeInsets.all(8).copyWith(right: 0),
  //       child: Directionality(textDirection: TextDirection.ltr,
  //           child: VideoProgressIndicator(controller!, allowScrubbing: true,
  //             colors: const VideoProgressColors(playedColor: AppColors.primaryColor),)),
  //     );

  Color typeColor(PageContent pageContent){
    if(pageContent == _pageContent) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }

  _onTapVideo(String videoURL){

    /* controller = VideoPlayerController.network(
      videoPaths[index]['videoUrl'],)..addListener(() {setState(() {});})
      ..initialize().then((_) => controller!.play()); */
      // controller = VideoPlayerController.network(
      //   videoURL,)..addListener(()
      // {setState(() {});})
      // ..initialize().then((_) => controller!.play());

      controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(
          videoURL,
        ),
      )..addListener(() {setState(() {});});
  }

  void rateDialog(index){
     int rate_value=3;
       showDialog(context: context, barrierDismissible: false,
        builder: (context)=>
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
                onRatingUpdate: (rating) {
                  setState(() {
                    rate_value=rating.toInt();
                  });
                },
              ),
              const SizedBox(height: 10,),
              widget.model.AddCourseRateLoading1==true ?
                 Center(child: CircularProgressIndicator())
             :CustomElevatedButton(title: 'تم',
                 function: (){
                widget.model.addCourseVideoRate(
                    widget.model.allCourseLessonDetails[index]
                    .CourseVideoId, rate_value , context);
              })
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
