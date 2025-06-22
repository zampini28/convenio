import 'package:flutter/material.dart';

class ScreenLoading extends StatelessWidget {
  const ScreenLoading({super.key});

  @override
  build(final _) => Container(
    color: Colors.black.withOpacity(0.3),
    child: const Center(child: CircularProgressIndicator()),
  );
}
