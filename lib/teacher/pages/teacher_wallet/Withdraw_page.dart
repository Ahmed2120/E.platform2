import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_stack.dart';

class WithdrawPage extends StatefulWidget {
  WithdrawPage({Key? key}) : super(key: key);

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {

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
                Text('سحب الرصيد',),
              ],
            ),
            const SizedBox(height: 10,),
            Text('سيتم سحب مبلغ 200\$ الى الرقم التالي:', style: TextStyle(color: AppColors.titleColor),),
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

            const SizedBox(height: 15,),
            CustomElevatedButton(title: 'اتمام السحب ', function: (){}),
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
