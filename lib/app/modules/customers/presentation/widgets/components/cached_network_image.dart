import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageContainer extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  const CachedImageContainer({
    Key? key,
    required this.imageUrl,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        errorWidget: (context, url, error) =>
            const Center(child: Icon(Icons.error, color: Colors.red)),
      ),
    );
  }
}
