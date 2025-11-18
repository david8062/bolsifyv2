import 'package:bolsifyv2/src/features/budgets/data/budget_repository.dart';
import 'package:bolsifyv2/src/features/transactions/data/transactions_repository.dart';
import 'package:bolsifyv2/src/features/transactions/model/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionViewModelProvider =
StateNotifierProvider<TransactionViewModel, AsyncValue<List<TransactionModel>>>(
      (ref) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("Usuario no autenticado");
    }
    final userId = user.uid;
    final transactionRepo = TransactionRepository(userId);
    final budgetRepo = BudgetRepository(userId);
    return TransactionViewModel(transactionRepo, budgetRepo);
  },
);


class TransactionViewModel extends StateNotifier<AsyncValue<List<TransactionModel>>> {
  final TransactionRepository _repo;
  final BudgetRepository _budgetRepo;

  TransactionViewModel(this._repo, this._budgetRepo) : super(const AsyncLoading()) {
    _loadTransactions();
  }

  void _loadTransactions() {
    _repo.getTransactionsStream().listen((transactions) {
      state = AsyncData(transactions);
    });
  }

  Future<void> createTransaction({
    required double amount,
    required String categoryId,
    required String type, // "ingreso" o "gasto"
    String? budgetId,
  }) async {
    final trx = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amount,
      categoryId: categoryId,
      type: type,
      date: DateTime.now(),
      budgetId: budgetId,
    );

    // Guardar la transacción en Firestore
    await _repo.addTransaction(trx);

    // Si es gasto, actualizar el presupuesto correspondiente
    if (type == "gasto" && budgetId != null) {
      final budgets = await _budgetRepo.getBudgetsStream().first;
      final budget = budgets.firstWhere((b) => b.id == budgetId);

      final updatedBudget = budget.copyWith(
        currentAmount: budget.currentAmount + amount,
      );

      await _budgetRepo.updateBudget(updatedBudget);
    }
  }

  Future<void> deleteTransaction(String id) async {
    await _repo.deleteTransaction(id);
  }
}
