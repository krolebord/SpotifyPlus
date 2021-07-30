typedef ElementWithIndexPredicate<E> = bool Function(int index, E element);

class WhereWithIndexIterable<E> extends Iterable<E> {
  final Iterable<E> _iterable;
  final ElementWithIndexPredicate<E> _test;

  WhereWithIndexIterable(this._iterable, this._test);

  @override
  Iterator<E> get iterator => WhereWithIndexIterator<E>(_iterable.iterator, _test);
}

class WhereWithIndexIterator<E> extends Iterator<E> {
  final Iterator<E> _iterator;
  final ElementWithIndexPredicate<E> _test;

  var index = 0;

  WhereWithIndexIterator(this._iterator, this._test);

  @override
  bool moveNext() {
    while (_iterator.moveNext()) {
      if (_test(index++, _iterator.current)) {
        return true;
      }
    }
    return false;
  }

  @override
  E get current => _iterator.current;
}
