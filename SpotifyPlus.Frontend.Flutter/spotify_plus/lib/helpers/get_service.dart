import 'package:get_it/get_it.dart';

T getService<T extends Object>() {
  return GetIt.instance.get<T>();
}
