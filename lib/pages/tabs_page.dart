import 'package:flutter/material.dart';
import 'package:physioapp/pages/home_page.dart';
import 'package:physioapp/pages/exercises_page.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  TabsPageState createState() {
    return TabsPageState();
  }
}

class TabsPageState extends State<TabsPage> {
  int _index = 0;

  void _onChangeIndex(int index) {
    setState(() => _index = index);
  }

  Map<String, Object> tabSreen = {
    'title': {'Pagína Inicial', 'Exercícios'},
    'screen': {},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PhysioApp"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_mosaic),
            label: 'Exercícios',
          ),
        ],
        currentIndex: _index,
        onTap: _onChangeIndex,
      ),
    );
  }
}
