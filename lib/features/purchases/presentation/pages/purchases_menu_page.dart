import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class PurchasesMenuPage extends StatelessWidget {
  final VoidCallback onBack;

  const PurchasesMenuPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading:
              IconButton(icon: const Icon(Icons.chevron_left), onPressed: onBack),
          title: const Text('المشتريات'),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.textPrimary,
          elevation: 1,
        ),
        body: const Center(
            child: Text('قائمة المشتريات', style: TextStyle(fontSize: 24))),
      ),
    );
  }
}


