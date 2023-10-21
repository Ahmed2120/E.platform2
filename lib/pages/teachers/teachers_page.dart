import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/subject/subject.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/mainmodel.dart';
import '../../model/teacher/teacher.dart';
import '../../widgets/rateIndecator.dart';
import '../../widgets/text_fields/search_field.dart';
import '../components/row_title.dart';
import 'teacher_content.dart';

class TeachersPage extends StatefulWidget {
  TeachersPage({required this.model,Key? key}) : super(key: key);
  MainModel model;
  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.fetchAllTeachers(null,null);
  }
  @override
  Widget build(BuildContext context) {

    final deviceSize = MediaQuery.of(context).size;
    return ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
            body: SafeArea(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
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
                    padding:  EdgeInsets.only(top:deviceSize.height * 0.04, left: 15, right: 15),
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: model.allSubjects.length,
                            itemBuilder: (context, index)=>
                                InkWell(
                                  onTap: (){
                                   print('mmm');
                                    model.fetchAllTeachers(model.allSubjects[index].Id,null);
                                    setState(() {
                                    });

                                  },
                                    child: subjectContainer(context,model.allSubjects[index])),
                          ),
                        ),
                        Container(
                          height: 60,
                          padding: const EdgeInsets.all(12),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: model.allBranches.length,
                            itemBuilder: (context, index)=> subSubjectContainer(model.allBranches[index]),
                          ),
                        ),
                        const SizedBox(height: 10,),

                        Expanded(
                          child:
                          model.allTecherLoading?
                          const Center(child: CircularProgressIndicator()):
                          model.allTeachers.length>0?   
                          ListView.builder(
                            itemCount: model.allTeachers.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index)=> InkWell(
                                onTap: ()=>
                                GlobalMethods.navigate(context,
                                    TeacherContentPage(model:model,teacher:model.allTeachers[index])),
                                child: teacherContainer(context,model.allTeachers[index])
                            ),
                          ):
                          Image.asset('assets/images/no_data.png'),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20,top:deviceSize.height * 0.08,right: 20),
                  child: SearchField(hintText: 'بحث باسم المدرس', onChange: (val)=> model.searchTeachers(val),),
                ),
                const CustomRowTitle(title: 'المدرسين',),

              ],
            ),
          ),
        );
      }
    );
  }

  Widget subjectContainer(context,Subject subject) => Column(
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

  Widget subSubjectContainer(CustomModel branch) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.primaryColor),
      // color: Colors.white
    ),
    child:  Center(child: Text(branch.Name)),
  );

  Widget teacherContainer(context,Teachers teachers) => Container(
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
            teachers.ProfileImage==''?
            Image.asset('assets/images/teachers.png', width: 40, height: 40,):
            Image.network(teachers.ProfileImage, width: 40, height: 40,),
            const SizedBox(height: 10,),
            Text(teachers.FollowersCount.toString()+' متابع',
              style: Theme.of(context).textTheme.bodySmall,),
          ],
        ),
        const SizedBox(width: 6,),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(teachers.Name, style: Theme.of(context).textTheme.titleMedium,),
            Text(teachers.Subjects, style: Theme.of(context).textTheme.titleSmall,),
            RateIndicator(rate: teachers.Rate,itemSize:25)
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


