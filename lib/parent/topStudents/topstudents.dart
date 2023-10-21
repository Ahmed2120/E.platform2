import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/parent/topStudents/widgets/topstudentitem.dart';
import 'package:flutter/material.dart';

import '../../core/utility/global_methods.dart';

List<String> imagetexts = [
  'assets/images/Ellipse 1.png',
  'assets/images/Ellipse 2.png',
  'assets/images/Ellipse 12.png',
];
List<String> nametexts = ['Esraa', 'Ahmed', 'Mahmoud', 'Mohammed', 'OLa'];
List<String> gradestexts = ['99%', '98%', '97%', '96%', '95%'];

class TopStudents extends StatelessWidget {
  TopStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(children: [
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: AppColors.primaryColor,
      ),
      Container(
        margin: EdgeInsets.only(top: deviceSize.height * 0.2),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            color: AppColors.pageBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 32.0),
                const Text('الاوائل',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        height: 1.5,
                        fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: AppColors.primaryColor,
                    size: 15,
                  ),
                )
              ],
            ),
            SizedBox(height: deviceSize.height * 0.1),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/top2.png',
                      width: 120,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/images/Group 6.png',
                          width: 40,
                        ),
                        toparranging(
                            imgest: imagetexts[0],
                            colr: Colors.orange,
                            bcolr: Colors.orange,
                            arr: '1'),
                        const Text(
                          'Esraa',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        const Text('99%',
                            style: TextStyle(
                              color: Colors.orange,
                            )),
                      ],
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/tops1.png',
                      width: 100,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    toparranging(
                        imgest: imagetexts[1],
                        colr: Colors.green,
                        bcolr: Colors.green,
                        arr: '2'),
                    const Text(
                      'ahmed',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const Text('98%',
                        style: TextStyle(
                          color: Colors.green,
                        )),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    toparranging(
                        imgest: imagetexts[2],
                        colr: Colors.blue,
                        bcolr: Colors.blue,
                        arr: '3'),
                    const Text(
                      'mahmoud',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const Text('97%',
                        style: TextStyle(
                          color: Colors.blue,
                        )),
                  ],
                ),
              ],
            ),
            Container(
              color: Colors.grey.shade200,
              height: 10,
            ),
            SizedBox(
              height: 500,
              child: ListView.separated(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return topstudentitem(index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 10,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            buildElevatedButton('مشاركة', () {})
          ],
        ),
      ),
    ])));
  }

  Row topstudentitem(int i) {
    return Row(
      children: [
        Text(
          gradestexts[i],
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                nametexts[i],
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
              const Text(
                'الصف الثالث الاعدادي',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              )
            ],
          ),
        ),
        const Spacer(),
        const CircleAvatar(
            backgroundImage: AssetImage('assets/images/student-profile.png'))
      ],
    );
  }

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

  Stack toparranging(
      {required String imgest,
      required Color colr,
      required String arr,
      required Color bcolr}) {
    return Stack(
      children: [
        CircleAvatar(
            minRadius: 60,
            maxRadius: 60,
            backgroundColor: bcolr,
            child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(imgest), fit: BoxFit.cover),
                ))),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: 29,
            width: 29,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: colr,
              shape: BoxShape.circle,
            ),
            child: Text(
              arr,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
