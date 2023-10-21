
import 'package:flutter/material.dart';
import '../../main.dart';

     class ShowMyDialog  {

     static  void showMsg(msg){
 showDialog<void>(
context: navigatorKey.currentContext!,
barrierDismissible: false, // user must tap button!
builder: (BuildContext context) {
return AlertDialog(
// title: const Text('يوجد خطأ ما'),
content: Text(
'${msg}',
style: TextStyle
(
fontWeight: FontWeight.w900,
fontSize: 18
),

),
actions: <Widget>[
TextButton(
child: const Text('تم'),
onPressed: () {
Navigator.of(context).pop(true);
},
),
],
);
} );
}
                       static void showSnack(context , String msg){
  ScaffoldMessenger.of(context).showSnackBar(
   SnackBar(
      dismissDirection:DismissDirection.up,
      backgroundColor: Colors.deepPurple,
      elevation: 10,
      content: Text(
        msg ,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900
        ),
        textAlign: TextAlign.center,
      )

  ) );
}
}