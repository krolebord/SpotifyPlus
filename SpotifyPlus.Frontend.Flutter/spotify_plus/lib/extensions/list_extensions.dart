import 'dart:math';

extension ListExtensions<T> on List<T> {
  T getRandom() {
    var rng = Random();
    return getRandomSeeded(rng);
  }

  T getRandomSeeded(Random rng) {
    return this[rng.nextInt(length)];
  }

  T removeRandom() {
    var rng = Random();
    return removeRandomSeeded(rng);
  }

  T removeRandomSeeded(Random rng) {
    return removeAt(rng.nextInt(length));
  }
}
