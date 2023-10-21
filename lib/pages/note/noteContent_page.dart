import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/courses_and_groups/book_appointment_page.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../imgCustomModel.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'book_note_page.dart';


class NoteContentPage extends StatelessWidget {
   NoteContentPage({required this.notebookId,required this.model,Key? key}) : super(key: key);
  int notebookId;
  MainModel model;

  @override
  Widget build(BuildContext context) {
      model.fetchNoteDetDetails(notebookId);
      final deviceSize = MediaQuery.of(context).size;
    return   ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
      body: CustomStack(
        pageTitle: 'المذكرات',
        child: model.NoteDetailsLoading==true?
        Center(child: CircularProgressIndicator())
            :  Column(
          children: [
              CircleAvatar(radius: 30, child: Image.asset('assets/images/teacher.png')),
             Text(model.NoteDetailsTitle,
              style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),

            Text(model.NoteDetailsDescription!,
              style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,),
            const SizedBox(height: 12,),
            model.NoteImgDetails.length>0?
               CarouselSlider.builder(
              options: CarouselOptions(
                height: 240,
                aspectRatio: 16/9,
                initialPage: 0,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
                 itemCount: model.NoteImgDetails.length,
                 itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
                    width: double.infinity,
                    child:
                    Image.network(model.NoteImgDetails[itemIndex].Image,
                      fit: BoxFit.fill),
                  ),
            )
                :Container(),
            const SizedBox(height: 12,),
            Text('السعر', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
            Text(GlobalMethods.showPrice(model.NoteDetailsPrice), textAlign: TextAlign.center,),
            Spacer(),
            buildElevatedButton('احجز نسختك الان', ()=>GlobalMethods.navigate(context,
                BookNotePage(NotebookId:notebookId , NotebookName: model.NoteDetailsTitle,))),
            const SizedBox(height: 12,),
          ],
        ),
      ),
    ); });
  }




  ElevatedButton buildElevatedButton(String title, Function function) {
    return ElevatedButton(
      onPressed: () => function(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(40, 40),
      ),
      child: Text(title),
    );
  }



}

