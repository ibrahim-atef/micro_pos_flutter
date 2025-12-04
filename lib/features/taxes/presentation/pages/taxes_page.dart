import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class TaxesPage extends StatefulWidget {
  final VoidCallback onBack;

  const TaxesPage({super.key, required this.onBack});

  @override
  State<TaxesPage> createState() => _TaxesPageState();
}

class _TaxesPageState extends State<TaxesPage> {
  final List<_TaxRowData> _taxes = List.generate(
    5,
    (index) => _TaxRowData(
      nameController: TextEditingController(text: 'ضريبة ${index + 1}'),
      shortNameController: TextEditingController(text: 'TAX${index + 1}'),
      percentController: TextEditingController(text: '5'),
      enabled: true,
    ),
  );

  bool _isPriceIncludesTax = false;
  bool _calculateTaxAfterDiscount = true;

  @override
  void dispose() {
    for (final tax in _taxes) {
      tax.nameController.dispose();
      tax.shortNameController.dispose();
      tax.percentController.dispose();
    }
    super.dispose();
  }

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
          title: const Text('الضرائب TAX'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryPurple, AppColors.primaryPurpleDark],
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.grey.shade200,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...List.generate(_taxes.length, (index) {
                    final tax = _taxes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildTaxRow(index + 1, tax),
                    );
                  }),
                  const SizedBox(height: 8),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Switch.adaptive(
                                value: _isPriceIncludesTax,
                                onChanged: (v) =>
                                    setState(() => _isPriceIncludesTax = v),
                              ),
                              const Expanded(
                                child: Text(
                                  'قيمة المنتج شامل الضريبة',
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Switch.adaptive(
                                activeColor: Colors.pinkAccent,
                                value: _calculateTaxAfterDiscount,
                                onChanged: (v) => setState(
                                  () => _calculateTaxAfterDiscount = v,
                                ),
                              ),
                              const Expanded(
                                child: Text(
                                  'احتساب الضريبة من اجمالي صافي الفاتورة بعد الخصم',
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPurple,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        // TODO: ربط الحفظ بقاعدة البيانات أو الإعدادات الفعلية
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم حفظ إعدادات الضرائب'),
                          ),
                        );
                      },
                      child: const Text(
                        'حفظ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaxRow(int index, _TaxRowData tax) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ضريبة $index',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // delete icon
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      tax.enabled = false;
                    });
                  },
                ),
                // enable icon
                IconButton(
                  icon: Icon(
                    Icons.check_circle,
                    color:
                        tax.enabled ? Colors.green : Colors.grey.shade400,
                  ),
                  onPressed: () {
                    setState(() {
                      tax.enabled = !tax.enabled;
                    });
                  },
                ),
                const SizedBox(width: 4),
                // percentage
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: tax.percentController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: '%',
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                // short name
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: tax.shortNameController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'الاختصار',
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                // tax name
                Expanded(
                  child: TextField(
                    controller: tax.nameController,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      labelText: 'اسم الضريبة',
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TaxRowData {
  final TextEditingController nameController;
  final TextEditingController shortNameController;
  final TextEditingController percentController;
  bool enabled;

  _TaxRowData({
    required this.nameController,
    required this.shortNameController,
    required this.percentController,
    this.enabled = true,
  });
}


