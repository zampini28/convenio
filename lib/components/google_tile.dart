import 'package:flutter/material.dart';
import 'package:app/components/square_tile.dart';

class GoogleTile extends StatelessWidget {
  const GoogleTile({super.key});

  build(final _) => const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [SquareTile(imagePath: 'assets/google.png')],
  );
}
