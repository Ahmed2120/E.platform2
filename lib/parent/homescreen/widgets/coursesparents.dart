import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/courses/course.dart';
import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/group/group.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/model/subject/subject.dart';
import 'package:eplatform/pages/components/row_title.dart';
import 'package:eplatform/pages/courses_and_groups/course_content_page.dart';
import 'package:eplatform/pages/courses_and_groups/groups_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CoursesAndGroupsparentPage extends StatefulWidget {
  CoursesAndGroupsparentPage({required this.model, Key? key}) : super(key: key);
  MainModel model;
  @override
  State<CoursesAndGroupsparentPage> createState() =>
      _CoursesAndGroupsparentPageState();
}

class _CoursesAndGroupsparentPageState
    extends State<CoursesAndGroupsparentPage> {
  final _searchController = TextEditingController();

  ContentType type = ContentType.course;
  @override
  void initState() {
    //  _getSubject();
    // widget.model.fetchCourses(widget.model.allSubjects[0].Id, '');
    //   widget.model.fetchgroups(widget.model.allSubjects[0].Id, '');
    widget.model.fetchCourses(null, null);
    widget.model.fetchgroups(null, null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(child: ScopedModelDescendant<MainModel>(
          builder: (context, child, MainModel model) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              //  height: deviceSize.height,
              color: AppColors.primaryColor,
            ),
            Container(
              margin: EdgeInsets.only(top: deviceSize.height * 0.10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //   SizedBox(height: deviceSize.height * 0.05,),
                    SizedBox(
                      height: 130,
                      child: model.subLoading == true
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: model.allSubjects.length,
                              itemBuilder: (context, index) =>
                                  subjectContainer(model.allSubjects[index]),
                            ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(10),
                    //     boxShadow: const [
                    //       BoxShadow(
                    //           color: Colors.black12,
                    //           blurRadius: 6,
                    //           spreadRadius: 3
                    //       )
                    //     ],
                    //   ),
                    //   child: TextFormField(
                    //     controller: _searchController,
                    //     decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.filter_alt_sharp, size: 25,)),
                    //       suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.search, size: 25,)),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 40,
                      child: model.subLoading == true
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: model.allBranches.length,
                              itemBuilder: (context, index) =>
                                  subSubjectContainer(model.allBranches[index]),
                            ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                            onTap: () => setState(() {
                                  type = ContentType.course;
                                }),
                            child: Text(
                              'كورسات',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: typeColor(ContentType.course)),
                            )),
                        GestureDetector(
                            onTap: () => setState(() {
                                  type = ContentType.group;
                                }),
                            child: Text(
                              'مجموعات',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: typeColor(ContentType.group)),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // ---------------------- courses ------------------
                    if (type == ContentType.course)
                      model.courseLoading == true
                          ? const Center(child: CircularProgressIndicator())
                          : Expanded(
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15.0,
                                        mainAxisSpacing: 15.0,
                                        childAspectRatio: 0.8),
                                itemCount: model.allCourses.length,
                                itemBuilder: (context, index) =>
                                    courseContainer(
                                  context,
                                  model.allCourses[index],
                                  onStart: () => GlobalMethods.navigate(
                                    context,
                                    ScopedModelDescendant<MainModel>(builder:
                                        (context, child, MainModel model) {
                                      return CourseContentPage(
                                          model: model,
                                          course: model.allCourses[index]);
                                    }),
                                  ),
                                ),
                              ),
                            )
                    // ---------------------- groups ------------------
                    else
                      model.groupLoading == true
                          ? const Center(child: CircularProgressIndicator())
                          : Expanded(
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15.0,
                                        mainAxisSpacing: 15.0,
                                        childAspectRatio: 0.8),
                                itemCount: model.allGroups.length,
                                itemBuilder: (context, index) => groupContainer(
                                  context,
                                  model.allGroups[index],
                                  onStart: () => GlobalMethods.navigate(
                                      context,
                                      GroupsPage(
                                        model: model,
                                        group: model.allGroups[index],
                                      )),
                                ),
                              ),
                            ),
                    // const SizedBox(height: 10,),
                    // type == ContentType.course ? buildElevatedButton('متجر الكورسات', (){
                    //
                    // }) : buildElevatedButton('متجر المجموعات', (){}),
                    // const SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            const CustomRowTitle(
              title: 'كورسات ومجموعات',
            ),
          ],
        );
      })),
    );
  }

  Widget subjectContainer(Subject subject) => InkWell(
        onTap: () {
          widget.model.fetchCourses(subject.Id, '');
          widget.model.fetchgroups(subject.Id, '');
          widget.model.fetchBranch(subject.Id);
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFBBDDF8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'assets/icons/arabic_book.png',
                width: 40,
                height: 40,
              ),
            ),
            Text(
              subject.Name,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            )
          ],
        ),
      );

  Widget subSubjectContainer(CustomModel customModel) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryColor),
          // color: Colors.white
        ),
        child: Center(child: Text('${customModel.Name}')),
      );

  Widget courseContainer(context, Course course, {required Function onStart}) =>
      Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(2),
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
            course.TeacherPicture == ''
                ? Image.asset(
                    'assets/images/teacher.png',
                    width: 50,
                    height: 50,
                  )
                : Image.network(
                    course.TeacherPicture.toString(),
                    width: 50,
                    height: 50,
                  ),
            Text(
              "كورسات/ " + course.TeacherName!,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Text(
              course.SubjectName,
              style: const TextStyle(color: Color(0xFF888B8E)),
            ),
            ElevatedButton(
                onPressed: () => onStart(), child: const Text('ابدأ الان'))
          ],
        ),
      );

  Widget groupContainer(context, Group group, {required Function onStart}) =>
      Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(2),
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
            Image.asset(
              'assets/images/teacher.png',
              width: 50,
              height: 50,
            ),
            Text(
              group.TeacherName,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              group.SubjectName,
              style: const TextStyle(color: Color(0xFF888B8E)),
            ),
            ElevatedButton(
                onPressed: () => onStart(), child: const Text('ابدأ الان'))
          ],
        ),
      );

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

  Color typeColor(ContentType contentType) {
    if (contentType == type) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }
}

enum ContentType { course, group }
