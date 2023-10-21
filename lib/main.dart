import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'Professional courses/rootprocourses/rootprocorses.dart';
import 'core/utility/app_strings.dart';
import 'core/utility/theme_data.dart';
import 'parent/rootParentpag.dart';

import 'model/mainmodel.dart';

import 'pages/welcome_page.dart';
import 'videoConference/videoHome_page.dart';
import 'parent/homescreen/homescreen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ZegoUIKit().initLog().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale("en", "US"), Locale('ar', 'AE')],
        locale: const Locale('ar', 'AE'),
        title: AppStrings.appName,
        theme: Styles.themeData(context),
        home: WelcomePage(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
