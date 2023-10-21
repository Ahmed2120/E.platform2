import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utility/card_utils.dart';
import '../../core/utility/input_formatter.dart';
import '../components/custom_title.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _cardNumController = TextEditingController();

  CardType cardType = CardType.Invalid;

  void getCardTypeFrmNum(){
    if(_cardNumController.text.length <= 6){
      String cardNum = CardUtils.getCleanedNumber(_cardNumController.text);
      print(cardNum);
      CardType type = CardUtils.getCardTypeFrmNumber(cardNum);
      if (type != cardType) {
        print('cardType');
        cardType = type;
        print(cardType);
        setState(() {});
      }
    }
  }

  @override
  void initState() {

    print('sd');
    _cardNumController.addListener(() {
      getCardTypeFrmNum();
    });

    super.initState();
  }

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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
            ),
          ),
          Padding(padding: const EdgeInsets.only(top: 30),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 32.0),
                      const Text('محفظتي', style: TextStyle(fontSize: 20, color: Colors.white, height: 1.5, fontWeight: FontWeight.bold)),

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
                ),
                SizedBox(height: deviceSize.height * 0.09,),
                Image.asset('assets/images/payment_cart.png'),
                SizedBox(height: deviceSize.height * 0.016,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Cart number', style: TextStyle(color: Colors.black),),
                      TextFormField(
                        controller: _cardNumController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          CardNumberInputFormatter()
                        ],
                        decoration: buildInputDecoration('0000  0000  0000  0000', cartNum: true)
                      ),
                      const SizedBox(height: 10,),
                      const Text('Cardholder name', style: TextStyle(color: Colors.black),),
                      TextFormField(
                        decoration: buildInputDecoration('ex. Jonathan Paul Ive')
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Expiry date', style: TextStyle(color: Colors.black),),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(4),
                                  CardMonthInputFormatter()
                                ],
                        decoration: buildInputDecoration('MM / YY'),
                      ),
                        ]
                          )),
                          const SizedBox(width: 10,),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('CVV / CVC', style: TextStyle(color: Colors.black),),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(4),
                                ],
                        decoration: buildInputDecoration('3-4 digits')
                      ),
                        ]
                          )),
                        ],
                      )
                    ],
                  )),
                )
              ],
            ),),
        ],
      ),
    );
  }

  InputDecoration buildInputDecoration(hintText, {bool cartNum = false}) {
    return InputDecoration(
      suffixIcon: cartNum ? Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          CardUtils.getCrdIcon(cardType),
          const SizedBox(width: 20,),
          Image.asset('assets/icons/scan.png'),
          const SizedBox(width: 20,),
        ],
      ) : null,
                            contentPadding: EdgeInsets.all(10),
                            hintText: hintText,
                          filled: true,
                          fillColor: const Color(0xFFEAECEE),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFEAECEE),
            ),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(15))
                        );
  }
}