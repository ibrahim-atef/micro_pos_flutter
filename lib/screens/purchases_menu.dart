import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class PurchasesMenu extends StatelessWidget {
  final VoidCallback onBack;

  const PurchasesMenu({Key? key, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.chevron_left), onPressed: onBack),
          title: const Text('المشتريات'),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.textPrimary,
          elevation: 1,
        ),
        body: const Center(child: Text('قائمة المشتريات', style: TextStyle(fontSize: 24))),
      ),
    );
  }
}
