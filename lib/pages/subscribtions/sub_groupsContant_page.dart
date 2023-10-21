import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/pages/courses_and_groups/book_appointment_page.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/group/groupVideo.dart';
import '../../model/mainmodel.dart';
import 'sub_videos_page.dart';

class SubGroupsContentPage extends StatelessWidget {
  SubGroupsContentPage(this.model,
      {required this.teacherName,
      required this.subName,
      required this.gradeName,
      required this.groupName,
      required this.groupId,
      Key? key})
      : super(key: key);

  final _searchController = TextEditingController();

  String teacherName;
  String groupName;
  int groupId;
  String subName;
  String gradeName;
  MainModel model;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    model.fetchGroupVideoClasses(groupId);

    return Scaffold(
      body: CustomStack(
        pageTitle: groupName,
        child: ScopedModelDescendant<MainModel>(
            builder: (context, child, MainModel model) {
          return Column(
            children: [
              CircleAvatar(
                  radius: 30, child: Image.asset('assets/images/teacher.png')),
              Text(
                teacherName,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  descriptionContainer(
                      subName, 'assets/icons/book-description.png'),
                  descriptionContainer(
                      gradeName, 'assets/icons/level-description.png'),
                  descriptionContainer(
                      'مجموعات', 'assets/icons/course-description.png'),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'حصص مسجلة',
              ),
              Expanded(
                child: model.oldOrNewClassesloading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.allOldClasses.length,
                        itemBuilder: (context, index) => InkWell(
                            onTap: () => GlobalMethods.navigate(
                                context, const SubVideosPage()),
                            child: classContainer(context, index,
                                isRecorded: true,
                                groupVideo: model.allOldClasses[index])),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('حصص قادمة'),
              Expanded(
                child: model.oldOrNewClassesloading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.allNewClasses.length,
                        itemBuilder: (context, index) => InkWell(
                            onTap: () {},
                            child: classContainer(context, index,
                                groupVideo: model.allNewClasses[index])),
                      ),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomElevatedButton(title: 'تمديد الاشتراك', function: () {})
            ],
          );
        }),
      ),
    );
  }

  Container classContainer(context, int index,
      {bool isRecorded = false, required GroupVideo groupVideo}) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(offset: Offset(0, 2), blurRadius: 5, color: Colors.grey)
          ]),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الحصة ${index + 1}',
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              Text(
                groupVideo.Title,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text(GlobalMethods()
                  .scheduleDateFormat(DateTime.parse(groupVideo.ClassAt))),
              Text(' ${groupVideo.FromTime} : ${groupVideo.ToTime}'),
            ],
          ),
          const SizedBox(
            width: 6,
          ),
          isRecorded
              ? const Icon(
                  Icons.play_circle,
                  color: AppColors.primaryColor,
                )
              : Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
        ],
      ),
    );
  }

  Container descriptionContainer(String title, String img) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 10, color: AppColors.descriptionColor),
          ),
          const SizedBox(
            width: 5,
          ),
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
        child: const Center(
            child: Text(
          'نحو',
          style: TextStyle(fontSize: 12),
        )),
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
            Image.asset(
              'assets/images/teacher.png',
              width: 50,
              height: 50,
            ),
            const Text(
              'كورس أ/ عاطف محمود',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Text(
              'لغة عربية ',
              style: TextStyle(color: Color(0xFF888B8E)),
            ),
            ElevatedButton(onPressed: () {}, child: const Text('اشترك الان'))
          ],
        ),
      );

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
}

class SubSubject {
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
