import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_stack.dart';
import '../components/custom_title.dart';

class TelecomShippingPage extends StatefulWidget {
  TelecomShippingPage({Key? key}) : super(key: key);

  @override
  State<TelecomShippingPage> createState() => _TelecomShippingPageState();
}

class _TelecomShippingPageState extends State<TelecomShippingPage> {

  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'محفظتي',
        child: ListView(
          shrinkWrap: true,
          children: [
            const Row(
              children: [
                Icon(Icons.account_balance_wallet_outlined, color: AppColors.primaryColor,),
                SizedBox(width: 5,),
                Text('شحن المحفظة',),
              ],
            ),
            const SizedBox(height: 10,),
            Text('قم بتحويل مبلغ 200\$ الى الرقم التالي:', style: TextStyle(color: AppColors.titleColor),),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primaryColor)
              ),
              child: TextFormField(
                controller: _amountController,
                style: const TextStyle(color: AppColors.primaryColor),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(height: 30,),
            Text('انتظر رسالة تأكيد العملية . ثم املأ الحقول التالية بدقة لنتمكن من مراجعة العملية وتأكيدها', style: TextStyle(color: AppColors.titleColor),),
            const SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.primaryColor)
              ),
              child: TextFormField(
                // controller: _amountController,
                style: const TextStyle(color: AppColors.primaryColor),
                decoration: const InputDecoration(
                  hintText: 'رقم محفظة الجوال الخاصة بك ',
                  contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  prefixIcon: Icon(Icons.phone_android),
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Text('رقم محفظة الجوال التي ارسلت منها', style: TextStyle(color: AppColors.titleColor),),
            const SizedBox(height: 5,),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.primaryColor)
              ),
              child: Row(
                children: [
                const Icon(Icons.file_copy_outlined),
                  const SizedBox(width: 5,),
                  Text('ارفق صورة رسالة التأكيد', style: TextStyle(color: AppColors.titleColor),),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Text('قم بارفاق لقطة شاشة لرسالة تأكيد العملية ', style: TextStyle(color: AppColors.titleColor),),
            const SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.primaryColor)
              ),
              child: TextFormField(
                // controller: _amountController,
                style: const TextStyle(color: AppColors.primaryColor),
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'اترك لنا رسالة ( اختياري)',
                  contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 15,),
            CustomElevatedButton(title: 'اتمام الدفع ', function: (){}),
          ],
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      border: Border.all(
          color: const Color(0xFF000000).withOpacity(0.12)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 1,
          offset: const Offset(
              0, 3), // changes position of shadow
        ),
      ],
    );
  }

}
