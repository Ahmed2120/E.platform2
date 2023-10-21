import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../api/api.dart';
import '../../core/utility/app_colors.dart';
import '../../model/SchoolPicture.dart';
import '../../widgets/dialogs/alertMsg.dart';
import '../components/row_title.dart';
import '../components/show_network_image.dart';

class AdvertisingPage extends StatefulWidget {
  const AdvertisingPage({ required this.adsId,Key? key, required this.model}) : super(key: key);
  final int adsId;
  final MainModel model;

  @override
  State<AdvertisingPage> createState() => _AdvertisingPageState();
}

class _AdvertisingPageState extends State<AdvertisingPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.model.fetchAdsDetails(widget.adsId);

  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
          builder: (context, child, MainModel model) {
          return CustomStack(
            pageTitle: model.adsDetails == null ? '' : model.adsDetails!.Name,
            child: model.adsDetailsLoading?
            const Center(child: CircularProgressIndicator()): Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text( model.adsDetails == null ? '' : model.adsDetails!.Name,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,),
                      SizedBox(
                        height:  deviceSize.height/5,
                        width: 200,
                        child: ShowNetworkImage(isCover: false,
                            img: model.adsDetails == null || model.adsDetails!.Logo == null ? '' : model.adsDetails!.Logo!),
                      ),
                      const SizedBox(height: 10,),
                      Text(model.adsDetails == null || model.adsDetails!.Description == null ? '' : model.adsDetails!.Description!,
                        style: Theme.of(context).textTheme.bodySmall,),

                      // CustomElevatedButton(title: 'سجل الان', function: (){}),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }


}
