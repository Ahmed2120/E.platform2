import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../api/api.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../change_password/change_password_page.dart';
import '../../components/custom_elevated_button.dart';
import '../../register/components/otp_dialog.dart';

class VerifyPhoneNumberDialog extends StatefulWidget {
  const VerifyPhoneNumberDialog({Key? key}) : super(key: key);

  @override
  State<VerifyPhoneNumberDialog> createState() => _VerifyPhoneNumberDialogState();
}

class _VerifyPhoneNumberDialogState extends State<VerifyPhoneNumberDialog> {

  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _verify_loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        children: [
          Positioned(
              right: 0,
              child: InkWell(
                  onTap: ()=> Navigator.pop(context),
                  child: const Icon(Icons.close, size: 40, color: Colors.black,))),
          Center(child: const Text('رقم الهاتف')),
        ],
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
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
            ),
          validator: (val) {
            if (_phoneController.text.isEmpty) {
              return 'please type phone number';
            }
          },
        ),
      ),
      actions: [
        _verify_loading ? const CircularProgressIndicator() : CustomElevatedButton(title: 'تاكيد', function: (){
          if(!_formKey.currentState!.validate()) return;
          _sendOtp();
        },)
      ],
      actionsAlignment: MainAxisAlignment.center,
      titlePadding: EdgeInsets.zero,
    );
  }

  void _sendOtp()  async {
    setState(() {
      _verify_loading=true;
    });

    Map  data={
      'PhoneNumber':_phoneController.text,
    };

    print ("body "+data.toString());
    try {
      var response = await CallApi().postData(data,"/api/Account/RequestVerificationCode",0);
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        if(body['Success'] ==false) {
          ShowMyDialog.showMsg(body['Message']);
        }else{
          if(!mounted) return;
          final navigator = Navigator.of(context);
          navigator.pop();
          showDialog(context: context, builder: (context)=> OtpDialog(phoneNumber: _phoneController.text, navigateTo: ChangePasswordPage(phoneNumber: _phoneController.text,),), barrierDismissible: false);
        }
      }
      else{
        ShowMyDialog.showMsg(body['Message']);
      }
      setState(() {
        _verify_loading=false;
      });
    }
    catch(e){
      setState(() {
        _verify_loading=false;
      });
      //  ShowMyDialog.showMsg(context,'ee '+e.toString());
      print('ee '+e.toString());

    }
  }
}
