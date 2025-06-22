import 'dart:math';
import 'package:flutter/material.dart';
import 'package:app/theme/light_color.dart';

extension TextStyleHelpers on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get white => copyWith(color: Colors.white);
  TextStyle get subTitleColor =>
      copyWith(color: ColorResources.subTitleTextColor);
}

extension PaddingHelper on Widget {
  Padding get p16 => Padding(padding: const EdgeInsets.all(16), child: this);

  /// Set padding according to `value`
  Padding p(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Horizontal Padding
  Padding get hP4 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: this);
  Padding get hP8 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: this);
  Padding get hP16 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: this);

  /// Vertical Padding
  Padding get vP4 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: this);
  Padding get vP8 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: this);
  Padding get vP16 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: this);
}

extension Extented on Widget {
  Expanded get extended => Expanded(child: this);
}

extension CornerRadius on Widget {
  ClipRRect get circular => ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(1000)),
    child: this,
  );
}

extension OnPressed on Widget {
  Widget ripple(
    VoidCallback onPressed, {
BorderRadius? borderRadius = const BorderRadius.all(Radius.circular(5)),
  }) => Material(
    color: Colors.transparent, // Needed for InkWell ripple to show
    borderRadius: borderRadius,
    child: InkWell(borderRadius: borderRadius, onTap: onPressed, child: this),
  );
}

extension ExAlignment on Widget {
  Widget get alignTopCenter =>
      Align(child: this, alignment: Alignment.topCenter);
  Widget get alignCenter => Align(child: this, alignment: Alignment.center);
  Widget get alignBottomCenter =>
      Align(child: this, alignment: Alignment.bottomCenter);
  Widget get alignBottomLeft =>
      Align(child: this, alignment: Alignment.bottomLeft);
}
