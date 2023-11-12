
import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../model/mainmodel.dart';
import '../../session/userSession.dart';
import '../components/custom_elevated_button.dart';
import 'components/change_password_field.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({ required this.phoneNumber});

  final String phoneNumber;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  bool _login_loading=false;
  bool hidePassword=true;
  bool hideConfirmPassword=true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.dataBackgroundColor,
      body: SafeArea(child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(Icons.password, color: AppColors.primaryColor,),
                    Text('تغيير كلمة المرور'),
                  ],
                ),
              ],
            ),
            Image.asset('assets/images/login.png', height: 250,),
            ScopedModelDescendant<MainModel>(
                builder:(context,child,MainModel model){
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ChangePasswordField(controller: _passwordController, hintText: 'كلمة المرور', hidePassword: hidePassword, togglePass: togglePass,),
                      const SizedBox(height: 12,),
                      ChangePasswordField(controller: _confirmPasswordController, hintText: 'تاكيد كلمة المرور', isConfirmPassword: true, passwordController: _passwordController, hidePassword: hideConfirmPassword, togglePass: toggleConfirmPass,),
                    ],
                  ),
                );
              }
            ),
            // const SizedBox(height: 12,),
            // Align(alignment: Alignment.topRight, child: TextButton(onPressed: (){}, child: Text('هل نسيت كلمة المرور؟', style: Theme.of(context).textTheme.bodyMedium,))),
            const SizedBox(height: 12,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),

                child: ScopedModelDescendant<MainModel>(
                    builder:(context,child,MainModel model){
                      return model.passwordLoading ==true ?
                      const Center(child: CircularProgressIndicator()):
                      CustomElevatedButton(title: 'تغيير كلمة السر', function: ()async{
                        //   GlobalMethods.navigateReplace(context, const BottomBarScreen());
                        if(!_formKey.currentState!.validate()) return;

                        Map session=await UserSession.GetData();

                        Map data={
                          "PhoneNumber": session['phoneNumber'],
                          "NewPassword": _passwordController.text
                        };
                        model.changePassword(data);

                      }) ;  })

            ),
          ],
        ),
      )),
    );
  }

  togglePass(){
    hidePassword = !hidePassword;
    setState(() {
    });

  }
  toggleConfirmPass(){
    hideConfirmPassword = !hideConfirmPassword;
    setState(() {
    });

  }
}
