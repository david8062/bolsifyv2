import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bolsifyv2/src/features/categories/view/new_category_form.dart';
import 'package:flutter/material.dart';
import 'package:bolsifyv2/shared/widgets/widgets.dart';
import 'package:bolsifyv2/styles/styles.dart';
import '../ViewModel/categories_view_model.dart';


class CategoriesView extends ConsumerStatefulWidget {
  const CategoriesView({super.key});

  @override
  ConsumerState<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends ConsumerState<CategoriesView> {
  bool _showNewCategoryCard = false;

  @override
  Widget build(BuildContext context) {
    final categoryVM = ref.watch(categoryViewModelProvider.notifier);
    final categoriesStream = categoryVM.getCategoriesStream();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card 1
          StreamBuilder(
            stream: categoriesStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final categories = snapshot.data ?? [];

              return SettingsCardContainer(
                title: 'Gestión de Categorías',
                actionButton: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showNewCategoryCard = true;
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Nueva Categoría'),
                ),
                child: categories.isEmpty
                    ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Aún no hay categorías creadas"),
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

          if (_showNewCategoryCard)
            SettingsCardContainer(
              title: 'Nueva Categoría',
              actionButton: ElevatedButton.icon(
                onPressed: () {
                  setState(() => _showNewCategoryCard = false);
                },
                icon: const Icon(Icons.close),
                label: const Text('Cerrar'),
              ),
              child: const NewCategoryForm(),
            ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
