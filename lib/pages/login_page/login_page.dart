
import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/pages/login_page/components/verify_phone_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../api/api.dart';
import '../../core/utility/global_methods.dart';
import '../../model/mainmodel.dart';
import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../core/utility/global_methods.dart';
import '../../session/userSession.dart';
import '../btm_bar_screen.dart';
import '../home/home_page.dart';
import '../register/components/otp_dialog.dart';
import '../role_page/role_page.dart';
import 'components/login_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _remember=false;
  late Map  l;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLoginData();
  }

  @override
  Widget build(BuildContext context)  {
     return ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return  Scaffold(
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
                        Icon(Icons.person, color: AppColors.primaryColor,),
                        Text('تسجل الدخول '),
                      ],
                    ),
                    const Text('مرحبا بك  من جديد'),
                  ],
                ),
                Image.asset('assets/images/login.png', height: 250,),
                Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          LoginField (controller: _phoneController),
                          const SizedBox(height: 12,),
                          LoginField(controller: _passwordController,
                            isPassword: true, showPassword: model.hidePassword, togglePass: ()=> model.togglePass(),),
                          CheckboxListTile(
                            title: Text("تذكرني", style: Theme.of(context).textTheme.titleMedium,),
                            value: _remember,
                            onChanged: (newValue) {
                               _remember=newValue!;
                               setState(() {

                               });
                            },
                            // controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),

                const SizedBox(height: 12,),
                Align(alignment: Alignment.topRight, child: TextButton(onPressed: () {
                  showDialog(context: context, builder: (context)=> const VerifyPhoneNumberDialog(), barrierDismissible: false);
                    }, child: Text('هل نسيت كلمة المرور؟',
                    style: Theme.of(context).textTheme.bodyMedium,))),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),

                  child: ScopedModelDescendant<MainModel>(
                      builder:(context,child,MainModel model){
                              return model.loginLoading ==true ?
                      const Center(child: CircularProgressIndicator()):
                              buildElevatedButton('تسجيل الدخول', (){
                 //   GlobalMethods.navigateReplace(context, const BottomBarScreen());
                    if(!_formKey.currentState!.validate()) return;

                    Map data={
                      'userName' :_phoneController.text,
                      'password':_passwordController.text,
                      'grant_type':'password'
                    };
                    UserSession.loginRemember(_remember, _phoneController.text, _passwordController.text);
                    model.login(data);
                  }, AppColors.primaryColor) ;  })

                ),
                const SizedBox(height: 20,),
                RichText(
                  textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'ليس لديك حساب؟',
                        style:
                        TextStyle(color: const Color(0xFF000000).withOpacity(0.6), fontSize: 18),
                        children: [
                          TextSpan(
                              text: ' انشاء حساب',
                              style: TextStyle(
                                  color: const Color(0xFF000000).withOpacity(0.6),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  GlobalMethods.navigate(context, const RolePage());
                                }),
                        ]))
              ],
            ),
          )),
        );
      }
    );
  }

  ElevatedButton buildElevatedButton(String title, Function function,
      Color color) {
    return ElevatedButton(
      onPressed: () => function(),
      child: Text(title),
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: color == Colors.white
              ? AppColors.secondaryColor
              : null,
          minimumSize: const Size.fromHeight(40),
          side: const BorderSide(
//            width: 5.0,
            color: AppColors.secondaryColor,
          ) // NEW
      ),
    );
  }

      void  _getLoginData()  async{

     l=  await UserSession.getLoginRemember();
     _phoneController.text= l['remember']?l['phone']:'';
    _passwordController.text=l['remember']?l['password']:'';
     _remember=l['remember'];
         setState(() {
          });
    print ("ll "+l.toString());

  }



}
