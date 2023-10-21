import 'package:flutter/material.dart';

class ShowImageBottomSheet extends StatelessWidget {
  const ShowImageBottomSheet({Key? key, required this.onCameraPick, required this.onGalleryPick}) : super(key: key);

  final Function onCameraPick;
  final Function onGalleryPick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 190,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('اختر صورة', style: Theme.of(context).textTheme.headlineLarge,),
          InkWell(
            onTap: ()=>onGalleryPick(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Icons.photo_outlined, size: 30,),
                  const SizedBox(width: 20,),
                  Text('المعرض', style: Theme.of(context).textTheme.titleMedium,)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: ()=>onCameraPick(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Icons.photo_camera, size: 30,),
                  const SizedBox(width: 20,),
                  Text('كاميرا', style: Theme.of(context).textTheme.titleMedium,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
