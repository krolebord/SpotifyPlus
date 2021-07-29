import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'configure_services.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initializeGetIt',
  preferRelativeImports: true,
  asExtension: false,
  usesNullSafety: true
)
void configureServices() => $initializeGetIt(getIt);