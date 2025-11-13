import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bolsifyv2/styles/styles.dart';
import 'package:bolsifyv2/shared/widgets/widgets.dart';

import '../ViewModel/categories_view_model.dart';

class NewCategoryForm extends ConsumerStatefulWidget {
  const NewCategoryForm({super.key});

  @override
  ConsumerState<NewCategoryForm> createState() => _NewCategoryFormState();
}

class _NewCategoryFormState extends ConsumerState<NewCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();

  IconData _selectedIcon = Icons.fastfood;
  Color _selectedColor = Colors.blueAccent;

  final Map<String, IconData> _availableIcons = {
    "Comida": Icons.fastfood,
    "Gasolina": Icons.local_gas_station,
    "Compras": Icons.shopping_bag,
    "Hogar": Icons.home,
    "Cine": Icons.local_movies,
    "Mascotas": Icons.pets,
    "Eventos": Icons.emoji_events,
    "Regalos": Icons.card_giftcard,
  };

  final Map<String, Color> _availableColors = {
    "Azul": Colors.blueAccent,
    "Verde": Colors.greenAccent,
    "Naranja": Colors.orangeAccent,
    "Morado": Colors.purpleAccent,
    "Rojo": Colors.redAccent,
    "Turquesa": Colors.tealAccent,
    "Amarillo": Colors.amberAccent,
    "Rosado": Colors.pinkAccent,
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre
          Text(
            "Nombre de la categoría",
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

          // Select de icono
          SelectInput<String>(
            label: "Icono",
            value: _availableIcons.entries
                .firstWhere((e) => e.value == _selectedIcon)
                .key,
            options: _availableIcons.keys.toList(),
            labelBuilder: (opt) => opt,
            iconBuilder: (opt) => Icon(
              _availableIcons[opt],
              color: AppColors.textThird,
              size: 22,
            ),
            onChanged: (selectedKey) {
              setState(() => _selectedIcon = _availableIcons[selectedKey]!);
            },
          ),
          const SizedBox(height: 20),

          //  Select de color
          SelectInput<String>(
            label: "Color",
            value: _availableColors.entries
                .firstWhere((e) => e.value == _selectedColor)
                .key,
            options: _availableColors.keys.toList(),
            labelBuilder: (opt) => opt,
            iconBuilder: (opt) => Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: _availableColors[opt],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black26),
              ),
            ),
            onChanged: (selectedKey) {
              setState(() => _selectedColor = _availableColors[selectedKey]!);
            },
          ),
          const SizedBox(height: 30),

          // Botón guardar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final viewModel = ref.read(categoryViewModelProvider.notifier);

                  await viewModel.createCategory(
                    name: _nameCtrl.text.trim(),
                    iconCode: _selectedIcon.codePoint,
                    colorValue: _selectedColor.value,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Categoria creada con exito")),
                  );

                  _nameCtrl.clear();
                }
              },
              icon: const Icon(Icons.save),
              label: const Text("Guardar Categoría"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(AppConstants.buttonRadius),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
