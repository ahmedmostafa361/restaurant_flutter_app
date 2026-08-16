import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

import '../core/cache_save_data/lottie_animation_cache_manager.dart';

class CachedLottie extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool repeat;
  final FrameRate frameRate;
  final RenderCache renderCache;
  final void Function(LottieComposition composition)? onLoaded;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const CachedLottie({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.repeat = true,
    this.frameRate = FrameRate.composition,
    this.renderCache = RenderCache.drawingCommands,
    this.onLoaded,
    this.errorBuilder,
  });

  @override
  State<CachedLottie> createState() => _CachedLottieState();
}

class _CachedLottieState extends State<CachedLottie> {
  LottieComposition? _cachedComposition;

  @override
  void initState() {
    super.initState();
    _cachedComposition = LottieCacheManager().get(widget.url);

    // Cached composition is already available — fire onLoaded right after
    // the first frame instead of mid-build, so it's safe for the caller
    // to navigate or call setState from inside the callback.
    if (_cachedComposition != null && widget.onLoaded != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.onLoaded!(_cachedComposition!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: _cachedComposition != null
            ? Lottie(
                composition: _cachedComposition!,
                fit: widget.fit,
                repeat: widget.repeat,
                frameRate: widget.frameRate,
                renderCache: widget.renderCache,
                // no onLoaded here — this constructor doesn't expose one
              )
            : Lottie.network(
                widget.url,
                fit: widget.fit,
                repeat: widget.repeat,
                frameRate: widget.frameRate,
                renderCache: widget.renderCache,
                onLoaded: (composition) {
                  LottieCacheManager().preloadNetwork(widget.url);
                  widget.onLoaded?.call(composition);
                },
                errorBuilder:
                    widget.errorBuilder ??
                    (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 40),
              ),
      ),
    );
  }
}