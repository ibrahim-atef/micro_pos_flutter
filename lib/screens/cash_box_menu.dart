import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CashBoxMenu extends StatefulWidget {
  final VoidCallback onBack;

  const CashBoxMenu({Key? key, required this.onBack}) : super(key: key);

  @override
  State<CashBoxMenu> createState() => _CashBoxMenuState();
}

class _CashBoxMenuState extends State<CashBoxMenu> {
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
          leading: IconButton(icon: const Icon(Icons.chevron_left), onPressed: widget.onBack),
          title: const Text('الصندوق'),
          actions: const [Padding(padding: EdgeInsets.all(8), child: Text('💼', style: TextStyle(fontSize: 32)))],
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.primaryPurple, AppColors.primaryPurpleDark])),
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
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('اضافه للصندوق'),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.accentGreen, foregroundColor: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.remove),
                      label: const Text('خصم من الصندوق'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], foregroundColor: Colors.black),
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
                    TextField(decoration: const InputDecoration(labelText: 'ادخل الملبغ'), onChanged: (v) => amount = v),
                    const SizedBox(height: 12),
                    TextField(decoration: const InputDecoration(labelText: 'التاريخ'), onChanged: (v) => date = v),
                    const SizedBox(height: 12),
                    TextField(decoration: const InputDecoration(labelText: 'البيان'), onChanged: (v) => statement = v),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title: const Text('اضافة مبالغ المبيعات والعملاء للصندوق'),
                      value: addSales,
                      onChanged: (v) => setState(() => addSales = v!),
                    ),
                    CheckboxListTile(
                      title: const Text('خصم مبالغ المشتريات والموردين من الصندوق'),
                      value: addPurchases,
                      onChanged: (v) => setState(() => addPurchases = v!),
                    ),
                    CheckboxListTile(
                      title: const Text('خصم مبالغ المصروفات من الصندوق'),
                      value: addExpenses,
                      onChanged: (v) => setState(() => addExpenses = v!),
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
                border: const Border(top: BorderSide(color: AppColors.borderGray)),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('الرصيد', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('0.00', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.errorRed)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[400], foregroundColor: Colors.black),
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
