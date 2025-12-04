import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class OperationPlaceholderPage extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const OperationPlaceholderPage({
    super.key,
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: onBack,
          ),
          title: Text(title),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryPurple, AppColors.primaryPurpleDark],
              ),
            ),
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction,
                size: 48,
                color: AppColors.textSecondary,
              ),
              SizedBox(height: 12),
              Text(
                'هذه الشاشة قيد التطوير',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


