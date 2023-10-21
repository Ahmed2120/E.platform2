import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/subject/subject.dart';
import 'package:eplatform/pages/private_groups/teacher_groups_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/mainmodel.dart';
import '../../model/privateGroup/PrivateGroup.dart';
import '../components/row_title.dart';
import 'book_private_group.dart';


class PrivateGroupsPage extends StatefulWidget {
  PrivateGroupsPage({required this.model,Key? key}) : super(key: key);
  MainModel model;

  @override
  State<PrivateGroupsPage> createState() => _PrivateGroupsPageState();
}

class _PrivateGroupsPageState extends State<PrivateGroupsPage> {

  final _searchController = TextEditingController();
  ContentType type = ContentType.group;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.fetchPrivateGroup(null, null);
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
          builder:(context,child,MainModel model){
            return SafeArea(
                child: Stack(
                 children: [
                      Container(
                 width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                   color: AppColors.primaryColor,
            ),
                      Container(
                       margin: EdgeInsets.only(top: deviceSize.height * 0.12),
                        width: double.infinity,
                 height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
              ),
                        child:   Padding(
                          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: model.privateGroupLoading==true?
                              const Center(
                                   child: CircularProgressIndicator())
                         : Column(
                            children: [
                              SizedBox(height:  deviceSize.height * 0.05),
                              if(type == ContentType.group) Container(
                                height: 130,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: model.allSubjects.length,
                                  itemBuilder: (context, index)=>
                                      InkWell(
                                        onTap: (){
                                          model.fetchBranch(model.allSubjects[index].Id);
                                          model.fetchPrivateGroup(model.allSubjects[index].Id,null); },
                                          child: subjectContainer(context,model.allSubjects[index])),
                                ),
                              ),
                              const SizedBox(height: 8,),
                              if(type == ContentType.group) SizedBox(
                                height: 40,
                                child:
                               model.branchLoading ?const Center(child: CircularProgressIndicator())
                                   :ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: model.allBranches.length,
                                  itemBuilder: (context, index)=>
                                      InkWell(
                                          child: subSubjectContainer(model.allBranches[index])
                                      ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(onTap: () =>
                                      setState(() {
                                        type = ContentType.group;
                                      }),child: Text('مجموعات',
                                      style: TextStyle(fontSize: 17, color: typeColor(ContentType.group)),),
                                  ),
                                  GestureDetector(onTap: () =>
                                      setState(() {
                                        type = ContentType.book;
                                      }),child: Text('احجز موعد', style:
                                     TextStyle(fontSize: 17, color: typeColor(ContentType.book)),),
                                  ),
                                ],
                              ),

                              // ------------------- groups -----------------
                              if(type == ContentType.group) Expanded(
                                child: ListView.builder(
                                  itemCount: model.PrivateGroupList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index)=> InkWell(onTap: () async{

                                    await model.FetchTeachersPrivateGroup(model.PrivateGroupList[index].TeacherId);
                                    GlobalMethods.navigate(context, TeacherGroupsPage(model: model,));
                                  },
                                      child: groupContainer(context,model.PrivateGroupList[index])),
                                ),
                              ),

                              // ------------------- book -----------------
                              if(type == ContentType.book) Expanded(
                                child: BookPrivateGroupPage(model: model,),
                              ),
                              const SizedBox(height: 10,),
                            ],
                          ),),
            ),

                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       margin: EdgeInsets.only(top:deviceSize.height * 0.09),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(10),
                         boxShadow: const [
                           BoxShadow(
                               color: Colors.black12,
                               blurRadius: 6,
                               spreadRadius: 3
                           )
                         ],
                       ),
                       child: TextFormField(
                         controller: _searchController,
                         decoration: InputDecoration(
                           border: InputBorder.none,
                           prefixIcon: IconButton(onPressed: (){
                             widget.model.fetchPrivateGroup(null, _searchController.text);
                           },
                               icon: const Icon(Icons.search, size: 25,)),
                           suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.filter_alt_sharp, size: 25,)),
                         ),
                       ),
                     ),
                   ),
                   const CustomRowTitle(title: 'برايفت',),
          ],
        ),
      ) ;})
    );
  }

  Widget subjectContainer(context,Subject subject) =>
      Column(
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
      Text(subject.Name, style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,)
    ],
  );

  Widget subSubjectContainer(CustomModel subject) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.primaryColor),
      // color: Colors.white
    ),
    child: Center(child: Text(subject.Name)),
  );

  Widget groupContainer(context,PrivateGroup privateGroup) => Container(
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
            Text(' متابع '+privateGroup.StudentsCount.toString(), style: Theme.of(context).textTheme.bodySmall,),
          ],
        ),
        const SizedBox(width: 6,),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('مجموعات أ/ '+privateGroup.TeacherName, style: Theme.of(context).textTheme.titleMedium,),
            Text(privateGroup.Title,
              style: Theme.of(context).textTheme.titleSmall,),
            Row(
              children: const [
                Icon(Icons.star, color: Colors.yellow,),
                Icon(Icons.star, color: Colors.yellow,),
                Icon(Icons.star, color: Colors.yellow,),
              ],
            )
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

  Color typeColor(ContentType contentType){
    if(contentType == type) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }
}


enum ContentType{
  book,
  group
}