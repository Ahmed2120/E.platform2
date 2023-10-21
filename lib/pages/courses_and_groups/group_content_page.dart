import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_player/video_player.dart';

import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/group/group.dart';
import '../../model/group/groupVideo.dart';
import '../../model/group/teacherGroups.dart';
import '../../model/mainmodel.dart';
import '../components/custom_elevated_button.dart';
import '../components/show_network_image.dart';
import '../../widgets/text_fields/comment_field.dart';
import '../subscribtions/components/data.dart';
import '../videoComponant/videoPlayerScreen.dart';

class GroupContentPage extends StatefulWidget {
  const GroupContentPage({Key? key,required this.model,required this.teacherGroups ,required this.index})
      : super(key: key);

   final MainModel model;
   final TeacherGroups teacherGroups;
   final  int index;

  @override
  State<GroupContentPage> createState() => _GroupContentPageState();
}

class _GroupContentPageState extends State<GroupContentPage> {


  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.model.fetchGroupDetails(widget.teacherGroups.GroupId);
    return ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
          appBar: AppBar(title:Text(widget.teacherGroups.Title), actions: [
            IconButton(
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
            body: model.GroupDetailsLoading?
                Center(child: CircularProgressIndicator()):
            Column(
            children: [
              Expanded(child: VideoPlayerScreen(VideoURL: model.GroupDetailsIntroVideoURL)
               // buildVideoPlayer()
              ),
              Expanded(
                flex: 2,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  children: [
                    Text(model.GroupDetailsTeacherName, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                    const SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        descriptionContainer(model.GroupDetailsSubjectName, 'assets/icons/book-description.png'),
                        descriptionContainer(model.GroupDetailsGradeName, 'assets/icons/level-description.png'),
                        descriptionContainer('مجموعات', 'assets/icons/course-description.png'),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    Text(model.GroupDetailsDescription,
                      style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center,),
                    const SizedBox(height: 12,),
                    information(context, title: 'السعر', subTitle: '${GlobalMethods.showPrice(model.GroupDetailsPrice.toString())}'),
                    information(context, title: 'المواعيد', subTitle: model.GroupDetailsDays),
                    information(context, title: 'تاريخ البداية', subTitle: model.GroupDetailsStartDate),
                    information(context, title: 'مدة الاشتراك', subTitle: model.GroupDetailsGroupPeriod),
                    information(context, title: 'عدد الحصص',
                        subTitle: model.GroupDetailsSessionsCount.toString()+' حصة '),
                    const SizedBox(height: 8,),
                    widget.teacherGroups.IsSubscribed?Container():
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: widget.model.subscribeGroupsLoading?Center(child: CircularProgressIndicator()):
                      CustomElevatedButton(title: 'اشترك الان', function: ()=>showSubscribeDialog(

                      )),
                    ),
                    const SizedBox(height: 5,),
                    if(model.allGroupDetailsGroupVideo.isNotEmpty) SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: model.allGroupDetailsGroupVideo.length,
                        itemBuilder: (context, index)=>
                            classContainer(context, model.allGroupDetailsGroupVideo[index], index + 1),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }

  Container classContainer(context, GroupVideo groupVideo, int classNum) {
     return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric( vertical: 5, horizontal: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 5,
                color: Colors.grey
            )
          ]
      ),
       child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('الحصة $classNum', style: TextStyle(fontSize: 14, color: Colors.black),),
              Text(groupVideo.Title, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis, softWrap: false, maxLines: 1,),
            ],
          ),
          const Spacer(),
          Column(
            children:  [
              Text(GlobalMethods().scheduleDateFormat(DateTime.parse(groupVideo.ClassAt))),
              Text(' ${groupVideo.FromTime} : ${groupVideo.ToTime}'),
            ],
          ),
        ],
      ),
    );
  }

  Row information(BuildContext context, {required String title, required String subTitle}) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                Text(subTitle),
              ],
            );
  }

  Container descriptionContainer(String title, String img) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontSize: 10, color: AppColors.descriptionColor),),
          const SizedBox(width: 5,),
          ImageIcon(AssetImage(img)),
        ],
      ),
    );
  }

 /* Widget buildVideo()=> Stack(
    fit: StackFit.expand,
    children: [
      GestureDetector(
          behavior: HitTestBehavior.opaque,
        //  onTap: ()=> controller!.value.isPlaying ? controller!.pause() : controller!.play(),
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
            //  Expanded(child: buildIndicator()),
            ],
          ))
    ],
  );

  Widget buildVideoPlayer() {
    return PodVideoPlayer(controller: controller);

  /*  if(controller != null && controller!.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller!),
      );
    }else{
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: Text('preparing...'),),
      );
    }*/
  }

 // Widget buildIndicator() => Container(
    //height: 10,
    //margin: const EdgeInsets.all(8).copyWith(right: 0),
    //child: Directionality(textDirection: TextDirection.ltr,
      //  child: VideoProgressIndicator(controller!, allowScrubbing: true,
    //      colors: const VideoProgressColors(playedColor: AppColors.primaryColor),)),
  //); */


  void showSubscribeDialog(){
    showDialog(context: context, barrierDismissible: false, builder: (context)=>
    AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: ()=> Navigator.pop(context),
                  child: const Icon(Icons.close, size: 40, color: Colors.black,)),
              Text('', style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(width: 40,)
            ],),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(' سيتم خصم ${widget.model.GroupDetailsPrice} من محفظتك للاشتراك في المجموعة ',
                style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
             SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(title: 'تأكيد', function: (){
                    widget.model.subscribeGroup(widget.teacherGroups.GroupId,context,widget.index);
                    if(mounted){
                      Navigator.pop(context);
                    }

                  }),
                  CustomElevatedButton(title: 'الغاء', function: (){
                    Navigator.pop(context);
                  }, color: AppColors.cancelColor,),
                ],
              )
            ],
          )
        ));
  }
}
