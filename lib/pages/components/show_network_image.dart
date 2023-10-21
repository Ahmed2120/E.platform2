import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShowNetworkImage extends StatelessWidget {
  const ShowNetworkImage({Key? key, required this.img, this.isCircle = false, this.isCover = true, this.size = 70}) : super(key: key);

  final String img;
  final bool isCircle;
  final bool isCover;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: size,
      fit: isCover ? BoxFit.cover : BoxFit.none,
      imageUrl: img,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[600]!,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      errorWidget: (context, url, error) =>
      const Icon(Icons.error),

      imageBuilder: isCircle ? (context, imageProvider) => Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: imageProvider, fit: BoxFit.cover),
        ),
      ) : null,
    );
  }
}
