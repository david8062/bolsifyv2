import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bolsifyv2/styles/themes/app_theme_light.dart';
import 'package:bolsifyv2/src/router/app_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Bolsify',
      theme: AppThemeLight.theme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
