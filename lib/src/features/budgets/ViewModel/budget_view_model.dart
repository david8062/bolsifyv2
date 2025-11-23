import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../data/budget_repository.dart';
import '../model/budget_model.dart';



final budgetViewModelProvider =
StateNotifierProvider<BudgetViewModel, AsyncValue<List<BudgetModel>>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) throw Exception("Usuario no autenticado");
  return BudgetViewModel(user.uid);
});

class BudgetViewModel extends StateNotifier<AsyncValue<List<BudgetModel>>> {
  final BudgetRepository _repo;
  final String userId;

  BudgetViewModel(this.userId)
      : _repo = BudgetRepository(userId),
        super(const AsyncLoading()) {
    // cargar presupuestos desde el stream
    _loadBudgets();
  }

  void _loadBudgets() {
    _repo.getBudgetsStream().listen((budgets) {
      state = AsyncData(budgets);
    });
  }

  Future<void> createBudget({
    required String name,
    required int iconCode,
    required int colorValue,
    required double amountLimit,
    required double amountNotify,
  }) async {
    try {
      final budget = BudgetModel(
        id: const Uuid().v4(),
        name: name,
        iconCode: iconCode,
        colorValue: colorValue,
        createdAt: DateTime.now(),
        amountLimit: amountLimit,
        amountNotify: amountNotify,
      );
      await _repo.addBudget(budget);
      // El stream de presupuestos actualizará automáticamente el state
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
