import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewModelProvider =
ChangeNotifierProvider<SplashViewModel>((ref) => throw UnimplementedError());

class SplashViewModel extends ChangeNotifier {
  final TickerProvider vsync;
  late final AnimationController logoController;
  late final AnimationController buttonController;

  bool showButton = false;
  bool showStats = false;
  bool loadingDone = false;

  SplashViewModel({required this.vsync}) {
    _initAnimations();
    _simulateLoading();
  }

  void _initAnimations() {
    logoController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    buttonController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );
  }

  void _simulateLoading() {
    Timer(const Duration(seconds: 3), () {
      loadingDone = true;
      showStats = true;
      notifyListeners();

      Future.delayed(const Duration(milliseconds: 700), () {
        showButton = true;
        buttonController.forward();
        notifyListeners();
      });
    });
  }

  @override
  void dispose() {
    logoController.dispose();
    buttonController.dispose();
    super.dispose();
  }
}
