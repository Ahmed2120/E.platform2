import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';

import '../components/custom_title.dart';
import 'payment_page.dart';
import 'telecom_shipping_page.dart';

class ShippingMethod extends StatefulWidget {
  ShippingMethod({Key? key}) : super(key: key);

  @override
  State<ShippingMethod> createState() => _ShippingMethodState();
}

class _ShippingMethodState extends State<ShippingMethod> {
  Method shippingMethod = Method.telecomCompany;

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
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  hintText: 'مبلغ الشحن',
                  border: InputBorder.none,
                  ),
              ),
            ),
            const SizedBox(height: 5,),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: buildBoxDecoration(),
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                    title: radioTitle('الدفع بفودافون كاش ومحافظ الجوال الاخرى', 'assets/images/telecomCompanies.png'),
                    value: Method.telecomCompany,
                    groupValue: shippingMethod,
                    onChanged: (val) => changeMethod(val))),
            const SizedBox(height: 5,),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: buildBoxDecoration(),
                child: RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: radioTitle('الدفع بالفيزا', 'assets/images/atm-card.png'),
                    value: Method.visa,
                    groupValue: shippingMethod,
                    onChanged: (val) => changeMethod(val))),
            const SizedBox(height: 5,),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: buildBoxDecoration(),
                child: RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: radioTitle('الدفع بفوري', 'assets/images/fawry.png'),
                    value: Method.fawry,
                    groupValue: shippingMethod,
                    onChanged: (val) => changeMethod(val))),
            const SizedBox(height: 5,),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: buildBoxDecoration(),
                child: RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: radioTitle('الدفع بانستا باي', 'assets/images/instapay.png'),
                    value: Method.instapay,
                    groupValue: shippingMethod,
                    onChanged: (val) => changeMethod(val))),
            const SizedBox(height: 5,),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: buildBoxDecoration(),
                child: RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: radioTitle('حساب بنكي', 'assets/images/bank.png'),
                    value: Method.bank,
                    groupValue: shippingMethod,
                    onChanged: (val) => changeMethod(val))),
            const SizedBox(height: 15,),
            CustomElevatedButton(title: 'الخطوة التالية', function: (){
              if(shippingMethod == Method.telecomCompany){
                GlobalMethods.navigate(context, TelecomShippingPage());
              }else if(shippingMethod == Method.visa){
                GlobalMethods.navigate(context, PaymentPage());
              }
            }),
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

  changeMethod(value){
    shippingMethod = value;
    setState(() {});
  }
}

enum Method { telecomCompany, visa, fawry, instapay, bank }
