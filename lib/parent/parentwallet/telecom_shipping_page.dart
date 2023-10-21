import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';

class TelecomShippingPage extends StatefulWidget {
  TelecomShippingPage({Key? key}) : super(key: key);

  @override
  State<TelecomShippingPage> createState() => _TelecomShippingPageState();
}

class _TelecomShippingPageState extends State<TelecomShippingPage> {
  Method shippingMethod = Method.telecomCompany;

  final _amountController = TextEditingController();

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
                  height: deviceSize.height * 0.09,
                ),
                Row(
                  children: [
                    const Text(
                      'شحن المحفظة',
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: AppColors.primaryColor,
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        'قم بتحويل مبلغ 200\$ الى الرقم التالي:',
                        style: TextStyle(color: AppColors.titleColor),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primaryColor)),
                        child: TextFormField(
                          controller: _amountController,
                          style: const TextStyle(color: AppColors.primaryColor),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Divider(
                        height: 30,
                      ),
                      Text(
                        'انتظر رسالة تأكيد العملية . ثم املأ الحقول التالية بدقة لنتمكن من مراجعة العملية وتأكيدها',
                        style: TextStyle(color: AppColors.titleColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primaryColor)),
                        child: TextFormField(
                          // controller: _amountController,
                          style: const TextStyle(color: AppColors.primaryColor),
                          decoration: const InputDecoration(
                            hintText: 'رقم محفظة الجوال الخاصة بك ',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            prefixIcon: Icon(Icons.phone_android),
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'رقم محفظة الجوال التي ارسلت منها',
                        style: TextStyle(color: AppColors.titleColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primaryColor)),
                        child: Row(
                          children: [
                            Icon(Icons.file_copy_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'ارفق صورة رسالة التأكيد',
                              style: TextStyle(color: AppColors.titleColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'قم بارفاق لقطة شاشة لرسالة تأكيد العملية ',
                        style: TextStyle(color: AppColors.titleColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primaryColor)),
                        child: TextFormField(
                          // controller: _amountController,
                          style: const TextStyle(color: AppColors.primaryColor),
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: 'اترك لنا رسالة ( اختياري)',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      buildElevatedButton('اتمام الدفع ', () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      border: Border.all(color: const Color(0xFF000000).withOpacity(0.12)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 1,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }

  Widget radioTitle(String title, String image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          image,
          width: 50,
          height: 50,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
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

  changeMethod(value) {
    shippingMethod = value;
    setState(() {});
  }
}

enum Method { telecomCompany, visa, fawry, instapay, bank }
