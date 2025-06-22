import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  const DefaultText(this.text, {super.key});

  final String text;

  @override
  build(final _) =>
      Text(text, style: TextStyle(color: Colors.grey[700], fontSize: 16));
}
