import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class InventoryMenu extends StatefulWidget {
  final VoidCallback onBack;

  const InventoryMenu({Key? key, required this.onBack}) : super(key: key);

  @override
  State<InventoryMenu> createState() => _InventoryMenuState();
}

class _InventoryMenuState extends State<InventoryMenu> {
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
          title: const Text('المخزون'),
          actions: const [Padding(padding: EdgeInsets.all(8), child: Text('📦', style: TextStyle(fontSize: 32)))],
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.primaryPurple, AppColors.primaryPurpleDark])),
          ),
        ),
        body: currentView == 'menu' ? _buildMenu() : _buildProductForm(),
      ),
    );
  }

  Widget _buildMenu() {
    return ListView(
      children: [
        _menuItem('اضافة منتج جديد', Icons.add, () => setState(() => currentView = 'form')),
        _menuItem('عرض المنتجات', Icons.search, () {}),
        _menuItem('اضافة تصنيف جديد', Icons.add, () {}),
        _menuItem('تعديل اسعار المنتجات', Icons.refresh, () {}),
        _menuItem('استيراد بيانات المنتجات من ملف اكسل', Icons.upload_file, () {}),
      ],
    );
  }

  Widget _buildProductForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const TextField(decoration: InputDecoration(labelText: 'رقم المنتج (Barcode)')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'اسم المنتج')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'الوصف')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'سعر البيع'), keyboardType: TextInputType.number),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'سعر الشراء- التكلفة'), keyboardType: TextInputType.number),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'الكمية'), keyboardType: TextInputType.number),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => setState(() => currentView = 'menu'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGreen,
              foregroundColor: AppColors.textPrimary,
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('إضافة'),
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
