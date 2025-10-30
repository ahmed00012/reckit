import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reckit/gen/assets.gen.dart';
import 'package:shimmer/shimmer.dart';



class CachedNetworkImageHelper extends StatelessWidget {
  const CachedNetworkImageHelper({
    super.key,
    this.borderRadius = 20,
    this.imageUrl,
    this.cacheKey,
    this.height,
    this.width,
    this.fit,
    this.showShimmer = true,
  });

  final double borderRadius;
  final String? imageUrl;
  final String? cacheKey;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final bool showShimmer;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        memCacheWidth: 1024,
        memCacheHeight: 1024,
        fit: fit ?? BoxFit.fill,
        height: height,
        width: width,
        imageUrl: imageUrl ??
            'https://thumb.ac-illust.com/b1/b170870007dfa419295d949814474ab2_t.jpeg',
        placeholder: (context, url) => showShimmer
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              )
            : SizedBox.shrink(),
        errorWidget: (context, url, error) => Image.network(
          'https://thumb.ac-illust.com/b1/b170870007dfa419295d949814474ab2_t.jpeg',
          fit: fit ?? BoxFit.fill,
          height: height,
          width: width,
        ),
      ),
    );
  }
}

DecorationImage decorationImageHelper(
  String? imageUrl, {
  String? cacheKey,
  BoxFit? fit,
}) {
  final fallbackUrl =
      'https://thumb.ac-illust.com/b1/b170870007dfa419295d949814474ab2_t.jpeg';

  try {
    final String url;
    if (imageUrl != null && Uri.tryParse(imageUrl)?.isAbsolute == true) {
      url = imageUrl;
    } else {
      url = fallbackUrl;
    }

    return DecorationImage(
      image: CachedNetworkImageProvider(url, cacheKey: cacheKey),
      fit: fit ?? BoxFit.fill,
    );
  } catch (e) {
    return DecorationImage(
      image: CachedNetworkImageProvider(fallbackUrl, cacheKey: cacheKey),
      fit: BoxFit.fill,
    );
  }
}

