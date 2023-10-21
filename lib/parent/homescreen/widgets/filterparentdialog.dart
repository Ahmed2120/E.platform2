import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';

class FilterParentDialog extends StatelessWidget {
  FilterParentDialog({Key? key}) : super(key: key);

  List<Subject> subjects = [
    Subject(1, 'لغة عربية', isActive: true),
    Subject(2, 'لغة انجليزية'),
    Subject(3, 'رياضيات'),
    Subject(4, 'علوم'),
    Subject(5, 'لغة فرنسية'),
    Subject(6, 'دراسات اجتماعية'),
  ];

  List<SubSubject> subSubjects = [
    SubSubject(1, 'نحو', 1, isActive: true),
    SubSubject(2, 'بلاغة', 1),
    SubSubject(3, 'ادب', 1),
    SubSubject(4, 'تعبير', 1),
    SubSubject(5, 'قراءة', 1),
    SubSubject(6, 'نصوص', 1),
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.close,
                size: 40,
                color: Colors.black,
              )),
          Text(
            'المواد الدراسية',
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              ...subjects.map((subject) => InkWell(
                  onTap: () => chooseSubject(subject),
                  child: subjectContainer(context, subject)))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'فروع المادة',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  ...subSubjects.map((subject) => InkWell(
                      onTap: () {}, child: subjectContainer(context, subject)))
                ],
              ),
            ],
          )
        ],
      ),
      contentPadding: const EdgeInsets.all(10),
      titlePadding: const EdgeInsets.all(10),
    );
  }

  Container subjectContainer(BuildContext context, subject) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: subject.isActive ? AppColors.primaryColor : null,
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        subject.name,
        style: TextStyle(
            color: subject.isActive ? Colors.white : AppColors.primaryColor),
      ),
    );
  }

  void chooseSubject(Subject subject) {
    for (int i = 0; i < subjects.length; i++) {
      if (subjects[i] == subject) {
        subjects[i].isActive = true;
      } else {
        subjects[i].isActive = false;
      }
    }

    for (int i = 0; i < subjects.length; i++) {
      print('${subjects[i].name} : ${subjects[i].isActive}');
    }
  }
}

class Subject {
  final int id;
  final String name;
  bool isActive;

  Subject(this.id, this.name, {this.isActive = false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Subject && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
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
