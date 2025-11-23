import 'package:flutter/material.dart';
import 'package:bolsifyv2/styles/colors/app_colors.dart';
import 'package:bolsifyv2/styles/const/app_constants.dart';
import 'package:bolsifyv2/shared/widgets/widgets.dart';

class TransactionButton extends StatelessWidget {
  const TransactionButton({super.key});

  void _openTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentBackground, // para el efecto de fondo
      builder: (context) {
        return GestureDetector(
          onTap: () {}, // evita cerrar al tocar dentro
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6, // ocupa la mitad de la pantalla
            decoration: BoxDecoration(
              color: AppColors.background, // fondo del formulario
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: TransactionForm(),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _openTransactionForm(context),
      backgroundColor: AppColors.primary,
      child: const Icon(
        Icons.add,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
