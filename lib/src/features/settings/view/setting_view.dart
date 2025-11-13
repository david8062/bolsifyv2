import 'package:bolsifyv2/src/features/categories/view/categories_view.dart';
import 'package:bolsifyv2/styles/colors/app_colors.dart';
import 'package:bolsifyv2/styles/const/app_constants.dart';
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
    const CategoriesView(),
    Center(child: Text('Contenido de Presupuestos')),
    Center(child: Text('Contenido de Ahorros')),
    Center(child: Text('Contenido de Preferencias')),
    Center(child: Text('Contenido de Cuenta')),
  ];

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const SizedBox(height: 25),
        Text("Ajustes",
        style: TextStyle(
          fontSize: AppConstants.textTittle,
          fontWeight: FontWeight.w700,
          color: AppColors.textStrong
        ),
        ),
        const SizedBox(height: 25),
        SettingsTabs(
          tabs: _tabs,
          initialIndex: _selectedTab,
          onTabChanged: (index) {
            setState(() {
              _selectedTab = index;
            });
          },
        ),
        const SizedBox(height: 20), // espacio entre tabs y contenido
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
