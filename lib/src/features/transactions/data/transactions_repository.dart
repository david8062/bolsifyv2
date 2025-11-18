import 'package:bolsifyv2/src/features/transactions/model/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionRepository {
  final FirebaseFirestore _firestore;
  final String userId;

  TransactionRepository(this.userId, {FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Crear transacción
  Future<void> addTransaction(TransactionModel trx) async {
    await _firestore
        .collection("users")
        .doc(userId)
        .collection("transactions")
        .doc(trx.id)
        .set(trx.toMap(), SetOptions(merge: true));
  }

  // Stream de transacciones
  Stream<List<TransactionModel>> getTransactionsStream() {
    return _firestore
        .collection("users")
        .doc(userId)
        .collection("transactions")
        .orderBy("date", descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => TransactionModel.fromMap(d.data())).toList());
  }

  // Borrar
  Future<void> deleteTransaction(String id) async {
    await _firestore
        .collection("users")
        .doc(userId)
        .collection("transactions")
        .doc(id)
        .delete();
  }
}
