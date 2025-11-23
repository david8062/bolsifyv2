import 'package:bolsifyv2/src/features/transactions/viewModels/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bolsifyv2/styles/styles.dart';
import 'package:bolsifyv2/shared/widgets/widgets.dart';
import 'package:bolsifyv2/src/features/budgets/ViewModel/budget_view_model.dart';
import 'package:bolsifyv2/src/features/budgets/model/budget_model.dart';
import 'package:bolsifyv2/src/features/categories/ViewModel/categories_view_model.dart';
import 'package:bolsifyv2/src/features/categories/model/category_model.dart';

class TransactionForm extends ConsumerStatefulWidget {
  const TransactionForm({super.key});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends ConsumerState<TransactionForm> {
  final _formKey = GlobalKey<FormState>();

  String _type = "income"; // ingreso o gasto
  final TextEditingController _amountController = TextEditingController(text: "0");
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  CategoryModel? _selectedCategory;
  BudgetModel? _selectedBudget;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_amountController.text) ?? 0;

    if (_type == "income" && _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona una categoría")),
      );
      return;
    }

    if (_type == "expense" && _selectedBudget == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona un presupuesto")),
      );
      return;
    }

    try {
      await ref.read(transactionViewModelProvider.notifier).createTransaction(
        amount: amount,
        categoryId: _selectedCategory?.id ?? '',
        type: _type,
        budgetId: _selectedBudget?.id,
      );

      // Mostrar SnackBar de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Transacción guardada exitosamente!")),
      );

      // Cerrar modal/form
      Navigator.of(context).pop();
    } catch (e) {
      // Mostrar error si algo falla
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar transacción: $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final budgetsAsync = ref.watch(budgetViewModelProvider); // stream de presupuestos
    final categoriesAsync = ref.watch(categoriesProvider); // stream de categorías

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Toggle ingreso/gasto
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    _type = "income";
                    _selectedCategory = null;
                    _selectedBudget = null;
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _type == "income" ? AppColors.success : AppColors.background,
                    foregroundColor: _type == "income" ? AppColors.background : AppColors.textPrimary,
                  ),
                  child: const Text("Ingreso"),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    _type = "expense";
                    _selectedCategory = null;
                    _selectedBudget = null;
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _type == "expense" ? AppColors.error : Colors.grey[200],
                    foregroundColor: _type == "expense" ? Colors.white : Colors.black,
                  ),
                  child: const Text("Gasto"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Monto
          InputField(
            controller: _amountController,
            hint: "Monto",
            icon: Icons.attach_money,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) return "Ingresa un monto";
              if (double.tryParse(value) == null) return "Monto inválido";
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Selección dinámica: categoría o presupuesto
          if (_type == "income")
            categoriesAsync.when(
              data: (categories) => SelectInput<CategoryModel>(
                label: "Categoría",
                value: _selectedCategory,
                options: categories,
                labelBuilder: (c) => c.name,
                iconBuilder: (c) => Icon(
                  IconData(c.iconCode, fontFamily: 'MaterialIcons'),
                  color: Color(c.colorValue),
                ),
                onChanged: (c) => setState(() => _selectedCategory = c),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => const Text("Error al cargar categorías"),
            )
          else
            budgetsAsync.when(
              data: (budgets) => SelectInput<BudgetModel>(
                label: "Presupuesto",
                value: _selectedBudget,
                options: budgets,
                labelBuilder: (b) => b.name,
                onChanged: (b) => setState(() => _selectedBudget = b),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => const Text("Error al cargar presupuestos"),
            ),

          const SizedBox(height: 16),

          // Descripción
          InputField(
            controller: _descriptionController,
            hint: "Descripción",
            icon: Icons.description,
          ),
          const SizedBox(height: 16),

          // Fecha
          DateInput(
            controller: _dateController,
            label: "Fecha",
            hint: "Selecciona la fecha",
            validator: (value) {
              if (value == null || value.isEmpty) return "Selecciona una fecha";
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Botones lado a lado
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.buttonRadius * 2),
                    ),
                  ),
                  child: const Text("Guardar", style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.background,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.buttonRadius * 2),
                    ),
                  ),
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
