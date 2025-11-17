import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bolsifyv2/src/features/budgets/model/budget_model.dart';

class BudgetRepository{
  final FirebaseFirestore _firestore;
  final String userId;

  BudgetRepository(this.userId, {FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  //Agregar Budget (presupuesto)
  Future<void> addBudget ( BudgetModel budget) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('budgets')
        .doc(budget.id)
        .set(budget.toMap(), SetOptions(merge: true));
  }

  //Stream de presupuestos
  Stream<List<BudgetModel>> getBudgetsStream() {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('budgets')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => BudgetModel.fromMap(doc.data()))
        .toList());
    }

    //Borrar presupuesto
  Future<void> deleteBudget(String categoryId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(categoryId)
        .delete();
  }

  // actualizar Presupuesto
  Future<void> updateBudget(BudgetModel budget) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(budget.id)
        .update(budget.toMap());
  }


}

