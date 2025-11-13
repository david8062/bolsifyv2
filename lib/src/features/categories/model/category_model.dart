import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final int iconCode;
  final int colorValue;
  final DateTime createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconCode,
    required this.colorValue,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconCode': iconCode,
      'colorValue': colorValue,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      iconCode: map['iconCode'] ?? Icons.category_outlined.codePoint,
      colorValue: map['colorValue'] ?? Colors.blueAccent.value,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
