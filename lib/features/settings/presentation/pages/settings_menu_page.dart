import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class SettingsMenuPage extends StatelessWidget {
  final VoidCallback onBack;

  const SettingsMenuPage({super.key, required this.onBack});

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
          title: const Text('الإعدادات'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryPurple, AppColors.primaryPurpleDark],
              ),
            ),
          ),
        ),
        body: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.store),
              title: Text('معلومات المتجر'),
              trailing: Icon(Icons.chevron_left),
            ),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text('إعدادات الفاتورة'),
              trailing: Icon(Icons.chevron_left),
            ),
            ListTile(
              leading: Icon(Icons.print),
              title: Text('إعدادات الطابعة'),
              trailing: Icon(Icons.chevron_left),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('اللغة'),
              trailing: Icon(Icons.chevron_left),
            ),
            ListTile(
              leading: Icon(Icons.backup),
              title: Text('النسخ الاحتياطي'),
              trailing: Icon(Icons.chevron_left),
            ),
          ],
        ),
      ),
    );
  }
}


