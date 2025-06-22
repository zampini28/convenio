import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({super.key, required this.children});

  final List<Widget> children;

  @override
  build(final _) => Scaffold(
    backgroundColor: Colors.grey[100],
    body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    ),
  );
}
