import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/category_repository.dart';
import '../model/category_model.dart';
import 'package:uuid/uuid.dart';

final categoriesProvider = StreamProvider<List<CategoryModel>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) throw Exception("Usuario no autenticado");
  final viewModel = CategoryViewModel(user.uid);
  return viewModel.getCategoriesStream();
});

final authStateProvider = StreamProvider<User?>(
      (ref) => FirebaseAuth.instance.authStateChanges(),
);

final categoryViewModelProvider =
StateNotifierProvider<CategoryViewModel, AsyncValue<void>>((ref) {
  final auth = ref.watch(authStateProvider);

  return auth.when(
    data: (user) {
      if (user == null) {
        throw Exception("Usuario no autenticado");
      }
      return CategoryViewModel(user.uid);
    },
    loading: () {
      return CategoryViewModel('_loading_');
    },
    error: (_, __) {
      return CategoryViewModel('_error_');
    },
  );
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
