import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';

final authViewModelProvider =
StateNotifierProvider<AuthViewModel, AsyncValue<void>>(
      (ref) => AuthViewModel(),
);

class AuthViewModel extends StateNotifier<AsyncValue<void>> {

  bool isRegistering = false;
  void showLogin() => isRegistering = false;
  void showRegister() => isRegistering = true;

  AuthViewModel() : super(const AsyncData(null));

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    try {
      // 1 Crear usuario en Auth
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final uid = credential.user!.uid;

      // 2️ Crear documento en Firestore
      final newUser = AppUser(
        id: uid,
        name: name.trim(),
        email: email.trim(),
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(uid).set(newUser.toMap());

      // 3⃣ Actualizar displayName (opcional)
      await credential.user?.updateDisplayName(name);

      state = const AsyncData(null);
    } on FirebaseAuthException catch (e) {
      state = AsyncError(_mapFirebaseError(e), StackTrace.current);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    try {
      // Iniciar sesión con FirebaseAuth
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // 2️Obtener datos del usuario desde Firestore
      final uid = credential.user!.uid;
      final userDoc = await _firestore.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        throw Exception('El usuario no existe en la base de datos.');
      }
      state = const AsyncData(null);
    } on FirebaseAuthException catch (e) {
      state = AsyncError(_mapFirebaseError(e), StackTrace.current);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }


  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Este correo ya está registrado.';
      case 'invalid-email':
        return 'Correo inválido.';
      case 'weak-password':
        return 'Contraseña muy débil.';
      default:
        return 'Error al crear la cuenta.';
    }
  }
}


