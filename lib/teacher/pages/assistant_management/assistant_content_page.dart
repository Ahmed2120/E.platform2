import 'package:eplatform/model/assistant/assistant.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../core/utility/app_colors.dart';
import '../../../model/assistant/assistantRequest.dart';
import '../../../pages/components/custom_elevated_button.dart';
import '../../../pages/components/show_network_image.dart';

class AssistantContentPage extends StatelessWidget {
  AssistantContentPage({Key? key, required this.assistant}) : super(key: key);

  final AssistantRequest assistant;

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomStack(
        pageTitle: 'ادارة المساعدين',
        child: ListView(
          shrinkWrap: true,
          children: [
            Image.network(
              assistant.AssistantImage!,
              width: 80,
              height: 80,
            ),
            Text(
              assistant.AssistantName!,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),

            const SizedBox(
              height: 12,
            ),
            Text(
              'رقم الهاتف',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.right,
            ),

            const SizedBox(
              height: 8,
            ),
            Text(
              // assistant.PhoneNumber ?? '',
               '',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
            Divider(
              color: AppColors.borderColor,
            ),

            Text(
              'الدولة',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.right,
            ),

            const SizedBox(
              height: 8,
            ),
            Text(
              // assistant.CountryName ?? '',
             '',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
            Divider(
              color: AppColors.borderColor,
            ),

            Text(
              'نوع التعليم',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.right,
            ),

            const SizedBox(
              height: 8,
            ),
            Text(
              // assistant.EducationTypeName ?? '',
              '',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
            Divider(
              color: AppColors.borderColor,
            ),

            Text(
              'نوع المنهج',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.right,
            ),

            const SizedBox(
              height: 8,
            ),
            Text(
              // assistant.ProgramTypeName ?? '',
              '',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
            Divider(
              color: AppColors.borderColor,
            ),

            // Text('الصلاحيات',
            //   style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.right,),

            const SizedBox(
              height: 30,
            ),

            ScopedModelDescendant<MainModel>(
                builder: (context, child, MainModel model) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  model.acceptLoading
                      ? const CircularProgressIndicator()
                      : CustomElevatedButton(
                          title: 'قبول',
                          function: () => model.acceptAssistantRequest(
                              assistantId: assistant.AssistantRequestId!),
                        ),


                  model.rejectLoading
                      ? const CircularProgressIndicator()
                      : CustomElevatedButton(
                    title: 'رفض',
                    function: () => model.rejectAssistantRequest(assistantId: assistant.AssistantRequestId!),
                    color: Colors.red,
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
