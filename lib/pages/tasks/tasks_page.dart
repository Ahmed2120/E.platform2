import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/enums.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../core/utility/card_utils.dart';
import '../../core/utility/input_formatter.dart';
import '../components/custom_title.dart';
import '../components/row_title.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'المهام',
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 7.0,
              percent: 0.7,
              reverse: true,
              center: const Text(
                "${0.7 * 100}",
                style: TextStyle(color: AppColors.percentColor, fontSize: 20),
              ),
              progressColor: AppColors.percentColor,
            ),
            Text(
              'المهام الغير مكتملة ',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: deviceSize.height * 0.016,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) => taskContainer(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container taskContainer(context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 20.0,
            lineWidth: 4.0,
            percent: 0.1,
            reverse: true,
            center: const Text(
              "${0.1 * 100}",
              style: TextStyle(color: AppColors.percentColor),
            ),
            progressColor: AppColors.percentColor,
          ),
          const Spacer(),
          Text(
            'اكمل بياناتك الشخصية',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            width: 5,
          ),
          Image.asset('assets/icons/coin.png')
        ],
      ),
    );
  }
}
