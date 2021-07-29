// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'services/api_client_factory/api_client_factory.dart' as _i7;
import 'services/api_client_factory/api_client_factory_implementation.dart'
    as _i8;
import 'services/api_service/api_service.dart' as _i9;
import 'services/api_service/api_service_implementation.dart' as _i10;
import 'services/auth/auth_service.dart' as _i5;
import 'services/auth/auth_service_implementation.dart' as _i6;
import 'services/auth_prefs/auth_prefs.dart' as _i3;
import 'services/auth_prefs/auth_prefs_implementation.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initializeGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.AuthPrefs>(_i4.AuthPrefsImplementation());
  gh.singleton<_i5.AuthService>(
      _i6.AuthServiceImplementation(get<_i3.AuthPrefs>()));
  gh.singleton<_i7.ApiClientFactory>(
      _i8.ApiClientFactoryImplementation(get<_i5.AuthService>()));
  gh.singleton<_i9.ApiService>(
      _i10.ApiServiceImplementation(get<_i7.ApiClientFactory>()));
  return get;
}
