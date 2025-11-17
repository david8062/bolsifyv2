import 'package:bolsifyv2/src/features/budgets/ViewModel/budget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bolsifyv2/styles/styles.dart';
import 'package:bolsifyv2/shared/widgets/widgets.dart';
import 'package:bolsifyv2/shared/models/category_enums.dart';

class NewBudgetForm extends ConsumerStatefulWidget {
  const NewBudgetForm({super.key});

  @override
  ConsumerState<NewBudgetForm> createState() => _NewBudgetFormState();
}

class _NewBudgetFormState extends ConsumerState<NewBudgetForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();

  final _limitCtrl = TextEditingController();
  double _limit = 0;

  Category _selectedCategory = Category.comida;
  CategoryColor _selectedColor = CategoryColor.azul;

  @override
  void initState() {
    super.initState();
    _limitCtrl.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Nombre
          Text(
            "Nombre del presupuesto",
            style: TextStyle(
              fontSize: AppConstants.textSubTittle,
              fontWeight: FontWeight.w700,
              color: AppColors.textStrong,
            ),
          ),
          const SizedBox(height: 8),

          InputField(
            controller: _nameCtrl,
            hint: "Ej: Entretenimiento",
            icon: Icons.label_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa un nombre';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          // Select de categoría
          SelectInput<Category>(
            label: "Icono",
            value: _selectedCategory,
            options: Category.values,
            labelBuilder: (category) => category.label,
            iconBuilder: (category) => Icon(
              category.icon,
              color: AppColors.textThird,
              size: 22,
            ),
            onChanged: (cat) {
              setState(() => _selectedCategory = cat);
            },
          ),

          const SizedBox(height: 20),

          // Select de color
          SelectInput<CategoryColor>(
            label: "Color",
            value: _selectedColor,
            options: CategoryColor.values,
            labelBuilder: (color) => color.label,
            iconBuilder: (color) => Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: color.color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black26),
              ),
            ),
            onChanged: (color) {
              setState(() => _selectedColor = color);
            },
          ),

          const SizedBox(height: 30),

          // ------------------------------------
          // CAMPO DEL LÍMITE — SLIDER + INPUT
          // ------------------------------------
          Text(
            "Límite de gasto",
            style: TextStyle(
              fontSize: AppConstants.textSubTittle,
              fontWeight: FontWeight.w700,
              color: AppColors.textStrong,
            ),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _limit,
                  min: 0,
                  max: 3_000_000,
                  divisions: 100,
                  activeColor: _selectedColor.color,
                  label: "\$${_limit.toStringAsFixed(0)}",
                  onChanged: (value) {
                    setState(() {
                      _limit = value;
                      _limitCtrl.text = value.toStringAsFixed(0);
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 90,
                child: TextField(
                  controller: _limitCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Valor",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    final parsed = double.tryParse(value) ?? 0;
                    setState(() => _limit = parsed);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 35),

          // Botón guardar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final viewModel = ref.read(budgetViewModelProvider.notifier);

                  await viewModel.createBudget(
                    name: _nameCtrl.text.trim(),
                    iconCode: _selectedCategory.icon.codePoint,
                    colorValue: _selectedColor.color.value,
                    amountLimit: _limit,
                    amountNotify: 0.0,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Presupuesto creado con éxito")),
                  );

                  _nameCtrl.clear();
                  _limitCtrl.text = "0";
                  setState(() => _limit = 0);
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
  }
}
