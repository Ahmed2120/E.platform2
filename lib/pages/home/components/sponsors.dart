import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../model/mainmodel.dart';
import '../../advertising/advertising_page.dart';
import '../../components/show_network_image.dart';
import '../../my_grades/my_grades_page.dart';
import '../../tasks/tasks_page.dart';
import '../../test_yourself/test_yourself_page.dart';

class Sponsors extends StatefulWidget {
  const Sponsors({Key? key, required this.model}) : super(key: key);
  final MainModel model;

  @override
  State<Sponsors> createState() => _SponsorsState();
}

class _SponsorsState extends State<Sponsors> {

  @override
  void initState() {
    super.initState();

    widget.model.fetchHomeAds();
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return model.homeAdsLoading ? const Center(child: CircularProgressIndicator()) : ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index)=> const SizedBox(width: 10,),
              itemCount: model.allHomeAds.length,
              itemBuilder: (ctx, index) {

                return sponsorsContainer(model.allHomeAds[index].Image!,
                        ()=>GlobalMethods.navigate(ctx, AdvertisingPage(
                  adsId: model.allHomeAds[index].Id!, model: model,)));
              }
          );
        }
    );
  }

  Widget sponsorsContainer(String img, Function function){
    return InkWell(
      onTap: ()=> function(),
      child: Container(
        height: 70,
        width: 70,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            color: Color(0xFFF6FBFE),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 3,
                  spreadRadius: 1,
                  color: Colors.grey
              )
            ]
        ),
        child: img != '' ? Image.network(img) : Image.asset('assets/images/XFf8KrxwqXo9GY9yDttOPG8rjRjmh1Cd 2.png'),
      ),
    );
  }
}

