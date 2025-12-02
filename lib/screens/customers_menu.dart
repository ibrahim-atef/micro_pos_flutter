import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomersMenu extends StatefulWidget {
  final VoidCallback onBack;

  const CustomersMenu({Key? key, required this.onBack}) : super(key: key);

  @override
  State<CustomersMenu> createState() => _CustomersMenuState();
}

class _CustomersMenuState extends State<CustomersMenu> {
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
          title: const Text('العملاء'),
          actions: const [Padding(padding: EdgeInsets.all(8), child: Text('👨‍💼', style: TextStyle(fontSize: 32)))],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryPurple, AppColors.primaryPurpleDark],
              ),
            ),
          ),
        ),
        body: currentView == 'menu' ? _buildMenu() : _buildForm(),
      ),
    );
  }

  Widget _buildMenu() {
    return ListView(
      children: [
        _menuItem('اضافة عميل جديد', Icons.add, () => setState(() => currentView = 'form')),
        _menuItem('الأرصدة الافتتاحية والمبالغ النقدية للعملاء', Icons.trending_up, () {}),
        _menuItem('دعم العملاء - المبالغ المتبقية عند العملاء من الفواتير الاجل', Icons.person, () {}),
        _menuItem('دعم العملاء - تقرير', Icons.description, () {}),
        _menuItem('العملاء المتبقي لهم أرصدة - تقرير', Icons.description, () {}),
        _menuItem('فحص أرصدة العملاء', Icons.description, () {}),
        _menuItem('عرض العملاء', Icons.search, () {}),
      ],
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const TextField(decoration: InputDecoration(labelText: 'رقم العميل')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'اسم العميل')),
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
