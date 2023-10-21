import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/pages/components/row_title.dart';
import 'package:eplatform/pages/my_wallet/shipping_method.dart';
import 'package:eplatform/parent/addingchildren/addingchildrencontent.dart';
import 'package:eplatform/parent/custom%20widgets/customtextformfield.dart';
import 'package:flutter/material.dart';

class AddingChildren extends StatelessWidget {
  AddingChildren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    TextEditingController searchcontroller = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: AppColors.primaryColor,
            ),
            Container(
              margin: EdgeInsets.only(top: deviceSize.height * 0.2),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: AppColors.pageBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  children: [
                    SizedBox(
                      child: CustomTextFormField(
                        perfixicon: Icons.search,
                        hintText: ' بحث برقم الهاتف ',
                        controller: searchcontroller,
                        validator: (h) {
                          if (h!.isEmpty) {
                            return 'please enter the data';
                          }
                          return null;
                        },
                      ),
                    ),
                    ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            GlobalMethods.navigate(
                                context, AddingChildrenContent());
                          },
                          child: addingChildrenitem(
                            context,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            customrowtitle(context),
          ],
        ),
      ),
    );
  }

  Padding customrowtitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: AppColors.primaryColor,
                size: 15,
                textDirection: TextDirection.ltr,
              ),
            ),
          ),
          Text('اضف ابناء',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  height: 1.5,
                  fontWeight: FontWeight.bold)),
          const SizedBox(width: 32.0),
        ],
      ),
    );
  }

  Widget addingChildrenitem(context) => Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        decoration: BoxDecoration(
          border: const Border(
              right: BorderSide(color: AppColors.primaryColor, width: 5)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/profile.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(
              width: 6,
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '  عمر احمد  ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  ' الصف الثالث الاعدادي   ',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
}
