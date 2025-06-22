import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({super.key, required this.text, required this.onTap});

  final String text;
  final Function() onTap;

  @override
  build(final _) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}
