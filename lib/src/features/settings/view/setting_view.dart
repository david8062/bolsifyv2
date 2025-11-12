import 'package:flutter/material.dart';
import 'package:bolsifyv2/shared/widgets/widgets.dart';
import 'package:bolsifyv2/shared/animations/fade_slide_animation.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  int _selectedTab = 0;

  final List<String> _tabs = [
    'Categorías',
    'Presupuestos',
    'Ahorros',
    'Preferencias',
    'Cuenta',
  ];

  final List<Widget> _tabContents = [
    Center(child: Text('Contenido de Categorías')),
    Center(child: Text('Contenido de Presupuestos')),
    Center(child: Text('Contenido de Ahorros')),
    Center(child: Text('Contenido de Preferencias')),
    Center(child: Text('Contenido de Cuenta')),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsTabs(
          tabs: _tabs,
          initialIndex: _selectedTab,
          onTabChanged: (index) {
            setState(() {
              _selectedTab = index;
            });
          },
        ),
        const SizedBox(height: 20),
        // Aquí mostramos el contenido animado de la pestaña
        Expanded(
          child: Stack(
            children: List.generate(_tabContents.length, (index) {
              return FadeSlideTransition(
                isActive: _selectedTab == index,
                child: _tabContents[index],
              );
            }),
          ),
        ),
      ],
    );
  }
}
