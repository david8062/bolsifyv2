import 'package:flutter/material.dart';
import 'package:bolsifyv2/styles/styles.dart';

class BottomNav extends StatefulWidget {
  final Function(int) onTabSelected;
  final int currentIndex;

  const BottomNav({super.key, required this.onTabSelected, required this.currentIndex});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTabSelected,
      iconSize: 30, // <- tamaño de los íconos (por defecto es 24)
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.primary.withOpacity(0.6),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.stacked_bar_chart),
          label: 'Estadísticas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on),
          label: 'Presupuestos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Ajustes',
        ),
      ],
    );
  }
}
