import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/pages/components/row_title.dart';
import 'package:eplatform/widgets/description_container.dart';

import 'package:flutter/material.dart';

class CoursesContentForCoursGrouPage extends StatefulWidget {
  //assets/images/video-marketing (1) 6.png
  CoursesContentForCoursGrouPage({Key? key}) : super(key: key);

  @override
  State<CoursesContentForCoursGrouPage> createState() =>
      _CoursesContentForCoursGrouPageState();
}

class _CoursesContentForCoursGrouPageState
    extends State<CoursesContentForCoursGrouPage> {
  int selectedItemIndex = -1;
  void updateSelectedItem(int index) {
    setState(() {
      selectedItemIndex = index;
    });
  }

  int _currentStep = 0;
  final List<Step> _steps = [
    Step(
      title: const Text('الدرس الأول'),
      content: Row(
        children: [
          const Text('مجانا '),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.slow_motion_video,
                  color: AppColors.primaryColor))
        ],
      ),
      isActive: true,
    ),
    Step(
      title: const Text('الدرس الثاني '),
      content: Row(
        children: [
          const Text('مجانا '),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.slow_motion_video,
                  color: AppColors.primaryColor)),
        ],
      ),
      isActive: true,
    ),
    Step(
      title: const Text('الدرس الثالث'),
      content: Row(
        children: [
          const Text('10\$'),
          IconButton(
              onPressed: () {}, icon: Image.asset('assets/images/kfl.png'))
        ],
      ),
      isActive: true,
    ),
    Step(
      title: const Text('الدرس الرابع'),
      content: Row(
        children: [
          const Text('10\$'),
          IconButton(
              onPressed: () {}, icon: Image.asset('assets/images/kfl.png'))
        ],
      ),
      isActive: true,
    ),

    // قم بإضافة المزيد من الخطوات حسب الحاجة
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    print('sssssssssssssss$selectedItemIndex');

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: AppColors.primaryColor,
              ),
              Container(
                margin: EdgeInsets.only(top: deviceSize.height * 0.08),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: Image.asset('assets/images/teachers.png'),
                      ),
                      Text(
                        'أ:أحمد خالد ',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        runAlignment: WrapAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          DescriptionContainer(
                              title: ' كورسات الابناء',
                              img: 'assets/icons/level-description.png'),
                          DescriptionContainer(
                              title: 'الصف الثالث الثانوي',
                              img: 'assets/icons/book-description.png'),
                          DescriptionContainer(
                              title: 'لغه عربيه  ',
                              img: 'assets/icons/level-description.png'),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.all(12),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                updateSelectedItem(index);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: selectedItemIndex == index
                                          ? Colors.red
                                          : AppColors.primaryColor),
                                  color: selectedItemIndex == index
                                      ? AppColors.primaryColor
                                      : Colors.white,
                                  // color: Colors.white
                                ),
                                child: InkWell(
                                    onTap: () {
                                      updateSelectedItem(index);
                                    },
                                    child: Center(
                                        child: Text(
                                      'نصوص ',
                                      style: TextStyle(
                                          color: selectedItemIndex == index
                                              ? Colors.white
                                              : AppColors.primaryColor),
                                    ))),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      selectedItemIndex == -1
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: 5,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      GlobalMethods.navigate(context,
                                          CoursesContentForCoursGrouPage());
                                    },
                                    child: coursessubscriptionscontent(
                                      context,
                                    )),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'ادب الوحده الاولي ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Stepper(
                                  currentStep: _currentStep,
                                  onStepContinue: () {
                                    setState(() {
                                      if (_currentStep < _steps.length - 1) {
                                        _currentStep++;
                                      }
                                    });
                                  },
                                  onStepCancel: () {
                                    setState(() {
                                      if (_currentStep > 0) {
                                        _currentStep--;
                                      }
                                    });
                                  },
                                  steps: _steps,
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              const CustomRowTitle(
                title: 'كورسات ومجموعات ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container contentContainer(
  context, {
  required String img,
  required String title,
  required String subtitle,
}) {
  return Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
    decoration: BoxDecoration(
      border: const Border(
          right: BorderSide(color: AppColors.primaryColor, width: 5)),
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
        Image.asset(
          img,
          width: 40,
          height: 40,
        ),
        const SizedBox(
          width: 6,
        ),
        Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        const Spacer(),
        Container(
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

Container buildContainer(
  context,
  w, {
  required String img,
  required String title,
  required String subtitle,
}) {
  return Container(
    padding: const EdgeInsets.only(top: 15, bottom: 15, left: 3, right: 3),
    width: w * (0.45),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
    decoration: BoxDecoration(
      border: const Border(
          right: BorderSide(color: AppColors.primaryColor, width: 5)),
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
        Image.asset(
          img,
          width: 40,
          height: 40,
          fit: BoxFit.fill,
        ),
        const SizedBox(
          width: 3,
        ),
        Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget descriptionContainer(String title, String img) {
  return UnconstrainedBox(
    child: Container(
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
    ),
  );
}

Widget buildStep(context,
    {String time = '', String title = '', required int stepNum}) {
  return Row(
    children: [
      Chip(
        shape: const CircleBorder(),
        label: Text('$stepNum'),
        backgroundColor: AppColors.primaryColor,
        labelStyle: const TextStyle(color: Colors.white),
      ),
      Expanded(
        child: Container(
          // width: double.infinity,
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF3DB2FF).withOpacity(0.18),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Text(
                time,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget subSubjectContainer() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryColor),
        // color: Colors.white
      ),
      child: const Center(child: Text('نصوص ')),
    );

Widget coursessubscriptionscontent(context) => Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
    decoration: BoxDecoration(
      border: const Border(
          right: BorderSide(color: AppColors.primaryColor, width: 5)),
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
        Image.asset(
          'assets/images/video-marketing (1) 6.png',
          width: 50,
          height: 50,
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          width: 6,
        ),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              ' ادب ',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '  دقيقه 50  ',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            const Text('30\$'),
            const SizedBox(
              width: 8,
            ),
            Image.asset('assets/images/kfl.png')
          ],
        )
      ],
    ));
Widget coursesUndererSteper(context) => Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
    decoration: BoxDecoration(
      border: const Border(
          right: BorderSide(color: AppColors.primaryColor, width: 5)),
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
        Image.asset(
          'assets/images/video-marketing (1) 6.png',
          width: 50,
          height: 50,
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          width: 6,
        ),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              ' ادب الوحده الثانيه  ',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '   4 دروس  ',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            const Text('30\$'),
            const SizedBox(
              width: 8,
            ),
            Image.asset('assets/images/kfl.png')
          ],
        )
      ],
    ));

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
