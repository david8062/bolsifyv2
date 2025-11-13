import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/category_repository.dart';
import '../model/category_model.dart';
import 'package:uuid/uuid.dart';

final categoryViewModelProvider =
StateNotifierProvider<CategoryViewModel, AsyncValue<void>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  return CategoryViewModel(user?.uid ?? '');
});

class CategoryViewModel extends StateNotifier<AsyncValue<void>> {
  final CategoryRepository _repo;
  final String userId;

  CategoryViewModel(this.userId)
      : _repo = CategoryRepository(userId),
        super(const AsyncData(null));

  Future<void> createCategory({
    required String name,
    required int iconCode,
    required int colorValue,
  }) async {
    state = const AsyncLoading();
    try {
      final category = CategoryModel(
        id: const Uuid().v4(),
        name: name,
        iconCode: iconCode,
        colorValue: colorValue,
        createdAt: DateTime.now(),
      );
      await _repo.addCategory(category);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Stream<List<CategoryModel>> getCategoriesStream() {
    return _repo.getCategoriesStream();
  }
}
