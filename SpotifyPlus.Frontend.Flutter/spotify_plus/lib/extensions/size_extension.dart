import 'package:flutter/cupertino.dart';

extension Size on num {
  double get w => this * SizingData.width;
  double get h => this * SizingData.height;
}

class SizingData {
  static late BoxConstraints _constraints;

  static double get width => _constraints.maxWidth;
  static double get height => _constraints.maxWidth;

  SizingData._();

  static void setConstraints(BoxConstraints constraints) {
    _constraints = constraints;
  }
}