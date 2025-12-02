import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SalesMenu extends StatefulWidget {
  final VoidCallback onBack;
  final int? registerNum;

  const SalesMenu({
    Key? key,
    required this.onBack,
    this.registerNum,
  }) : super(key: key);

  @override
  State<SalesMenu> createState() => _SalesMenuState();
}

class _SalesMenuState extends State<SalesMenu> {
  List<Map<String, dynamic>> items = [];
  String productName = '';
  String quantity = '';
  String price = '';

  void _addItem() {
    if (productName.isNotEmpty && quantity.isNotEmpty && price.isNotEmpty) {
      setState(() {
        items.add({
          'id': DateTime.now().millisecondsSinceEpoch,
          'name': productName,
          'quantity': int.tryParse(quantity) ?? 0,
          'price': double.tryParse(price) ?? 0.0,
        });
        productName = '';
        quantity = '';
        price = '';
      });
    }
  }

  void _removeItem(int id) {
    setState(() {
      items.removeWhere((item) => item['id'] == id);
    });
  }

  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + (item['quantity'] * item['price']));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: widget.onBack,
          ),
          title: const Text('المبيعات'),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
          backgroundColor: Colors.white,
          foregroundColor: AppColors.textPrimary,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Date Display
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.borderGray),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('تاريخ الفاتورة'),
                    Text(DateTime.now().toString().split(' ')[0]),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Barcode Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.borderGray),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('حفظ'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.infoBlue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'ابحث عن منتج أو استخدم الكاهم',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Product Input
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.borderGray),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'إضافة منتج',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: const InputDecoration(labelText: 'المنتج'),
                      onChanged: (value) => productName = value,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(labelText: 'السعر'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => price = value,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(labelText: 'الكمية'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => quantity = value,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _addItem,
                        icon: const Icon(Icons.add),
                        label: const Text('إضافة'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Items Table
              if (items.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.borderGray),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('المنتج')),
                      DataColumn(label: Text('السعر')),
                      DataColumn(label: Text('الكمية')),
                      DataColumn(label: Text('الإجمالي')),
                      DataColumn(label: Text('')),
                    ],
                    rows: items.map((item) {
                      return DataRow(cells: [
                        DataCell(Text(item['name'])),
                        DataCell(Text(item['price'].toString())),
                        DataCell(Text(item['quantity'].toString())),
                        DataCell(Text((item['quantity'] * item['price']).toStringAsFixed(2))),
                        DataCell(IconButton(
                          icon: const Icon(Icons.delete, color: AppColors.errorRed),
                          onPressed: () => _removeItem(item['id']),
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              const SizedBox(height: 24),
              
              // Summary
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPurple,
                      ),
                      child: const Text('x تصفيه جميع الشاشات'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('الإجمالي', style: TextStyle(fontSize: 14)),
                        Text(
                          totalAmount.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryPurple,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
