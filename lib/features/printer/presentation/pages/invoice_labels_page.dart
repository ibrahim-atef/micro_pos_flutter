import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// شاشة تعديل مسميات الفاتورة (الصفحة الفرعية التي تفتح من إعدادات الطابعة).
class InvoiceLabelsPage extends StatelessWidget {
  const InvoiceLabelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final labels = <String>[
      'فاتورة مبيعات',
      'فاتورة مرتجع مبيعات',
      'عرض سعر',
      'النوع :',
      'الرقم :',
      'التاريخ :',
      'الوقت :',
      'اسم العميل',
      'رقم الهاتف',
      'عنوان العميل',
      'المنتج',
      'الكمية',
      'السعر',
      'الإجمالي',
      'إجمالي ف.',
      'الضريبة TAX',
      'الخصم',
      'صافي الفاتورة',
      'المدفوع',
      'الباقي',
      'الرصيد السابق',
      'الرصيد الحالي',
      'نقداً',
      'آجل',
      'بطاقه',
      'شيك',
      'لكم',
      'عليكم',
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('تعديل مسميات الفاتورة'),
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
            child: Column(
              children: [
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'الغير مطلوب تعديله اتركه فارغ',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Column(
                      children: [
                        for (final label in labels) ...[
                          _InvoiceLabelRow(label: label),
                          const SizedBox(height: 8),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('تراجع'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryPurple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تم حفظ مسميات الفاتورة'),
                              ),
                            );
                          },
                          child: const Text('حفظ'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InvoiceLabelRow extends StatelessWidget {
  final String label;

  const _InvoiceLabelRow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // حقل التعديل على اليسار (إطار أزرق مستدير)
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueGrey.shade200, width: 2),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: const TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // التسمية الأصلية على اليمين
        SizedBox(
          width: 140,
          child: Text(
            label,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
