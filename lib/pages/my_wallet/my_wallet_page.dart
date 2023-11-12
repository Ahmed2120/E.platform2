import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../core/utility/global_methods.dart';
import '../../model/mainmodel.dart';
import '../../model/wallet/userTransaction.dart';
import '../components/custom_title.dart';
import '../components/show_network_image.dart';
import 'shipping_method.dart';

class MyWalletPage extends StatefulWidget {
  MyWalletPage({required this.walletValue, required this.model, Key? key}) : super(key: key);
  String  walletValue;
  MainModel model;

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {

  @override
  void initState() {
    super.initState();

    widget.model.fetchUserBalance();
    widget.model.fetchUserTransaction();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomStack(
        pageTitle: 'محفظتي',
        child: ScopedModelDescendant<MainModel>(
            builder:(context,child,MainModel model){
            return ListView(
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
                      const Text('الرصيد المتاح', style: TextStyle(fontSize: 14, color: Colors.white),),
                      model.balanceLoading ? const SizedBox(
                        width: 50,
                        height: 50,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballClipRotateMultiple,
                          colors: [AppColors.primaryColor],
                        ),
                      ) : Text(model.balance.toString(), style: const TextStyle(fontSize: 14, color: Colors.white),),
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
                Text('سجل المعاملات', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                const SizedBox(height: 10,),
                model.usertransactionLoading ? const Center(child: CircularProgressIndicator()) : Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25), ),
                  ),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:  model.userTransactionList.length,
                    itemBuilder: (context, index)=> buildContainer(context, model.userTransactionList[index]),
                  ),
                ),

                const SizedBox(height: 20),
                CustomElevatedButton(title: 'اشحن الان', function:
                    ()=> GlobalMethods.navigate(context, ShippingMethod()))
              ],
            );
          }
        ),
      ),
    );
  }

  Widget buildContainer(context, UserTransaction userTransaction){
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.borderColor))
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          userTransaction.image ==null ? Image.asset('assets/icons/atom.png') :
          ShowNetworkImage(img: userTransaction.image!),
          const SizedBox(width: 5,),
          SizedBox(
            width: 200,
              child: Text(userTransaction.description??'', style: Theme.of(context).textTheme.titleSmall,)),
          const Spacer(),
          Text(userTransaction.amount.toString()),
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
