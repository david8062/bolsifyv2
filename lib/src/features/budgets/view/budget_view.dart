import 'package:bolsifyv2/src/features/budgets/view/new_budget_form.dart';
import 'package:bolsifyv2/styles/const/app_constants.dart' show AppConstants;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../ViewModel/budget_view_model.dart';
import 'package:bolsifyv2/shared/widgets/widgets.dart';
import 'package:bolsifyv2/styles/styles.dart';



class BudgetView extends ConsumerStatefulWidget {
  const BudgetView({super.key});

  @override
  ConsumerState<BudgetView> createState() => _BudgetViewViewState();
}

class _BudgetViewViewState extends ConsumerState<BudgetView> {
  bool _showNewBudgetCard = false;

  @override
  Widget build(BuildContext context) {
  final budgetVM = ref.watch(budgetViewModelProvider.notifier);
  final budgetsStream = budgetVM.getBudgetStream();

  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.all(AppConstants.defaultPadding),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card 1
        StreamBuilder(
          stream: budgetsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final categories = snapshot.data ?? [];

            return SettingsCardContainer(
              title: 'Gestión de Presupuestos',
              actionButton: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _showNewBudgetCard = true;
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Nuevo presupuesto'),
              ),
              child: categories.isEmpty
                  ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Aún no hay presupuestos creados"),
              )
                  : SizedBox(
                height: 400, // 🔹 ajusta según tu gusto
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final c = categories[index];
                    return SummaryCard(
                      title: c.name,
                      icon: IconData(c.iconCode, fontFamily: 'MaterialIcons'),
                      color: Color(c.colorValue),
                    );
                  },
                ),
              ),

            );
          },
        ),

        const SizedBox(height: 50),

        if (_showNewBudgetCard)
          SettingsCardContainer(
            title: 'Nuevo Presupuesto',
            actionButton: ElevatedButton.icon(
              onPressed: () {
                setState(() => _showNewBudgetCard = false);
              },
              icon: const Icon(Icons.close),
              label: const Text('Cerrar'),
            ),
            child: const NewBudgetForm(),
          ),

        const SizedBox(height: 50),
      ],
    ),
  );
  }
}