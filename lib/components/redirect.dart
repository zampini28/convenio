import 'package:flutter/material.dart';

class Redirect extends StatelessWidget {
  Redirect({
    super.key,
    required this.context,
    required this.child,
    required this.route,
  });

  final child;
  final context;
  final route;

  @override
  build(final _) => GestureDetector(
    onTap: () => Navigator.pushNamed(context, route),
    child: child,
  );
}
