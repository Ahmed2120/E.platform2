import 'package:flutter/material.dart';

import '../../pages/components/custom_elevated_button.dart';

class OkDialog extends StatelessWidget {
  const OkDialog({Key? key, required this.title, required this.loading, required this.onConfirm}) : super(key: key);

  final String title;
  final bool loading;
  final Function onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: ()=> Navigator.pop(context),
                child: const Icon(Icons.close, size: 40, color: Colors.black,)),
            Text('', style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(width: 40,)
          ],),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
            const SizedBox(height: 10,),
            loading ? const CircularProgressIndicator() : CustomElevatedButton(title: 'حسنا', function: ()=>onConfirm())
          ],
        )
    );
  }
}
