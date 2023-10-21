import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_player/video_player.dart';

import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/mainmodel.dart';
import '../../model/privateGroup/PrivateGroup.dart';
import '../components/custom_elevated_button.dart';
import '../components/show_network_image.dart';
import '../../widgets/text_fields/comment_field.dart';
import '../subscribtions/components/data.dart';
import '../videoComponant/videoPlayerScreen.dart';

class PriGroupContentPage extends StatefulWidget {
  const PriGroupContentPage({required this.model,required this.teacherGroups,Key? key}) : super(key: key);
  final MainModel model;
  final PrivateGroup teacherGroups;
  @override
  State<PriGroupContentPage> createState() => _PriGroupContentPageState();
}

class _PriGroupContentPageState extends State<PriGroupContentPage> {

  VideoPlayerController? controller;
  VoidCallback? onClickedFullScreen;

  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.model.fetchGroupDetails(widget.teacherGroups.GroupId);
    controller = VideoPlayerController.network(
        widget.model.GroupDetailsIntroVideoURL
    )..addListener(() {setState(() {});})
      ..initialize().then((_) => controller!.play());
  }

  @override
  void dispose() {
    super.dispose();

    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
        return Scaffold(
          appBar: AppBar(title: Text(widget.teacherGroups.Title), actions: [IconButton(
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
          body:  model.GroupDetailsLoading?
           Center(child: CircularProgressIndicator()):
          Column(
            children: [
          Expanded(child: VideoPlayerScreen(VideoURL: model.GroupDetailsIntroVideoURL)),
              Expanded(
                flex: 2,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  children: [
                    Text(model.GroupDetailsTeacherName,
                      style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                    const SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        descriptionContainer(model.GroupDetailsSubjectName,
                            'assets/icons/book-description.png'),
                        descriptionContainer(model.GroupDetailsGradeName,
                            'assets/icons/level-description.png'),
                        descriptionContainer('كورسات', 'assets/icons/course-description.png'),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    Text('اشترك في المجموعة تحصل على كورس مسجل هدية مدته 3 ساعات مجانا', style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center,),
                    const SizedBox(height: 12,),
                    information(context, title: model.GroupDetailsTeacherName,
                        subTitle: GlobalMethods.showPrice(model.GroupDetailsPrice)),
                    information(context, title: 'المواعيد', subTitle: ' السبت والثلاثاء '),
                    information(context, title: 'تاريخ البداية', subTitle: model.GroupDetailsStartDate),
                    information(context, title: 'مدة الاشتراك', subTitle: model.GroupDetailsGroupPeriod),
                    information(context, title: 'عدد الحصص',
                        subTitle: model.GroupDetailsSessionsCount.toString()+' حصة '),
                    const SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: CustomElevatedButton(title: 'اشترك الان', function: ()=>showSubscribeDialog()),
                    ),
                    const SizedBox(height: 5,),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index)=> classContainer(context),
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

  Container classContainer(context) {
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('الحصة الاولي', style: TextStyle(fontSize: 14, color: Colors.black),),
              Text('عنوان الدرس', style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
          const Spacer(),
          Column(
            children: const [
              Text('1/6/2023'),
              Text(' 9:00 : 10:00 A.M'),
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
              const Icon(Icons.fullscreen, size: 28, color: Colors.white,),
              const SizedBox(width: 12,),
              Expanded(child: buildIndicator()),
            ],
          ))
    ],
  );

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

  Widget buildIndicator() => Container(
    height: 10,
    margin: const EdgeInsets.all(8).copyWith(right: 0),
    child: Directionality(textDirection: TextDirection.ltr,
        child: VideoProgressIndicator(controller!, allowScrubbing: true,
          colors: const VideoProgressColors(playedColor: AppColors.primaryColor),)),
  );

  _onTapVideo(int index){
    controller = VideoPlayerController.network(
      videoPaths[index]['videoUrl'],)..addListener(() {setState(() {});})
      ..initialize().then((_) => controller!.play());
  }

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
                Text('سيتم خصم 50\$ من محفظتك للاشتراك في مجموعة أ/احمد', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomElevatedButton(title: 'تأكيد', function: (){}),
                    CustomElevatedButton(title: 'الغاء', function: (){}, color: AppColors.cancelColor,),
                  ],
                )
              ],
            )
        ));
  }
}
