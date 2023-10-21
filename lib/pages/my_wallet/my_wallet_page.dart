import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';

import '../../core/utility/global_methods.dart';
import '../components/custom_title.dart';
import 'shipping_method.dart';

class MyWalletPage extends StatelessWidget {
  MyWalletPage({required this.walletValue,Key? key}) : super(key: key);
  String  walletValue;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomStack(
        pageTitle: 'محفظتي',
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.secondaryColor
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('الرصيد المتاح', style: TextStyle(fontSize: 14, color: Colors.white),),
                  Text(walletValue, style: TextStyle(fontSize: 14, color: Colors.white),),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(child: buildWhiteElevatedButton('اشحن الان', (){})),
            const SizedBox(height: 10),
            Row(
              children: [
                Image.asset('assets/images/qr 1.png'),
                const SizedBox(width: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('عنوان المحفظة', style: TextStyle(fontSize: 14, color: AppColors.descriptionColor),),
                    Text('0487473737823', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.descriptionColor),),
                    SizedBox(width: deviceSize.width * 0.6, child: Text('يمكنك استلام رصيد من محفظة اخرى عن طريق عنوان المحفظة الخاصة بك ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.descriptionColor), textAlign: TextAlign.right,)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(child: buildWhiteElevatedButton('تحويل الرصيد', (){})),
            SizedBox(height: deviceSize.height * 0.018,),
            // Text('سجل المعاملات', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            // const SizedBox(height: 10,),
            // Container(
            //   decoration: const BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25), ),
            //   ),
            //   child: ListView.builder(
            //     physics: const NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     itemCount: 5,
            //     itemBuilder: (context, index)=> buildContainer(context),
            //   ),
            // ),
            const SizedBox(height: 20),
            CustomElevatedButton(title: 'اشحن الان', function:
                ()=> GlobalMethods.navigate(context, ShippingMethod()))
          ],
        ),
      ),
    );
  }

  Widget buildContainer(context){
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderColor))
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Image.asset('assets/icons/atom.png'),
          const SizedBox(width: 5,),
          Text('كورس الفيزياء مع أ/محمود علي', style: Theme.of(context).textTheme.titleSmall,),
          const Spacer(),
          const Text('50\$'),
        ],
      ),
    );
  }

  SizedBox buildElevatedButton(String title, Function function,
      Color color) {
    return SizedBox(
      width: 200,
      height: 40,
      child: ElevatedButton(
        onPressed: () => function(),
        child: Text(title),
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: color == Colors.white
                ? AppColors.secondaryColor
                : null,
            // minimumSize: const Size.fromHeight(40),
            side: BorderSide(
//            width: 5.0,
              color: color == Colors.white ? AppColors.secondaryColor : AppColors.primaryColor,
            ) // NEW
        ),
      ),
    );
  }

  SizedBox buildWhiteElevatedButton(String title, Function function,) {
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
