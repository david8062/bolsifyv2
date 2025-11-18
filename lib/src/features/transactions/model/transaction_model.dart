import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final double amount;
  final String categoryId;
  final String type; // "ingreso" o "gasto"
  final DateTime date;
  final String? budgetId; // solo obligatorio si type == "gasto"

  TransactionModel({
    required this.id,
    required this.amount,
    required this.categoryId,
    required this.type,
    required this.date,
    this.budgetId,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "amount": amount,
      "categoryId": categoryId,
      "type": type,
      "date": Timestamp.fromDate(date),
      "budgetId": budgetId,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map["id"],
      amount: (map["amount"] as num).toDouble(),
      categoryId: map["categoryId"],
      type: map["type"],
      date: (map["date"] as Timestamp).toDate(),
      budgetId: map["budgetId"],
    );
  }

  TransactionModel copyWith({
    String? id,
    double? amount,
    String? categoryId,
    String? type,
    DateTime? date,
    String? budgetId,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      type: type ?? this.type,
      date: date ?? this.date,
      budgetId: budgetId ?? this.budgetId,
    );
  }
}
