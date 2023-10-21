import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';

class TeacherGroups extends StatelessWidget {
  const TeacherGroups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index)=> InkWell(
          onTap: (){},
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 140,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFF000000).withOpacity(0.12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 1,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 6,),
                    Text('كورس اللغة الانجليزية',
                      style: TextStyle(fontSize: deviceSize.height * 0.02, fontWeight: FontWeight.bold, color: Colors.black),maxLines: 1,),
                    SizedBox(height: 6,),
                    Text('أ/ محمد علي', style: TextStyle(fontSize: deviceSize.height * 0.02,fontWeight: FontWeight.bold, color: Colors.black),maxLines: 1,),
                    Text('ابدأ الان', style: TextStyle(fontSize: deviceSize.height * 0.02, fontWeight: FontWeight.bold),maxLines: 1,),
                  ],
                ),
              ),
              Positioned(top: 0, child: Image.asset('assets/images/english.png')),
            ],
          ),
        ));
  }
}