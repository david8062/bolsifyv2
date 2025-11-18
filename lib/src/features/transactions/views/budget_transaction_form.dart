import 'package:bolsifyv2/src/features/budgets/ViewModel/budget_view_model.dart';
import 'package:bolsifyv2/src/features/budgets/model/budget_model.dart';
import 'package:bolsifyv2/src/features/transactions/viewModels/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bolsifyv2/styles/styles.dart';
import 'package:bolsifyv2/shared/widgets/widgets.dart';


class BudgetTransactionForm extends ConsumerStatefulWidget {
  const BudgetTransactionForm({super.key});

  @override
  ConsumerState<BudgetTransactionForm> createState() => _BudgetTransactionFormState();
}

class _BudgetTransactionFormState extends ConsumerState<BudgetTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  BudgetModel? _selectedBudget;

  @override
  Widget build(BuildContext context) {

    final budgetVM = ref.read(budgetViewModelProvider.notifier);


    final budgetsStream = budgetVM.getBudgetStream();

    return StreamBuilder<List<BudgetModel>>(
      stream: budgetsStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final budgets = snapshot.data!;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Descripción",
                style: TextStyle(
                  fontSize: AppConstants.textLabel,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textStrong,
                ),
              ),

              InputField(
                controller: _descriptionController,
                hint: "ej: compras de mercado",
                icon: Icons.add_card_rounded,
              ),
              const SizedBox(height: 16),
              SelectInput<BudgetModel>(
                label: "Presupuesto",
                value: _selectedBudget,
                options: budgets,
                labelBuilder: (b) => b.name,
                iconBuilder: (b) => Container(
                  width: 18,
                  height: 9,
                  decoration: BoxDecoration(
                    color: Color(b.colorValue),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black26),
                  ),
                ),
                onChanged: (b) {
                  setState(() => _selectedBudget = b);
                },
              ),
              const SizedBox(height: 30),
              Text("Monto",
                style: TextStyle(
                  fontSize: AppConstants.textLabel,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textStrong,
                ),
              ),
              InputField(controller: _amountController, hint: "ej:5000", icon: Icons.attach_money, keyboardType: TextInputType.number),
              const SizedBox(height: AppConstants.formHeight),
              DateInput(
                controller: _dateController,
                label: "Fecha",
                hint: "Selecciona una fecha",
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final amount = double.tryParse(_amountController.text);
                      if (amount == null || amount <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Ingrese un monto válido")),
                        );
                        return;
                      }

                      if (_selectedBudget == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Seleccione un presupuesto")),
                        );
                        return;
                      }

                      final transactionVM = ref.read(transactionViewModelProvider.notifier);

                      await transactionVM.createTransaction(
                        amount: amount,
                        categoryId: "gasto_general", // si no tienes categoría aparte
                        type: "gasto",
                        budgetId: _selectedBudget!.id,

                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Transacción creada con éxito")),
                      );

                      _descriptionController.clear();
                      _amountController.clear();
                      _dateController.clear();
                      setState(() => _selectedBudget = null);
                    }
                  },

                  icon: const Icon(Icons.save),
                  label: const Text("Guardar Presupuesto"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

