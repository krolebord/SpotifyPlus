import 'package:spotify_plus/helpers/iterables/where_with_index_iterable.dart';

extension ListExtensions<E> on Iterable<E> {
  Iterable<E> whereWithIndex(bool Function(int index, E element) test) =>
      WhereWithIndexIterable<E>(this, test);
}


