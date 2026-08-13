import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../core/cache_save_data/lottie_animation_cache_manager.dart';

class CachedLottie extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final FrameRate frameRate;
  final RenderCache renderCache;

  const CachedLottie({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.frameRate = FrameRate.composition,
    this.renderCache = RenderCache.drawingCommands,
  });

  @override
  Widget build(BuildContext context) {
    final cachedComposition = LottieCacheManager().get(url);

    return RepaintBoundary(
      child: SizedBox(
        width: width,
        height: height,
        child: cachedComposition != null
            ? Lottie(
                composition: cachedComposition,
                fit: fit,
                frameRate: frameRate,
                renderCache: renderCache,
              )
            : Lottie.network(
                url,
                fit: fit,
                frameRate: frameRate,
                renderCache: renderCache,
                onLoaded: (composition) {
                  // Save to cache for subsequent renders
                  LottieCacheManager().preloadNetwork(url);
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 40),
              ),
      ),
    );
  }
}
