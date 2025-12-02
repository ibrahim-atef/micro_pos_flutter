import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SettingsMenu extends StatelessWidget {
  final VoidCallback onBack;

  const SettingsMenu({Key? key, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.chevron_left), onPressed: onBack),
          title: const Text('الإعدادات'),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.primaryPurple, AppColors.primaryPurpleDark])),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('معلومات المتجر'),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('إعدادات الفاتورة'),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.print),
              title: const Text('إعدادات الطابعة'),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('اللغة'),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.backup),
              title: const Text('النسخ الاحتياطي'),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
