import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/pages/courses_and_groups/book_appointment_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../session/userSession.dart';
import '../../../widgets/custom_stack.dart';
import 'edit-notes_page.dart';

class TeacherNoteContentPage extends StatelessWidget {
  TeacherNoteContentPage({ required this.model,required this.notebookId,
    Key? key}) : super(key: key);
  MainModel model;
  int notebookId;
  @override
  Widget build(BuildContext context) {
    model.fetchCreatedTeacherNoteDetails(notebookId);
    final deviceSize = MediaQuery.of(context).size;
    return ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
                body: CustomStack(
                  pageTitle: 'المذكرات',
                  child:
                  model.teacherCreatedNoteDetailsLoading?const Center(child: CircularProgressIndicator()):
                  ListView(
                    children: [
                      Text(model.teacherCreatedNoteDetailsBody['Title']==null?'اسم المذكرة' :
                            model.teacherCreatedNoteDetailsBody['Title'],
                        style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center,),

                      Text(model.teacherCreatedNoteDetailsBody['Description']==null?'الوصف' :
                         model.teacherCreatedNoteDetailsBody['Description']
                        ,
                        style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,),
                      const SizedBox(height: 12,),

                      if(model.teacherCreatedNoteDetailsImgs.isNotEmpty)
                        CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 240,
                          aspectRatio: 16/9,
                          initialPage: 0,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemCount: model.teacherCreatedNoteDetailsImgs.length,
                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex)=>
                            Container(
                                width: double.infinity,
                                child: Image.network(
                                    model
                                        .teacherCreatedNoteDetailsImgs[
                                            itemIndex]
                                        .Image,
                                    fit: BoxFit.fill),
                              )
                            ),
                      const SizedBox(height: 12,),
                      Text('السعر', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                       ListView.separated(
                         physics: NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                         itemCount: model.teacherCreatedNoteDetailsPrices.length,
                         separatorBuilder: (context, index)=> const SizedBox(height: 10,),
                         itemBuilder: (context, index)=> Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(model.teacherCreatedNoteDetailsPrices[index].CurrencyName, style: Theme.of(context).textTheme.bodySmall,),
                             Text(model.teacherCreatedNoteDetailsPrices[index].Price.toString()),
                           ],
                         ),
                       ),

                      const SizedBox(height: 20,),
                      if(UserSession.hasPrivilege(17)) CustomElevatedButton(title: 'تعديل',
                          function: ()=> GlobalMethods.navigate(context,
                              EditNotePage(model: model,notebookId: notebookId,))),
                      const SizedBox(height: 12,),
                    ],
                  ),
                ),
              );
      }
    );


  }


}

