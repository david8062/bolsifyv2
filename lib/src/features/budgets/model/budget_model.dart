import 'package:flutter/material.dart';

class BudgetModel {
  final String id;
  final String name;
  final int iconCode;
  final int colorValue;
  final DateTime createdAt;
  final double? amountLimit;
  final double? amountNotify;

  BudgetModel({
    required this.id,
    required this.name,
    required this.iconCode,
    required this.colorValue,
    required this.createdAt,
    this.amountLimit,
    this.amountNotify,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconCode': iconCode,
      'colorValue': colorValue,
      'createdAt': createdAt.toIso8601String(),
      'amountLimit': amountLimit,
      'amountNotify': amountNotify,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      iconCode: map['iconCode'] ?? Icons.category_outlined.codePoint,
      colorValue: map['colorValue'] ?? Colors.blueAccent,
      createdAt: DateTime.parse(map['createdAt']),
      amountLimit: map['amountLimit'] ?? 0.0,
      amountNotify: map['amountNotify'] ?? 0.0,
    );
  }
}
