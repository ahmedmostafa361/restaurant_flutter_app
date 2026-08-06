// lib/di.dart

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/config/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() => getIt.init();