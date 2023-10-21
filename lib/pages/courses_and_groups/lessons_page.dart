import 'package:flutter/material.dart';

import '../../core/utility/app_colors.dart';

class LessonsPage extends StatelessWidget {
  LessonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: AppColors.primaryColor,
          ),
          Container(
            margin: EdgeInsets.only(top: deviceSize.height * 0.15),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 32.0),
                    const Text('كورسات ومجموعات', style: TextStyle(fontSize: 20, color: Colors.white, height: 1.5, fontWeight: FontWeight.bold)),

                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: const Icon(Icons.arrow_forward_ios_sharp, color: AppColors.primaryColor, size: 15,),
                    )
                  ],
                ),
                SizedBox(height: deviceSize.height * 0.07,),
                CircleAvatar(radius: 30, child: Image.asset('assets/images/teacher.png')),
                Text('أ/ احمد خالد', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                const Text('ادب', style: TextStyle(color: AppColors.contentTextColor), textAlign: TextAlign.center,),
                const Text('الوحدة الاولى', style: TextStyle(color: AppColors.contentTextColor), textAlign: TextAlign.center,),
                const SizedBox(height: 12,),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index)=> contentContainer(),
                  ),
                ),
                const SizedBox(height: 12,),
                buildElevatedButton('اشترك الان', (){})
              ],
            ),),
        ],
      ),
    );
  }

  Container contentContainer() {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric( vertical: 5, horizontal: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 5,
                color: Colors.grey
            )
          ]
      ),
      child: Row(
        children: [
          const Text('30 \$'),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text('المقدمة', style: TextStyle(fontSize: 14, color: Colors.black),),
              Text('40 دقيقة', style: TextStyle(fontSize: 14, color: Colors.black),),
            ],
          ),
          const SizedBox(width: 6,),
          Image.asset('assets/images/online-course 1.png', width: 40, height: 40,),
        ],
      ),
    );
  }

  Container descriptionContainer(String title, String img) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontSize: 10, color: AppColors.descriptionColor),),
          const SizedBox(width: 5,),
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
    child: const Center(child: Text('نحو', style: TextStyle(fontSize: 12),)),
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
        Image.asset('assets/images/teacher.png', width: 50, height: 50,),
        const Text('كورس أ/ عاطف محمود', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
        const Text('لغة عربية ', style: TextStyle(color: Color(0xFF888B8E)),),
        ElevatedButton(onPressed: (){}, child: const Text('اشترك الان'))
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

class SubSubject{
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