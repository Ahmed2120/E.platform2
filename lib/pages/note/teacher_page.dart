import 'package:eplatform/widgets/custom_stack.dart';

import '/model/mainmodel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/note/note.dart';
import '../../model/note/teacherNote.dart';
import 'noteContent_page.dart';

class TeacherPage extends StatelessWidget {
  TeacherPage({Key? key , required this.model, required this.note}) : super(key: key);
  MainModel model;
  Note note;
  @override
  Widget build(BuildContext context) {
    model.fetchTeacherNotes(note.SubjectId, note.TeacherId);
     final deviceSize = MediaQuery.of(context).size;
    return  ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
             body: CustomStack(
               pageTitle: 'المذكرات',
               child: Column(
                children: [
                SizedBox(height: deviceSize.height * 0.09,),
                CircleAvatar(radius: 30, child: Image.asset('assets/images/teacher.png')),
                Text(note.TeacherName, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                const SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    descriptionContainer(note.SubjectName, 'assets/icons/book-description.png'),
                    descriptionContainer(
                       !model.teacherNoteLoading? model.allTeacherNotes[0].GradeName:'',
                        'assets/icons/level-description.png'),
                    descriptionContainer('مذكرات', 'assets/icons/course-description.png'),
                  ],
                ),
                const SizedBox(height: 12,),
                Expanded(
                  child: !model.teacherNoteLoading?
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.allTeacherNotes.length,
                    itemBuilder: (context, index)=> InkWell(onTap: (){
                      GlobalMethods.navigate(context,
                          NoteContentPage(notebookId:model.allTeacherNotes[index].NotebookId,
                           model: model,));
                    },
                        child: noteContainer(context , model.allTeacherNotes[index])),
                  ): Center(child: CircularProgressIndicator()),
                ),
                const SizedBox(height: 12,),
               ],
            ),
             ),
    ); });
  }

  Container noteContainer(context , TeacherNotebooks teacherNotebooks) {
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
          Image.asset('assets/icons/diary.png', width: 40, height: 40,),
          const SizedBox(width: 6,),
           Text(teacherNotebooks.Title, style: TextStyle(fontSize: 14, color: Colors.black),),
          const Spacer(),
           Text(GlobalMethods.showPrice(teacherNotebooks.Price.toString())),
        ],
      ),
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

  Widget subSubjectContainer() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.primaryColor),
      // color: Colors.white
    ),
    child: const Center(child: Text('نحو', style: TextStyle(fontSize: 12),)),
  );

  Widget courseContainer(context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/teacher.png', width: 50, height: 50,),
        const Text('كورس أ/ عاطف محمود', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
        const Text('لغة عربية ', style: TextStyle(color: Color(0xFF888B8E)),),
        ElevatedButton(onPressed: (){}, child: const Text('اشترك الان'))
      ],
    ),
  );

}

class SubSubject{
  final int id;
  final int subjectId;
  final String name;
  bool isActive;

  SubSubject(this.id, this.name, this.subjectId, {this.isActive = false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SubSubject && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

}