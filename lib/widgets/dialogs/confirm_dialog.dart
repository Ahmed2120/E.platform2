import 'package:flutter/material.dart';

import '../../core/utility/app_colors.dart';
import '../../pages/components/custom_elevated_button.dart';

class ConfirmDialog extends StatefulWidget {
  const ConfirmDialog({Key? key, required this.title, required this.onConfirm}) : super(key: key);

  final String title;
  final Function onConfirm;

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  size: 40,
                  color: Colors.black,
                )),
            Text(
              '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              width: 40,
            )
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                isLoading
                    ? const CircularProgressIndicator()
                    : CustomElevatedButton(
                    title: 'تأكيد', function:  onConfirm),
                CustomElevatedButton(
                  title: 'الغاء',
                  function: () => Navigator.pop(context),
                  color: AppColors.cancelColor,
                ),
              ],
            )
          ],
        ));
  }

  void onConfirm() async{
    setState(() {
      isLoading = true;
    });

    await widget.onConfirm();

    setState(() {
      isLoading = false;
    });
  }
}
