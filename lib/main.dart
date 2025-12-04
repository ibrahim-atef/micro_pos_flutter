import 'package:flutter/material.dart';

import 'core/constants/app_theme.dart';
import 'features/splash/presentation/pages/splash_page.dart';

void main() {
  runApp(const MicroPOSApp());
}

class MicroPOSApp extends StatelessWidget {
  const MicroPOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MicroPOS - Micro Point of Sale',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashPage(),
    );
  }
}
