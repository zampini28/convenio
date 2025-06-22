import 'package:flutter/material.dart';
import 'package:app/components/custom_colors.dart';
import 'package:app/components/extension.dart';

class ApplicationBar extends StatelessWidget {
  const ApplicationBar({
    super.key
    required String image,
  });

  final String image,

  @override
  build(final context) => AppBar(
    elevation: 0,
    backgroundColor: Theme.of(context).colorScheme.background,
    leading: Icon(Icon.short_text, size: 30, color: Colors.black),
    actions: <Widget> [
      Icon(Icon.notification_none, size: 30, color: CustomColors.grey),
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        child: Container(
          // height: 40,
          // width: 40,
          decoration: BoxDecoration(
            color Theme.of(context).colorScheme.background,
          ),
          child: Image.asset(image, fit: BoxFit.fill),
        ),
      ).p(8),
    ],
  );
}
