import 'package:get_it/get_it.dart';
import 'package:spotify_plus/services/api_client_factory/api_client_factory_implementation.dart';

import 'api_client_factory.dart';

extension ApiClientFactoryRegister on GetIt {
  void registerApiClientFactory() {
    registerSingleton<ApiClientFactory>(ApiClientFactoryImplementation());
  }
}