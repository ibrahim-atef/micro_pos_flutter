import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class SalesMenuPage extends StatelessWidget {
  final VoidCallback onBack;
  final int? registerNum;

  const SalesMenuPage({
    super.key,
    required this.onBack,
    this.registerNum,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('شاشة المبيعات'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onBack,
          ),
        ),
        body: Center(
          child: Text(
            registerNum == null
                ? 'شاشة المبيعات'
                : 'شاشة المبيعات - رقم $registerNum',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
