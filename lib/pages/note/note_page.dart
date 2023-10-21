
import 'package:eplatform/model/subject/subject.dart';
import 'package:eplatform/pages/note/teacher_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/customModel.dart';
import '../../model/mainmodel.dart';
import '../../model/note/note.dart';
import '../../session/userSession.dart';
import '../../widgets/dialogs/alertMsg.dart';
import '../../widgets/rateIndecator.dart';
import '../../widgets/text_fields/search_field.dart';
import '../components/row_title.dart';
import 'noteContent_page.dart';


class NotePage extends StatefulWidget {

   NotePage({ required this.model ,Key? key}) : super(key: key);
      MainModel model;
  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _searchController = TextEditingController();
     @override
  void initState() {
    super.initState();
       widget.model.fetchNotes(null, '');
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child:
        ScopedModelDescendant<MainModel>(
            builder:(context,child,MainModel model){
              return Stack(
          children: [
                   Container(
              width: double.infinity,
              // height: MediaQuery.of(context).size.height,
              color: AppColors.primaryColor,
               ),
                  Container(
              margin: EdgeInsets.only(top: deviceSize.height * 0.10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
              ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                      child: Column(
                        children: [
                          SizedBox(height: deviceSize.height * 0.13,),
                          Container(
                            height: 130,
                            child:model.subLoading?
                            const Center(child: CircularProgressIndicator())
                                : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: model.allSubjects.length,
                              itemBuilder: (context, index)=>
                                  subjectContainer(context,model.allSubjects[index],model),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Expanded(
                            child:
                            model.noteLoading==true ?
                            const Center(child: CircularProgressIndicator())
                                : ListView.builder(
                              itemCount: model.allNotes.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index)=> InkWell(onTap: ()=>
                                  GlobalMethods.navigate(context,
                                      //  NoteContentPage(notebookId:model.allNotes[index].TeacherId)),
                                      TeacherPage(model: model,note:model.allNotes[index])),
                                  child: noteContainer(context,model.allNotes[index])),
                            ),
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),),
            ),
                  Container(
                    margin: EdgeInsets.only(left: 20,top:deviceSize.height * 0.08,right: 20),
                    child: SearchField(hintText: 'بحث بالاسم', onChange: (val)=> model.searchNoteTeachers(val),),
            ),

                 const CustomRowTitle(title: 'المذكرات',)
          ],
        ) ; }),

      ),
    );
  }
  Widget subjectContainer(context,Subject customModel ,model) => InkWell(
    onTap: ()=>model.fetchNotes(customModel.Id, '') ,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFBBDDF8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset('assets/icons/arabic_book.png', width: 40, height: 40,),
        ),
        Text(customModel.Name, style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,)
      ],
    ),

  );

  Widget subSubjectContainer() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.primaryColor),
      // color: Colors.white
    ),
    child: const Center(child: Text('نحو')),
  );

  Widget noteContainer(context,Note note) => Container(

    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
    decoration: BoxDecoration(
      border: const Border(right: BorderSide(color: AppColors.primaryColor, width: 5)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      children: [
        Column(
          children: [
            Image.asset('assets/images/teachers.png', width: 40, height: 40,),
            const SizedBox(height: 10,),
            Text(note.FollowersCount.toString()+' متابع',
              style: Theme.of(context).textTheme.bodySmall,),
          ],
        ),
        const SizedBox(width: 6,),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(note.TeacherName, style: Theme.of(context).textTheme.titleMedium,),
            Text(note.SubjectName, style: Theme.of(context).textTheme.titleSmall,),
            RateIndicator(rate: note.Rate ,itemSize:25),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10)
          ),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
        ),

      ],
    ),
  );




}
