import 'package:flutter/material.dart';

extension PaddingHelper on Widget {
  Padding get p16 => Padding(padding: const EdgeInsets.all(16), child: this);
  Padding get p(double value) =>
    Padding(padding: EdgeInsets.all(value), child: this);
}
