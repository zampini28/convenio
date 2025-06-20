import 'package:flutter/material.dart';
import 'package:physioapp/controller/auth_controller.dart';
import 'package:physioapp/pages/auth_page.dart';
import 'package:physioapp/pages/auth_or_home_page.dart';
import 'package:physioapp/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(PhysioApp());

class PhysioApp extends StatelessWidget {
  const PhysioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => AuthController(),
          child: AuthOrHomePage(),
        ),
        routes: {
          AppRoutes.authpage: (context) => AuthPage(),
        });
  }
}
