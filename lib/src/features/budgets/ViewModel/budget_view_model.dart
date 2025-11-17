import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../data/budget_repository.dart';
import '../model/budget_model.dart';



final budgetViewModelProvider =
    StateNotifierProvider<BudgetViewModel, AsyncValue<void>>((ref) {
      final user = FirebaseAuth.instance.currentUser;
      return BudgetViewModel(user?.uid ?? '');
    });

class BudgetViewModel extends StateNotifier<AsyncValue<void>> {
  final BudgetRepository _repo;
  final String userId;

  BudgetViewModel(this.userId)
    : _repo = BudgetRepository(userId),
      super(const AsyncData(null));

  Future<void> createBudget({
    required String name,
    required int iconCode,
    required int colorValue,
    required double amountLimit,
    required double amountNotify,
  }) async {
    state = const AsyncLoading();
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
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
  Stream<List<BudgetModel>> getBudgetStream() {
    return _repo.getBudgetsStream();
  }
}
