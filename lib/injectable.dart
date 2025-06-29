import 'package:get_it/get_it.dart';
import 'package:cognisto/injectable.config.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)

Future<void> configureDependencies() async => getIt.init();