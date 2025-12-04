import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class CashBoxMenuPage extends StatefulWidget {
  final VoidCallback onBack;

  const CashBoxMenuPage({super.key, required this.onBack});

  @override
  State<CashBoxMenuPage> createState() => _CashBoxMenuState();
}

class _CashBoxMenuState extends State<CashBoxMenuPage> {
  /// true = اضافه للصندوق, false = خصم من الصندوق
  bool isAddToCashBox = true;
  String amount = '0';
  String date = DateTime.now().toString().split(' ')[0];
  String statement = '';
  bool addSales = true;
  bool addPurchases = true;
  bool addExpenses = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: widget.onBack,
          ),
          title: const Text('الصندوق'),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('💼', style: TextStyle(fontSize: 32)),
            )
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryPurple, AppColors.primaryPurpleDark],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            // Add/Withdraw Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildModeButton(
                      isSelected: isAddToCashBox,
                      title: 'اضافه للصندوق',
                      icon: Icons.add,
                      onTap: () {
                        setState(() {
                          isAddToCashBox = true;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildModeButton(
                      isSelected: !isAddToCashBox,
                      title: 'خصم من الصندوق',
                      icon: Icons.remove,
                      onTap: () {
                        setState(() {
                          isAddToCashBox = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      decoration:
                          const InputDecoration(labelText: 'ادخل الملبغ'),
                      onChanged: (v) => amount = v,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(labelText: 'التاريخ'),
                      onChanged: (v) => date = v,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(labelText: 'البيان'),
                      onChanged: (v) => statement = v,
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title:
                          const Text('اضافة مبالغ المبيعات والعملاء للصندوق'),
                      value: addSales,
                      onChanged: (v) =>
                          setState(() => addSales = v ?? addSales),
                    ),
                    CheckboxListTile(
                      title: const Text(
                          'خصم مبالغ المشتريات والموردين من الصندوق'),
                      value: addPurchases,
                      onChanged: (v) =>
                          setState(() => addPurchases = v ?? addPurchases),
                    ),
                    CheckboxListTile(
                      title: const Text('خصم مبالغ المصروفات من الصندوق'),
                      value: addExpenses,
                      onChanged: (v) =>
                          setState(() => addExpenses = v ?? addExpenses),
                    ),
                  ],
                ),
              ),
            ),
            // Balance Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: const Border(
                  top: BorderSide(color: AppColors.borderGray),
                ),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الرصيد',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '0.00',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.errorRed,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // يمكن لاحقاً استخدام isAddToCashBox لتحديد نوع الحركة
                        // true => إضافة للصندوق, false => خصم من الصندوق
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('خصم المبلغ من الصندوق'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// زر نمط (اختيار واحد من اثنين) لاضافة / خصم من الصندوق
Widget _buildModeButton({
  required bool isSelected,
  required String title,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return ElevatedButton.icon(
    onPressed: onTap,
    icon: Icon(
      icon,
      color: isSelected ? Colors.black : Colors.grey[700],
    ),
    label: Text(title),
    style: ElevatedButton.styleFrom(
      backgroundColor: isSelected ? AppColors.accentGreen : Colors.grey[300],
      foregroundColor: Colors.black,
      elevation: isSelected ? 2 : 0,
    ),
  );
}
