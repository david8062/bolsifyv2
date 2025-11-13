import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bolsifyv2/src/features/categories/model/category_model.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore;
  final String userId;

  CategoryRepository(this.userId, {FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Agregar categoría
  Future<void> addCategory(CategoryModel category) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(category.id)
        .set(category.toMap(), SetOptions(merge: true));
  }

  // Stream de categorías
  Stream<List<CategoryModel>> getCategoriesStream() {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => CategoryModel.fromMap(doc.data()))
        .toList());
  }

  // borrar categoría
  Future<void> deleteCategory(String categoryId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(categoryId)
        .delete();
  }

  // actualizar categoría
  Future<void> updateCategory(CategoryModel category) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(category.id)
        .update(category.toMap());
  }
}
