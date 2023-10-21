import 'package:flutter/material.dart';

import '../../core/utility/app_colors.dart';
import '../../pages/components/custom_elevated_button.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({Key? key, required this.title, required this.onConfirm, required this.loading}) : super(key: key);

  final String title;
  final Function onConfirm;
  final bool loading;

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
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                loading
                    ? const CircularProgressIndicator()
                    : CustomElevatedButton(
                    title: 'تأكيد', function: () {
                      onConfirm();
                  Navigator.pop(context, true);
                }),
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
}
