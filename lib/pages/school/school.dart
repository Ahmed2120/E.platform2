import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

import '../../api/api.dart';
import '../../core/utility/app_colors.dart';
import '../../model/SchoolPicture.dart';
import '../../widgets/dialogs/alertMsg.dart';
import '../components/row_title.dart';
import '../components/show_network_image.dart';

class SchoolPage extends StatefulWidget {
  const SchoolPage({ required this.schoolId,Key? key}) : super(key: key);
   final int schoolId;

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {

  bool _loading=false;

  var body={};

  List <SchoolPicture> _shool_pictures=[];

  late CameraPosition _schoolPosition ;
  late Marker _schoolMarker ;

  String   _name ='';
    String _desc='';
   int  _count=0;
   var _rate=0;
   var _lat= 0.0;
   var _lon=0.0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _schoolPosition = CameraPosition(
        target: LatLng(_lat.toDouble(), _lon.toDouble()),
        zoom: 12);

    _getShool();

  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'المدرسة',
        child: _loading==true?
            const Center(child: CircularProgressIndicator()): Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text( _name!,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,),
                  SizedBox(
                    height:  deviceSize.height/5,
                    width: 200,
                    child:

                    _schoolPosition !=null ?GoogleMap(
                      initialCameraPosition: _schoolPosition,
                      markers: {
                        _schoolMarker
                      },
                    ) :
                    Container(),
                  ),
                  const SizedBox(height: 10,),
                 Container(
                   height:  deviceSize.height/6,
                   child: ListView.builder(
                       itemCount: _shool_pictures.length,
                       scrollDirection:Axis.horizontal,
                       itemBuilder: (context,index){
                     return   Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ShowNetworkImage(img:_shool_pictures[index].Picture ),
                     );

                   }),
                 ),
                  const SizedBox(height: 10,),
                  Text(_desc!,
                    style: Theme.of(context).textTheme.bodySmall,),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('عدد الطلاب ', style: Theme.of(context).textTheme.titleMedium,),
                      Text(_count.toString(),
                        style: Theme.of(context).textTheme.titleMedium,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('التقييم', style: Theme.of(context).textTheme.titleMedium,),
                      RatingBar.builder(
                        initialRating: _rate.toDouble(),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                  CustomElevatedButton(title: 'سجل الان', function: (){}),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gradeContainer(context) => Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: AppColors.primaryColor, width: 3)),
        color: Colors.white
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10)
          ),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('بنك الاسئلة ', style: Theme.of(context).textTheme.titleMedium,),
            Text('لغة عربية ', style: Theme.of(context).textTheme.titleSmall,),
          ],
        ),
        const SizedBox(width: 6,),
        Image.asset('assets/images/english.png', width: 40, height: 40,)
      ],
    ),
  );

  Widget subjectContainer(context) => Column(
    children: [
      Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFBBDDF8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset('assets/icons/arabic_book.png', width: 40, height: 40,),
      ),
      Text('اللغة العربية', style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,)
    ],
  );

  void _getShool() async{
    setState(() {
      _loading=true;
    });

    Map<String,dynamic> data={'schoolId' : widget.schoolId.toString()};

    try {
      var response = await CallApi().getWithBody(data, "/api/School/GetSchoolDetails",1);
      print("body  "+json.decode(response.body).toString());

      if (response != null && response.statusCode == 200) {
             setState(() {
                   body = json.decode(response.body);
                   List p=body['SchoolImages'];
                   _shool_pictures=p.map((e) => SchoolPicture.fromJson(e)).toList();

                   _name=body['Name'];
                   _desc=body['Description'];
                   _count=body['StudentCount'];
                   _rate=body['Rate'];

                 _lat= body['Latitude'] ;
                 _lon= body['Longitude'];

                   _schoolPosition = CameraPosition(
                       target: LatLng(_lat.toDouble(), _lon.toDouble()),
                       zoom: 12);

                   _schoolMarker = Marker(
                     markerId: const MarkerId('schoolMarker'),
                     position: LatLng(_lat.toDouble(), _lon.toDouble()),
                   );
               });

      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      if(response==null){
        ShowMyDialog.showMsg('No Data');
      }
      setState(() {
        _loading=false;
      });

    }
    catch(e){
      setState(() {
        _loading=false;
      });

      print("ee "+e.toString());
    }

  }
}
