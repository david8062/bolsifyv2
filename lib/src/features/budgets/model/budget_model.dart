import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BudgetModel {
  final String id;
  final String name;
  final int iconCode;
  final int colorValue;
  final DateTime createdAt;
  final double? amountLimit;
  final double? amountNotify;
  final double currentAmount;

  BudgetModel({
    required this.id,
    required this.name,
    required this.iconCode,
    required this.colorValue,
    required this.createdAt,
    this.amountLimit,
    this.amountNotify,
    this.currentAmount = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconCode': iconCode,
      'colorValue': colorValue,
      'createdAt': Timestamp.fromDate(createdAt),
      'amountLimit': amountLimit,
      'amountNotify': amountNotify,
      'currentAmount': currentAmount,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    final rawCreated = map['createdAt'];
    DateTime createdAt;

    if (rawCreated is Timestamp) {
      createdAt = rawCreated.toDate();
    } else if (rawCreated is String) {
      createdAt = DateTime.tryParse(rawCreated) ?? DateTime.now();
    } else {
      createdAt = DateTime.now();
    }

    return BudgetModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      iconCode: map['iconCode'] is int
          ? map['iconCode']
          : Icons.category_outlined.codePoint,
      colorValue: map['colorValue'] is int
          ? map['colorValue']
          : Colors.blueAccent.value,
      createdAt: createdAt,
      amountLimit: map['amountLimit'] != null
          ? (map['amountLimit'] as num).toDouble()
          : null,
      amountNotify: map['amountNotify'] != null
          ? (map['amountNotify'] as num).toDouble()
          : null,
      currentAmount: map['currentAmount'] != null
          ? (map['currentAmount'] as num).toDouble()
          : 0.0,
    );
  }

  BudgetModel copyWith({
    String? id,
    String? name,
    int? iconCode,
    int? colorValue,
    DateTime? createdAt,
    double? amountLimit,
    double? amountNotify,
    double? currentAmount,
  }) {
    return BudgetModel(
      id: id ?? this.id,
      name: name ?? this.name,
      iconCode: iconCode ?? this.iconCode,
      colorValue: colorValue ?? this.colorValue,
      createdAt: createdAt ?? this.createdAt,
      amountLimit: amountLimit ?? this.amountLimit,
      amountNotify: amountNotify ?? this.amountNotify,
      currentAmount: currentAmount ?? this.currentAmount,
    );
  }

  // -------------------------------------------------------
  //              E Q U A L I D A D
  // -------------------------------------------------------

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BudgetModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'BudgetModel(id: $id, name: $name)';
}
