import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ExpensesMenuPage extends StatefulWidget {
  final VoidCallback onBack;

  const ExpensesMenuPage({super.key, required this.onBack});

  @override
  State<ExpensesMenuPage> createState() => _ExpensesMenuPageState();
}

class _ExpensesMenuPageState extends State<ExpensesMenuPage> {
  String account = '';
  String statement = '';
  String amount = '0';
  String paymentMethod = 'cash';
  String date = DateTime.now().toString().split(' ')[0];

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
          title: const Text('المصروفات'),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('💰', style: TextStyle(fontSize: 32)),
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'لحساب'),
                      onChanged: (v) => account = v,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(labelText: 'البيان'),
                      onChanged: (v) => statement = v,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(labelText: 'ادخل الملبغ'),
                      keyboardType: TextInputType.number,
                      onChanged: (v) => amount = v,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'طريقة الدفع',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    RadioListTile(
                      title: const Text('من الصندوق'),
                      value: 'cash',
                      groupValue: paymentMethod,
                      onChanged: (v) =>
                          setState(() => paymentMethod = v ?? paymentMethod),
                    ),
                    RadioListTile(
                      title: const Text('بطاقه'),
                      value: 'card',
                      groupValue: paymentMethod,
                      onChanged: (v) =>
                          setState(() => paymentMethod = v ?? paymentMethod),
                    ),
                    RadioListTile(
                      title: const Text('شيك'),
                      value: 'check',
                      groupValue: paymentMethod,
                      onChanged: (v) =>
                          setState(() => paymentMethod = v ?? paymentMethod),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(labelText: 'التاريخ'),
                      onChanged: (v) => date = v,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: const Border(
                  top: BorderSide(color: AppColors.borderGray),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('حفظ'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


