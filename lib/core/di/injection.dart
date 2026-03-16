import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// PURPOSE: Central Dependency Injection setup.
/// 
/// We use get_it as our service locator.
final GetIt getIt = GetIt.instance;

/// configureDependencies() initializes our dependencies annotated with @injectable
/// and @lazySingleton so we can request them anywhere via `getIt<Type>()`.
@InjectableInit(
  initializerName: 'init', 
  preferRelativeImports: true, 
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();

/// A module allows us to register third-party classes like Connectivity and FlutterSecureStorage
/// into get_it, since we can't annotate their source code with @injectable.
@module
abstract class CoreModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
