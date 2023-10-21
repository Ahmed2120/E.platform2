import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/api.dart';
import '../../../core/utility/app_colors.dart';
import '../../../core/utility/global_methods.dart';
import '../../../pages/components/custom_dotted_border.dart';
import '../../../pages/components/custom_elevated_button.dart';
import '../../../widgets/custom_stack.dart';
import '../../../widgets/date_widget.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import 'package:path/path.dart';

import '../create_group/components/create_group_field.dart';

class EditGroupClassPage extends StatefulWidget {
  const EditGroupClassPage({super.key, required this.groupVideoId});

  final int groupVideoId;

  @override
  State<EditGroupClassPage> createState() => _EditGroupClassPageState();
}

class _EditGroupClassPageState extends State<EditGroupClassPage> {

  final _classNameController = TextEditingController();
  final _classDescriptionController = TextEditingController();

  DateTime _classAt = DateTime.now();

  File? _classVideo;
  String? classFromTime;
  String? classToTime;

  List attachments = [null];

  bool _dataLoading=false;
  bool _class_Loading=false;
  bool _Loading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getClassData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomStack(
          pageTitle: 'انشاء حصة',
          child: ListView(
            shrinkWrap: true,
            children: [
              Text('عنوان الحصة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
              CreateGroupField(controller: _classNameController, hintText: 'عنوان الحصة', input: TextInputType.text,),

              const SizedBox(height: 8,),
              Text('وصف الحصة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
              CreateGroupField(controller: _classDescriptionController, hintText: 'وصف الحصة', input: TextInputType.text,),

              const SizedBox(height: 8,),
              DateWidget( title: ' تاريخ البدء ${GlobalMethods().dateFormat(_classAt)}',onSelectDate: (){
                showDatePicker(
                    context: context,
                    initialDate: _classAt,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime
                        .now()
                        .year + 1)).then((value) {
                  setState(() { if(value != null) _classAt = value;}
                  );
                });
              }),

              const SizedBox(width: 8,),
              Row(
                children: [
                  Text('من', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  const SizedBox(width: 5,),
                  InkWell(
                    onTap: ()async{
                      final time = await selectTime(context);
                      if(time != null) {
                        classFromTime = GlobalMethods().formatTimeFromTime(time);
                      }
                      setState(() {});

                    },
                    child: buildChip(context, classFromTime??'  '),
                  ),
                  const SizedBox(width: 5,),
                  Text('الى', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                  const SizedBox(width: 8,),
                  InkWell(
                    onTap: ()async{
                      final time = await selectTime(context);
                      if(time != null) {
                        classToTime = GlobalMethods().formatTimeFromTime(time);
                      }
                      setState(() {});
                    },
                    child: buildChip(context, classToTime??'  '),
                  ),

                ],
              ),

              const SizedBox(height: 8,),
              Text('رفع فيديو', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
              InkWell(
                onTap: () async{
                  final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
                  if(picked == null) return;
                  _classVideo = File(picked.path);
                  setState(() {});
                },
                child: CustomDottedBorder(
                  child: Column(
                    children: [
                      Image.asset('assets/images/promo.png'),
                      Text(_classVideo != null ? basename(_classVideo!.path) : 'رفع فيديو', style: const TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
              ),
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
                                  Text(attachments[index] != null ? basename(attachments[index].path) : 'رفع ملف', style: const TextStyle(fontSize: 14),),
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
              _class_Loading?const Center(child: CircularProgressIndicator()):
              CustomElevatedButton(title: 'ارسال',
                  function:_addGroupClass
              )
            ],
          )
      ),
    );
  }

  Future<TimeOfDay?> selectTime(context) async{
    final newTime = await showTimePicker(context: context,
        initialTime: TimeOfDay(hour: DateTime.now().hour,
            minute: DateTime.now().minute));

    return newTime;

  }

  Chip buildChip(context, String title) {
    return Chip(
      // padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(side: BorderSide(color: AppColors.borderColor)),
      backgroundColor: Colors.white,
      label: Text(title, style: Theme.of(context).textTheme.bodySmall),
    );
  }

  Future<File?> pickVideo() async {
    final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      return File(picked.path);
    }
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

  void _addGroupClass()  async{
    setState(() {
      _class_Loading=true;
    });


    List<Map<String, dynamic>> AttachmentUrl  =[];
    for(int i=0;i<attachments.length;i++){
      AttachmentUrl.add( {'AttachmentUrl':attachments[i]});
    }

    Map<String, String> data={
      "Id": widget.groupVideoId.toString(),
      "Title": _classNameController.text,
      "Description": _classDescriptionController.text,
      "Duration": 4.toString(),
      "ClassAt": _classAt.toString(),
      "FromTime": classFromTime.toString(),
      "ToTime": classToTime.toString(),
      "Attachments": '[]',
    };
    //  print(' class data   '+data.toString());

    List<Map> filess= [
      {'title': 'VideoUrl', 'file': _classVideo},
      // {'title': 'Attachments', 'file': attachments[0]},
    ];
    try {
      var response = await CallApi().postJsonAndFile(data, filess,
          "/api/GroupVideo/UpdateGroupVideo", 1);


      if (response != null && response.statusCode == 200) {

        ShowMyDialog.showMsg("تم تعديل الحصة بنجاح");

      }
      else {
        ShowMyDialog.showMsg(response.reasonPhrase);
      }
      setState(() {
        _class_Loading=false;
      });
    }
    catch(e){
      setState(() {
        _class_Loading=false;
      });
      print(' add Group  ee '+e.toString());
    }
  }

  void  _getClassData()  async{

    setState(() {
      _Loading=true;
    });

    Map <String,dynamic>data={
      'groupVideoId':widget.groupVideoId.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,"/api/GroupVideo/GetGroupVideoById",1);
      var body = json.decode(response.body);
      print ('body '+body.toString());

      if (response != null && response.statusCode == 200) {

        _classNameController.text = body['Title'];
        _classDescriptionController.text = body['Description'];
        _classAt = DateTime.parse(body['ClassAt']);
        classFromTime = body['FromTime'];
        classToTime = body['ToTime'];


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
    }
  }
}
