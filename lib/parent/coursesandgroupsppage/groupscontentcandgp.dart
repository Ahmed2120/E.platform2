import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/components/row_title.dart';
import 'package:eplatform/pages/teachers/teacher_courses_page.dart';
import 'package:eplatform/widgets/description_container.dart';
import 'package:eplatform/widgets/rateIndecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:scoped_model/scoped_model.dart';

class ChildernGroupsContentForGandCPPage extends StatelessWidget {
  //assets/images/video-marketing (1) 6.png
  ChildernGroupsContentForGandCPPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
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
                    padding:
                        const EdgeInsets.only(top: 30, left: 15, right: 15),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: Image.asset('assets/images/teachers.png'),
                        ),
                        Text(
                          'مجموعه أ:أحمد خالد ',
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
                                title: ' مجموعات  ',
                                img: 'assets/icons/level-description.png'),
                            DescriptionContainer(
                                title: ' الصف الثالث الثانوي ',
                                img: 'assets/icons/level-description.png'),
                            DescriptionContainer(
                                title: '   لغه عربيه ',
                                img: 'assets/icons/level-description.png'),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                groupssubscriptioncontentitem(
                              context,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const CustomRowTitle(
                  title: ' مجموعه أ',
                ),
              ],
            ),
          ],
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

Widget groupssubscriptioncontentitem(context) => Container(
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
            'assets/images/notification.png',
            width: 40,
            height: 40,
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
                ' مجموعه أ ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(' 12/9 طالب  ', style: TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Column(
            children: [Text('\$5'), Text('12 حصه')],
          )
        ],
      ),
    );

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
