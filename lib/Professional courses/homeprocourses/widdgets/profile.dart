import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/pages/components/row_title.dart';
import 'package:eplatform/pages/my_wallet/shipping_method.dart';
import 'package:eplatform/parent/addingchildren/addingchildrencontent.dart';
import 'package:eplatform/parent/custom%20widgets/customtextformfield.dart';
import 'package:flutter/material.dart';

class ProfilScreen extends StatelessWidget {
  ProfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    TextEditingController searchcontroller = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
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
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/student-profile.png',
                          ),
                          Text(
                            'محمود ',
                            style: TextStyle(
                                fontSize: deviceSize.height > 500 ? 20 : 15,
                                color: Colors.black,
                                height: 1),
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                    ),
                    columncontent(title: 'كود المستخدم:', subtitle: '768494'),
                    columncontent(
                        title: ' البريد الالكتروني :',
                        subtitle: 'Omar23@gmail.com'),
                    columncontent(
                        title: 'رقم الهاتف ', subtitle: '01129876542'),
                    columncontent(title: 'الدولة ', subtitle: 'مصر '),
                    columncontent(
                        title: 'السنة الدراسية ',
                        subtitle: 'الصف الثالث الثانوي'),
                    columncontent(title: 'نوع التعليم', subtitle: 'مصري'),
                    columncontent(title: ' المحافظة ', subtitle: 'القاهره '),
                    columncontent(
                        title: ' العنوان ', subtitle: 'التحمع الخامس '),
                    SizedBox(
                      height: 15,
                    ),
                    Text(' الملف الشخصي ',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {},
                      child: Text('  تغيير كلمه المرور ',
                          style: const TextStyle(
                            fontSize: 16,
                          )),
                    ),
                    Row(
                      children: [
                        Text(' كود المشاركه  ',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Spacer(),
                        Icon(Icons.copy),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                          'https://www.flaticon.com/search?word=challenges     ',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text('  شارك الكود علي الموقع    ',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: buildElevatedButton(
                          'تسجيل الخروج', () {}, Colors.blue),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 70),
                      child: TextButton(
                        onPressed: () {},
                        child: Text('  حذف الحساب    ',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          customrowtitle(context),
        ],
      ),
    );
  }

  SizedBox buildWhiteElevatedButton(
    String title,
    Function function,
  ) {
    return SizedBox(
      width: 200,
      height: 40,
      child: ElevatedButton(
        onPressed: () => function(),
        child: Text(title),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primaryColor,
            // minimumSize: const Size.fromHeight(40),
            side: const BorderSide(
//            width: 5.0,
              color: AppColors.primaryColor,
            ) // NEW
            ),
      ),
    );
  }

  Padding customrowtitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: AppColors.primaryColor,
                size: 15,
                textDirection: TextDirection.ltr,
              ),
            ),
          ),
          Text(' الملف الشخصي ',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  height: 1.5,
                  fontWeight: FontWeight.bold)),
          const SizedBox(width: 32.0),
        ],
      ),
    );
  }

  Widget addingChildrenitem(context) => Container(
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
            Column(
              children: [
                Image.asset(
                  'assets/images/profile.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(
              width: 6,
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '  عمر احمد  ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  ' الصف الثالث الاعدادي   ',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.grey),
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
  Widget columncontent({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        Text(subtitle, style: TextStyle(color: Colors.black, fontSize: 13)),
        Divider(),
      ],
    );
  }

  SizedBox buildElevatedButton(String title, Function function, Color color) {
    return SizedBox(
      width: 200,
      height: 40,
      child: ElevatedButton(
        onPressed: () => function(),
        child: Text(title),
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor:
                color == Colors.white ? AppColors.secondaryColor : null,
            // minimumSize: const Size.fromHeight(40),
            side: BorderSide(
//            width: 5.0,
              color: color == Colors.white
                  ? AppColors.secondaryColor
                  : AppColors.primaryColor,
            ) // NEW
            ),
      ),
    );
  }
}
