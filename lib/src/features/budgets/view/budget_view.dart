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
    final budgetState = ref.watch(budgetViewModelProvider);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          budgetState.when(
            data: (budgets) {
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
                child: (budgets.isEmpty)
                    ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Aún no hay presupuestos creados"),
                )
                    : SizedBox(
                  height: 400,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: budgets.length,
                    itemBuilder: (context, index) {
                      final b = budgets[index];
                      return SummaryCard(
                        title: b.name,
                        icon: IconData(b.iconCode, fontFamily: 'MaterialIcons'),
                        color: Color(b.colorValue),
                      );
                    },
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error al cargar presupuestos: $e'),
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
