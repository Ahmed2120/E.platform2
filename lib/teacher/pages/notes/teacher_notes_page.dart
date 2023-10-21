import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../../core/utility/app_colors.dart';
import '../../../core/utility/global_methods.dart';
import '../../../pages/components/custom_elevated_button.dart';
import '../../../session/userSession.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/dialogs/delete_dialog.dart';
import 'add_notes_page.dart';
import 'teacher_note_content_page.dart';

class TeacherNotesPage extends StatelessWidget {
  const TeacherNotesPage({required this.model,Key? key}) : super(key: key);
   final MainModel model;

  @override
  Widget build(BuildContext context) {
    model.fetchCreatedTeacherNotes(null);
    final deviceSize = MediaQuery.of(context).size;

    return ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
           body: CustomStack(
            pageTitle: 'المذكرات',
            child:
                 Column(
                   children: [
                   Expanded(
                    child: model.teacherCreatedNoteLoading?
                    Center(child: CircularProgressIndicator()):
                     model.allTeacherCreatedNotes.length >0 ?
                     ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.allTeacherCreatedNotes.length,
                    itemBuilder: (context, index)=>
                        Dismissible(
                          key: Key(index.toString()),
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            color: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            margin: const EdgeInsets.only(left: 16),
                            alignment: Alignment.centerRight,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            if(direction == DismissDirection.startToEnd) {
                              if(!UserSession.hasPrivilege(18)) {
                                ShowMyDialog.showMsg(
                                    'You do not have the authority');
                                return false;
                              }
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => DeleteDialog(
                                      title: 'هل تريد الحذف ؟',
                                      onConfirm: () {},
                                      loading: false)).then((value) {
                                if(value !=null && value) {
                                  // TODO : REMOVE ITEM
                                  return true;
                                }});}

                          },
                          child: InkWell(
                            onTap: ()=> GlobalMethods.navigate(context,
                                TeacherNoteContentPage(model:model,
                                  notebookId:model.allTeacherCreatedNotes[index].NotebookId ,)),
                              child: noteContainer(context,
                                name: model.allTeacherCreatedNotes[index].Title,
                                subject: model.allTeacherCreatedNotes[index].SubjectName,
                                price: model.allTeacherCreatedNotes[index].Price.toString()
                                ,)),
                        ),

                 ): Image.asset('assets/images/no_data.png')
                   ),
                     const SizedBox(height: 15,),
                     if(UserSession.hasPrivilege(16)) CustomElevatedButton(title: 'اضافة مذكرة', function: ()=>GlobalMethods.navigate(context,
                          AddNotePage())),
                      const SizedBox(height: 10,),


              ],
            )
             ,
          ),
        );
      }
    );
  }
  Container noteContainer(context, {
    required String name,
    required String subject,
    required String price,
  }) {
    return Container(
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
          Image.asset('assets/icons/diary.png', width: 70,),
          const SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: Theme.of(context).textTheme.headlineLarge,),
              const SizedBox(height: 5,),
              Text(subject, style: Theme.of(context).textTheme.titleMedium,),
            ],
          ),
          // const Spacer(),
          // Text(price,),
        ],
      ),
    );
  }

}