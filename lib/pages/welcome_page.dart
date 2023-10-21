import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/pages/login_page/login_page.dart';
import 'package:eplatform/pages/role_page/role_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage

  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      iconEnabledColor: AppColors.primaryColor,
                    icon: const Icon(Icons.language),
                    items: const [
                      DropdownMenuItem(value: 'en',
                        child: Text('En', style: TextStyle(color: AppColors.primaryColor),),),
                      DropdownMenuItem(value: 'ar',
                        child: Text('Ar', style: TextStyle(color: AppColors.primaryColor)),)
                    ],
                    onChanged: (v) {},
                    value: 'ar',
                  ),
                ),
              ),
              Text('مرحبا بك في ', style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge,),
              Text('Teaching', style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge,),
              Expanded(child: Image.asset('assets/images/welcome.png')),
              buildElevatedButton(
                  'تسجيل دخول', () {
                GlobalMethods.navigate(context, LoginPage());
              }, AppColors.secondaryColor),
              const SizedBox(height: 20,),
              buildElevatedButton('انشاء حساب ', () {
                GlobalMethods.navigate(context, const RolePage());
              }, AppColors.primaryColor),
              const SizedBox(height: 20,),
              buildElevatedButton('زائر', () {}, Colors.white),
            ],
          ),
        ),
      ),
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
}
