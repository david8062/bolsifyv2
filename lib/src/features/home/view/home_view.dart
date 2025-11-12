import 'package:flutter/material.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../styles/styles.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;


  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [

      Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const [
              SummaryCard(
                title: "Ingresos",
                icon: Icons.trending_up,
                amount: "\$4,250.00",
                percentage: "12%",
                positive: true,
                color: Colors.green,
              ),
              SizedBox(height: 15),
              SummaryCard(
                title: "Gastos",
                icon: Icons.trending_down,
                amount: "\$2,850.00",
                percentage: "5%",
                positive: false,
                color: Colors.red,
              ),
              SummaryCard(
                title: "Balance",
                icon: Icons.scale_sharp,
                amount: "\$2,850.00",
                percentage: "5%",
                positive: false,
                color: AppColors.secondary,
              ),
              SummaryCard(
                title: "Ahorro",
                icon: Icons.savings,
                amount: "\$2,850.00",
                percentage: "5%",
                positive: false,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
      Center(child: Text('Estadísticas')),
      Center(child: Text('Presupuestos')),
      Center(child: Text('Ajustes')),
    ];
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: _pages[_currentIndex], // Muestra la página activa
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
