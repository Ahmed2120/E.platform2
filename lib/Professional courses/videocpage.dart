import 'package:eplatform/model/courses/courseVideoComments.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/pages/components/show_network_image.dart';
import 'package:eplatform/pages/courses_and_groups/pdfPage.dart';
import 'package:eplatform/pages/videoComponant/videoPlayerScreen.dart';

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

import '../../widgets/text_fields/comment_field.dart';

class VideoCpsPage extends StatefulWidget {
  VideoCpsPage({Key? key}) : super(key: key);
  @override
  State<VideoCpsPage> createState() => _VideoCpsPageState();
}

class _VideoCpsPageState extends State<VideoCpsPage> {
  // VideoPlayerController? controller;
  late final PodPlayerController controller;
  VoidCallback? onClickedFullScreen;

  final _commentController = TextEditingController();

  PageContent _pageContent = PageContent.videos;

  int _selected_index = 0;
  String _selected_title = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الدرس الاول'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: AppColors.primaryColor,
                size: 15,
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: ScopedModelDescendant<MainModel>(
          builder: (context, child, MainModel model) {
        return Column(
          children: [
            Expanded(
                child:
                    // buildVideoPlayer()
                    _selected_index == 0
                        ? VideoPlayerScreen(
                            VideoURL:
                                'https://player.vimeo.com/progressive_redirect/playback/850664148/rendition/540p/file.mp4?loc=external&oauth2_token_id=57447761&signature=203f637167621b7b511017750ac06e1c26dc036f63564a46488b568e14156ea4')
                        : VideoPlayerScreen(
                            VideoURL:
                                'https://player.vimeo.com/progressive_redirect/playback/850664148/rendition/540p/file.mp4?loc=external&oauth2_token_id=57447761&signature=203f637167621b7b511017750ac06e1c26dc036f63564a46488b568e14156ea4',
                          )),

            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () => setState(() {
                          _pageContent = PageContent.videos;
                        }),
                    child: Text(
                      'المحتويات',
                      style: TextStyle(
                          fontSize: 17, color: typeColor(PageContent.videos)),
                    )),
                GestureDetector(
                    onTap: () => setState(() {
                          _pageContent = PageContent.comments;
                        }),
                    child: Text(
                      'التعليقات',
                      style: TextStyle(
                          fontSize: 17, color: typeColor(PageContent.comments)),
                    )),
                GestureDetector(
                    onTap: () => setState(() {
                          _pageContent = PageContent.attachments;
                        }),
                    child: Text(
                      'المرفقات',
                      style: TextStyle(
                          fontSize: 17,
                          color: typeColor(PageContent.attachments)),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // ---------------------- videos ------------------
            if (_pageContent == PageContent.videos)
              Expanded(
                  child: ListView.builder(
                itemCount: model.allCourseLessonDetails.length,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        _selected_index = index!;
                        _selected_title = 'hi';

                        model.fetchCourseVideo_Attachments_AND_Comments(
                            model.allCourseLessonDetails[index].CourseVideoId);
                        /*   if(_selected_index ==0) {
                            _onTapVideo(model.FirstLessonVideoUrl);
                          }
                          else{
                            _onTapVideo(model.allCourseLessonDetails[index].VideoUrl!);
                          }*/
                      });
                      setState(() {});
                    },
                    child:
                        nextVideo(model.allCourseLessonDetails[index], index)),
              )),

            // ---------------------- comments ------------------
            if (_pageContent == PageContent.comments)
              Expanded(
                  child: model.courseVideoAttachmentsLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: model.CourseVideoCommentsList.length,
                          //  itemCount: model.FirstLessonVideoComments.length,
                          itemBuilder: (context, index) =>
                              //  videoComment(model.FirstLessonVideoComments[index]),
                              videoComment(
                                  model.CourseVideoCommentsList[index]),
                        )),
            if (_pageContent == PageContent.comments)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommentField(
                    controller: _commentController,
                    function: () {
                      model.addCourseVideoComment(
                          model.allCourseLessonDetails[_selected_index]
                              .CourseVideoId,
                          _commentController.text,
                          _commentController);
                    },
                    loading: false),
              ),

            // ---------------------- attachments ------------------
            if (_pageContent == PageContent.attachments)
              Expanded(
                  child: model.courseVideoAttachmentsLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          //   itemCount: model.FirstLessonVideoAttachments.length,
                          itemCount: model.CourseVideoAttachmentsList.length,
                          itemBuilder: (context, index) => InkWell(
                              onTap: () async {
                                GlobalMethods.navigate(
                                    context,
                                    PdfPage(
                                      pdfUrl: model
                                          .CourseVideoAttachmentsList[index]
                                          .AttachmentUrl,
                                      title: model
                                          .CourseVideoAttachmentsList[index]
                                          .Title,
                                    ));
                                // PDF().cachedFromUrl('http://africau.edu/images/default/sample.pdf');
                              },
                              child: videoAttachment(
                                  model.CourseVideoAttachmentsList[index])),
                        )),
          ],
        );
      }),
    );
  }

  Widget nextVideo(LessonCourseVideo video, int index) => Container(
        color: index == _selected_index ? Colors.grey[200] : null,
        child: ListTile(
          trailing: Column(
            children: [
              Icon(
                Icons.check,
                color:
                    index == _selected_index! ? Colors.green : Colors.black38,
              ),
              Text(
                video.Duration.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          title: Row(
            children: [
              ShowNetworkImage(
                img: video.videoImg,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                video.Title.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      );

  Widget videoComment(CourseVideoComments comment) => ListTile(
        leading: ShowNetworkImage(
          img:
              'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1600',
          isCircle: true,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.UserName,
              style: const TextStyle(color: AppColors.primaryColor),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(comment.Comment),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Text(
                  'رد',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text('${5.toString()}'),
                const Icon(Icons.favorite_border),
              ],
            )
          ],
        ),
      );

  Widget videoAttachment(CourseVideoAttachments attachment) => ListTile(
        leading: Image.asset(
          'assets/icons/pdf.png',
        ),
        title: Text(attachment.Title),
        subtitle: Text(attachment.Description),
      );

  Widget buildVideo() => Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              // onTap: ()=> controller!.value.isPlaying ? controller!.pause() : controller!.play(),
              child: buildVideoPlayer()),
          Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Row(
                children: [
                  const Icon(
                    Icons.fullscreen,
                    size: 28,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
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

  Color typeColor(PageContent pageContent) {
    if (pageContent == _pageContent) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }

  _onTapVideo(String videoURL) {
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
    )..addListener(() {
        setState(() {});
      });
  }

  void rateDialog(index) {
    int rate_value = 3;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        size: 40,
                        color: Colors.black,
                      )),
                  Text(
                    'قيم الان',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    width: 40,
                  )
                ],
              ),
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
                        rate_value = rating.toInt();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomElevatedButton(title: 'تم', function: () {})
                ],
              ),
            ));
  }
}

enum PageContent { videos, comments, attachments }
