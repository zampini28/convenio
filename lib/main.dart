import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/signup_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/test_page.dart';
import 'package:app/model/sub_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DevicePreview(
  enabled: true,
  builder: (context) => const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Convenio',
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => HomePage(),
        '/test': (context) => MedicalAppointmentMapView(),
        '/dashboard': (context) => const DashboardScreen(),
        '/doctor_dashboard': (context) => const DoctorDashboardScreen(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
      },
      initialRoute: '/test',
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String? id;
  String? userType;

  @override
  void initState() {
    super.initState();
    getCustomerInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Container(
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('assets/doctor_face.jpg'),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.withOpacity(0.7),
                  Colors.red.withOpacity(0.5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/heartbeat.png",
                  color: Colors.white,
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Convenio",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "aplicativo",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getCustomerInfo() async {
    SharedPreferences customerInfo = await SharedPreferences.getInstance();
    id = customerInfo.getString('id');
    userType = customerInfo.getString('userType');

    Future.delayed(const Duration(seconds: 57), () {
      if (id != null) {
        if (userType == 'Patient') {
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          Navigator.pushReplacementNamed(context, '/doctor_dashboard');
        }
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Hello from DashboardScreen")),
    );
  }
}

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Hello from DoctorDashboardScreen")),
    );
  }
}

