import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/pages/courses_and_groups/groups_page.dart';
import 'package:eplatform/teacher/pages/create_course/components/create_course_dropDown.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pod_player/pod_player.dart';

import '../../../api/api.dart';
import '../../../api/teacherCall.dart';
import '../../../core/utility/app_colors.dart';
import '../../../model/customModel.dart';
import '../../../model/teacher/curency.dart';
import '../../../pages/components/custom_dotted_border.dart';
import '../../../session/userSession.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/text_fields/change_value_field.dart';
import 'components/course_file_field.dart';
import 'components/create_course_field.dart';
import 'components/multiselect_dropdown.dart';
import 'package:path/path.dart';

class CreateCourseLessonPage extends StatefulWidget {
  CreateCourseLessonPage({required this.courseId,Key? key}) : super(key: key);
   int courseId;
  @override
  State<CreateCourseLessonPage> createState() => _CreateCourseLessonPageState();
}

class _CreateCourseLessonPageState extends State<CreateCourseLessonPage> {

  List _CoursePrices=[];

  String? videoDuration;

  bool _Loading=false;
  bool _lesson_Loading=false;


  bool _isFree=false;

  Map courseFiles =
    {
      'video': null,
      'file': null,
      'title': null,
      'price': null,
    };


  List attachments = [null];
  List videos = [null];

  final _courseNameController = TextEditingController();
  final _videoNameController = TextEditingController();
  final _videoDescController = TextEditingController();
  final _videoDurationController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCourseData();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'انشاء درس',
        child: ListView(
              shrinkWrap: true,
              children: [
                Text('اسم الدرس', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                CreateCourseField(controller: _courseNameController, hintText: 'اسم الدرس'),

                const SizedBox(height: 8,),

                Text('اسم الفيديو', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                CreateCourseField(controller: _videoNameController, hintText: 'اسم الفيديو'),

                const SizedBox(height: 8,),

                Text('وصف الفيديو', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                CreateCourseField(controller: _videoDescController, hintText: 'الوصف'),

                const SizedBox(height: 8,),

                CheckboxListTile(
                  title: Text(
                    "مجاني",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  value: _isFree,
                  onChanged: (newValue) {
                    _isFree = newValue!;
                    setState(() {});
                  },
                  // controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),

                const SizedBox(height: 8,),
                if (!_isFree) Text('سعر الدرس', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                if (!_isFree) _Loading?CircularProgressIndicator():
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _CoursePrices.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index)=> Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_CoursePrices[index]['CurrencyName'], style: Theme.of(context).textTheme.bodySmall,),
                      SizedBox(
                        width: 100,
                        child: ChangeValueField(hintText: 'السعر', onChange: (value){
                          _CoursePrices[index]['Price'] = value==null ? 0.0
                              : double.parse(value);
                          setState(() {

                          });
                        },input:  TextInputType.number,),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 8,),

                Text('فيديوهات', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: videos.length,
                  itemBuilder: (context, index)=>
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            width: 130,
                            child: InkWell(
                              onTap: () async{
                                final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
                                if(picked == null) return;
                                videos[index] = picked;
                                setState(() {});
                              },
                              child: CustomDottedBorder(
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/promo.png'),
                                    Text(videos[index] != null ? basename(videos[index].path)
                                        : 'رفع فيديو', style: const TextStyle(fontSize: 14),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15,),
                          if(index == videos.length - 1)
                            InkWell(
                                onTap: (){
                                  videos.add(null);
                                  setState(() {});
                                },

                                child: const Icon(Icons.add_circle_sharp, color: AppColors.primaryColor, size: 60,))
                        ],
                      )
                  ,
                ),

                          // InkWell(
                          //   onTap: () async{
                          //     final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
                          //     if(picked == null) return;
                          //
                          //     final controller = VideoPlayerController.file(File(picked.path));
                          //     controller.initialize().then((_) {
                          //       // Get the duration of the video.
                          //       videoDuration = controller.value.duration.inMinutes.toString().padLeft(2, '0') + ":" + controller.value.duration.inSeconds.toString().padLeft(2, '0');
                          //     });
                          //
                          //
                          //     courseFiles['video'] = picked;
                          //     setState(() {});
                          //   },
                          //   child: CustomDottedBorder(
                          //     child: Column(
                          //       children: [
                          //         Image.asset('assets/images/promo.png'),
                          //         Text(courseFiles['video'] != null ? basename(courseFiles['video'].path)
                          //             : 'رفع فيديو', style: const TextStyle(fontSize: 14),),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                const SizedBox(height: 8,),
                Text('مرفقات', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: attachments.length,
                  itemBuilder: (context, index)=>
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            width: 130,
                            child: InkWell(
                              onTap: () async{
                                final picked = await pickFile();
                                if(picked == null) return;
                                attachments[index] = picked;
                                setState(() {});
                              },
                              child: CustomDottedBorder(
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/promo.png'),
                                    Text(attachments[index] != null ?
                                    basename(attachments[index].path) : 'رفع ملف', style: const TextStyle(fontSize: 14),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15,),
                          if(index == attachments.length - 1)
                            InkWell(
                                onTap: (){
                                  attachments.add(null);
                                  setState(() {});
                                },

                                child: const Icon(Icons.add_circle_sharp, color: AppColors.primaryColor, size: 60,))
                        ],
                      )
                  ,
                ),
                const SizedBox(height: 20,),
                _lesson_Loading?const Center(child: CircularProgressIndicator()):
                CustomElevatedButton(title: 'ارسال',
                    function:_addCourseLesson
                )
              ],
            )

      ),
    );
  }

  Future<File?> pickFile() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (picked != null) {
      return File(picked.files.single.path!);
    }
  }

  ElevatedButton buildElevatedButton(String title, Function function) {
    return ElevatedButton(
      onPressed: () => function(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(40),
      ),
      child: Text(title),
    );
  }


  void _addCourseLesson()  async{
    setState(() {
      _lesson_Loading=true;
    });

    List<Map<String, dynamic>>  _lessonPrices=[];

    for(int i=0;i<_CoursePrices.length;i++){
      _lessonPrices.add({
        'CurrencyId':_CoursePrices[i]['CurrencyId'],
        'Price':_CoursePrices[i]['Price'].toInt()
      });
    }

    List<String>  AttachmentUrl  =[];
    for(int i=0;i<attachments.length;i++){
      if(attachments[i] == null) continue;
      AttachmentUrl.add( attachments[i].path);
    }
    List<String>  VidetUrl  =[];
    for(int i=0;i<videos.length;i++){
      if(videos[i] == null) continue;
      VidetUrl.add( videos[i].path);
    }

    Map<String, String> data={
     "CourseId": widget.courseId.toString(),
     "Title": _courseNameController.text,
     "Prices":jsonEncode(_lessonPrices),
     "VideoTitle" :_videoNameController.text,
     "VideoDescription":_videoDescController.text,
     "Duration":videoDuration??'',
      "Free": _isFree.toString(),
    };
     print(' lesson data   '+data.toString());

    try {
      var response =await CallApi().postJsonAndFileCourseLesson(data,VidetUrl,
          AttachmentUrl, "/api/Course/AddCourseLesson", 1);
      if (response != null && response.statusCode == 200) {
        ShowMyDialog.showMsg("تم إضافة الدرس بنجاح");
      }
      else {
        ShowMyDialog.showMsg(response.reasonPhrase);
      }
      setState(() {
        _lesson_Loading=false;
      });
    }
    catch(e){
      setState(() {
        _lesson_Loading=false;
      });
      print(' add Course  ee '+e.toString());
    }
  }

  void  _getCourseData()  async{

    setState(() {
      _Loading=true;
    });

    Map <String,dynamic>data={
      'courseId':widget.courseId.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,"/api/Course/GetCourseById",1);
      var body = json.decode(response.body);
      print ('body '+body.toString());

      if (response != null && response.statusCode == 200) {

        _CoursePrices=body['CoursePrices'];

      }
      else {
        ShowMyDialog.showMsg(body['Message']);
      }
      setState(() {
        _Loading=false;
      });
    }
    catch(e){
      setState(() {
        _Loading=false;
      });
      print(' add Group  ee '+e.toString());
      ShowMyDialog.showMsg(e.toString());
    }
  }

// Future<String> getVideoDuration(String videoPath){
//   final controller = VideoPlayerController.file(File(videoPath));
//   controller.initialize().then((_) {
//     // Get the duration of the video.
//     _videoDurationController.text = controller.value.duration.inMinutes.toString() + ":" + controller.value.duration.inSeconds.toString();;
//   });
// }


}
