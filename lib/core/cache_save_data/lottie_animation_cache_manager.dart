import 'package:lottie/lottie.dart';

class LottieCacheManager {
  static final LottieCacheManager _instance = LottieCacheManager._internal();

  factory LottieCacheManager() => _instance;

  LottieCacheManager._internal();

  final Map _cache = {};

  /// Preloads a single network animation into memory
  Future preloadNetwork(String url) async {
    if (_cache.containsKey(url)) return _cache[url];

    try {
      final composition = await NetworkLottie(url).load();
      _cache[url] = composition;
      return composition;
    } catch (e) {
      return null;
    }
  }

  /// Preloads multiple network URLs in parallel
  Future preloadAllNetwork(List urls) async {
    await Future.wait(urls.map((url) => preloadNetwork(url)));
  }

  /// Retrieves a preloaded composition
  LottieComposition? get(String url) => _cache[url];

  /// Cache memory management
  void remove(String url) => _cache.remove(url);

  void clear() => _cache.clear();
}
