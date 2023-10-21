import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';

import '../../core/utility/global_methods.dart';
import 'shipping_method.dart';

class ParentWalletPage extends StatelessWidget {
  ParentWalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 32.0),
                      const Text('محفظتي',
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
                  SizedBox(
                    height: deviceSize.height * 0.16,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.secondaryColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'الرصيد المتاح',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Text(
                          '\$ 1.234',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(child: buildWhiteElevatedButton('اشحن الان', () {})),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset('assets/images/qr 1.png'),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'عنوان المحفظة',
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.descriptionColor),
                          ),
                          Text(
                            '0487473737823',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.descriptionColor),
                          ),
                          SizedBox(
                              width: deviceSize.width * 0.6,
                              child: Text(
                                'يمكنك استلام رصيد من محفظة اخرى عن طريق عنوان المحفظة الخاصة بك ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColors.descriptionColor),
                                textAlign: TextAlign.right,
                              )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Center(
                      child: buildWhiteElevatedButton('تحويل الرصيد', () {})),
                  SizedBox(
                    height: deviceSize.height * 0.018,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'سجل المعاملات',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.016,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        buildContainer(context),
                        buildContainer(context),
                        buildContainer(context),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.016,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: buildElevatedButton(
                          'اشحن الان',
                          () =>
                              GlobalMethods.navigate(context, ShippingMethod()),
                          AppColors.primaryColor))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.borderColor))),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Image.asset('assets/icons/atom.png'),
          const SizedBox(
            width: 5,
          ),
          Text(
            'كورس الفيزياء مع أ/محمود علي',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const Spacer(),
          const Text('50\$'),
        ],
      ),
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
}
