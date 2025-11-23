import 'package:bolsifyv2/shared/animations/fade_slide_animation.dart';
import 'package:bolsifyv2/shared/widgets/widgets.dart';
import 'package:bolsifyv2/styles/styles.dart';
import 'package:flutter/material.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _AdminViewState();
}

class _AdminViewState extends State<TransactionView> {
  int _selectedTab = 0;

  final List<String> _tabs = [
    'Presupuestos',
    'Ingresos',
    'Ahorros'

  ];

  final List<Widget> _tabContents = [
    SingleChildScrollView(
     child: Container(
       padding: const EdgeInsets.all(AppConstants.defaultPadding),
       margin: const EdgeInsets.all(AppConstants.defaultPadding), // si quieres margin
       child: Center(
         child: SettingsCardContainer(
           title: "Presupuestos",
           child: Text("ah"),
         ),
       ),
     ),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        Center(
          child: Text("Gestiona tu ingresos y gastos",
          style: TextStyle(
            fontSize: AppConstants.textTittle -5,
            fontWeight: FontWeight.w700,
            color: AppColors.textStrong
          ),
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
        ),        // espacio entre tabs y contenido
        Expanded(
          child: Stack(
            children: List.generate(_tabContents.length, (index) {
              return Positioned.fill(
                child: FadeSlideTransition(
                  isActive: _selectedTab == index,
                  child: _tabContents[index],
                ),
              );
            }),
          ),
        ),


      ],
    );
  }
}
