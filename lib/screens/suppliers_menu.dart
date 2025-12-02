import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SuppliersMenu extends StatefulWidget {
  final VoidCallback onBack;

  const SuppliersMenu({Key? key, required this.onBack}) : super(key: key);

  @override
  State<SuppliersMenu> createState() => _SuppliersMenuState();
}

class _SuppliersMenuState extends State<SuppliersMenu> {
  String currentView = 'menu';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: currentView == 'menu' ? widget.onBack : () => setState(() => currentView = 'menu'),
          ),
          title: const Text('الموردين'),
          actions: const [Padding(padding: EdgeInsets.all(8), child: Text('🤝', style: TextStyle(fontSize: 32)))],
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.primaryPurple, AppColors.primaryPurpleDark])),
          ),
        ),
        body: currentView == 'menu' ? _buildMenu() : _buildForm(),
      ),
    );
  }

  Widget _buildMenu() {
    return ListView(
      children: [
        _menuItem('اضافة مورد جديد', Icons.add, () => setState(() => currentView = 'form')),
        _menuItem('الأرصدة الافتتاحية والمبالغ النقدية للموردين', Icons.description, () {}),
        _menuItem('دعم الموردين - المبالغ المتبقية على الموردين من الفواتير الاجل', Icons.person, () {}),
        _menuItem('دعم الموردين - تقرير', Icons.description, () {}),
        _menuItem('الموردين المتبقي لهم أرصدة - تقرير', Icons.description, () {}),
        _menuItem('فحص أرصدة الموردين', Icons.description, () {}),
        _menuItem('عرض الموردين', Icons.search, () {}),
      ],
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const TextField(decoration: InputDecoration(labelText: 'رقم المورد')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'اسم المورد')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'العنوان')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'رقم الهاتف')),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => setState(() => currentView = 'menu'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGreen,
              foregroundColor: AppColors.textPrimary,
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGray))),
        child: Row(
          children: [
            Icon(icon, color: AppColors.accentGreen, size: 24),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
          ],
        ),
      ),
    );
  }
}
