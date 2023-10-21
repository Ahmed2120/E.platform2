import 'dart:convert';

import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/pages/login_page/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../api/api.dart';
import '../../../core/utility/app_colors.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../btm_bar_screen.dart';
import '../../home/home_page.dart';

class OtpDialog extends StatefulWidget {
  const OtpDialog({Key? key, required this.phoneNumber, required this.navigateTo}) : super(key: key);

  final String phoneNumber;
  final Widget navigateTo;

  @override
  State<OtpDialog> createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  final _formKey = GlobalKey<FormState>();

  final _1Controller = TextEditingController();
  final _2Controller = TextEditingController();
  final _3Controller = TextEditingController();
  final _4Controller = TextEditingController();

  bool _otp_loading = false;
  bool _send_loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        children: [
          Positioned(
              right: 0,
              child: InkWell(
                  onTap: ()=> Navigator.pop(context),
                  child: const Icon(Icons.close, size: 40, color: Colors.black,))),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding:  EdgeInsets.only(top: 40, right: 5, left: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('كود التاكيد', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center,),
                  SizedBox(height: 6,),
                  Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildSizedBox(context, first: true, last: false, controller: _1Controller),
                        buildSizedBox(context, first: false, last: false, controller: _2Controller),
                        buildSizedBox(context, first: false, last: false, controller: _3Controller),
                        buildSizedBox(context, first: false, last: true, controller: _4Controller),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        Center(
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'لم تستلم الكود ؟',
                  style:
                  TextStyle(color: const Color(0xFF000000).withOpacity(0.6), fontSize: 18),
                  children: [
                    _otp_loading ? const TextSpan(text: ' ...') : TextSpan(
                        text: ' اعادة ارسال',
                        style: TextStyle(
                            color: const Color(0xFF000000).withOpacity(0.6),
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {_reSendOtp(); }),
                  ])),
        ),
        SizedBox(height: 6,),
        Center(
          child: _send_loading ? const CircularProgressIndicator() : buildElevatedButton('تأكيد', (){
            if(!_formKey.currentState!.validate()) return;
            _sendOtp();
          }, AppColors.primaryColor),
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget buildSizedBox(BuildContext context, {controller, bool first = false, bool last = false}) {
    return SizedBox(
      // color: Colors.red,
            height: 60,
            width: 60,
            child: TextFormField(
              controller: controller,
              onChanged: (val){
                if(val.length == 1) FocusScope.of(context).nextFocus();

                if(val.isEmpty && !first) FocusScope.of(context).previousFocus();
              },
              style: Theme.of(context).textTheme.titleMedium,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  errorStyle: TextStyle(
                    fontSize: 0, // change the font size of the error message
                  ),
                filled: true,
                  fillColor: AppColors.otpColor,
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
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
                      borderRadius: BorderRadius.circular(10))
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (val) {
                if (val!.isEmpty) {
                  return '';
                }
              },
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

  void _reSendOtp()  async {
    setState(() {
      _otp_loading=true;
    });

    Map  data={
      'PhoneNumber':widget.phoneNumber,
    };

    print ("body "+data.toString());
    try {
      var response = await CallApi().postData(data,"/api/Account/RequestVerificationCode",0);
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        ShowMyDialog.showMsg( body['Message']);
        if(body['Success'] ==false) {
          ShowMyDialog.showMsg(body['Message']);
        }
      }
      else{
        ShowMyDialog.showMsg(body['Message']);
      }
      setState(() {
        _otp_loading=false;
      });
    }
    catch(e){
      setState(() {
        _otp_loading=false;
      });
      //  ShowMyDialog.showMsg(context,'ee '+e.toString());
      print('ee '+e.toString());

    }
  }

  void _sendOtp()  async {
    setState(() {
      _send_loading=true;
    });

    final code = _1Controller.text + _2Controller.text + _3Controller.text + _4Controller.text;

    Map  data={
      "PhoneNumber": widget.phoneNumber,
      "Code": code
    };

    print ("body "+data.toString());
    try {
      var response = await CallApi().postData(data,"/api/Account/VerifyPhoneNumber",0);
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        ShowMyDialog.showMsg( body['Message']);
        if(body['Success'] ==false) {
          ShowMyDialog.showMsg(body['Message']);
        }else{
          if(!mounted) return;
          GlobalMethods.navigateReplace(context, widget.navigateTo);
        }
      }
      else{
        ShowMyDialog.showMsg(body['Message']);
      }
      setState(() {
        _send_loading=false;
      });
    }
    catch(e){
      setState(() {
        _send_loading=false;
      });
      //  ShowMyDialog.showMsg(context,'ee '+e.toString());
      print('ee '+e.toString());

    }
  }
}
