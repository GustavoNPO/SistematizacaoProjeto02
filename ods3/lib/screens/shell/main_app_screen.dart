import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import '../meds/medicamentos_screen.dart';
import '../goals/metas_screen.dart';
import '../help/teleorientacao_screen.dart';


class MainAppScreen extends StatefulWidget {
  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}


class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;


  final List<Widget> _screens = [
    HomeScreen(),
    MedicamentosScreen(),
    MetasScreen(),
    TeleorientacaoScreen(),
  ];


  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: 'Remédios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Metas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Ajuda',
          ),
        ],
      ),
    );
  }
}
