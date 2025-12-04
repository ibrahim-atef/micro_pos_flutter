import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ReportsMenuPage extends StatefulWidget {
  final VoidCallback onBack;

  const ReportsMenuPage({super.key, required this.onBack});

  @override
  State<ReportsMenuPage> createState() => _ReportsMenuPageState();
}

class _ReportsMenuPageState extends State<ReportsMenuPage> {
  String dateFrom = '2025/11/29';
  String dateTo = '2025/11/29';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: widget.onBack,
          ),
          title: const Text('الاستعلامات'),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('📊', style: TextStyle(fontSize: 32)),
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
            // Date Range Selector
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.save),
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 120,
                        child: TextField(
                          controller: TextEditingController(text: dateTo),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(isDense: true),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('الي'),
                      ),
                      SizedBox(
                        width: 120,
                        child: TextField(
                          controller: TextEditingController(text: dateFrom),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(isDense: true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'للفترة من',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            // Reports List
            Expanded(
              child: ListView(
                children: [
                  _buildSection('العملاء', [
                    'دمج العملاء',
                    'كشف حساب عميل',
                    'تقرير مصادقة حساب العميل',
                    'تقرير بحركه الرصيد الافتتاحي والنقد للعميل',
                    'تقرير بالفواتير لعميل',
                    'تقرير بسندات القبض لعميل',
                  ]),
                  _buildSection('المتجر', [
                    'عرض حركه المتجر',
                    'عرض حركه المتجر - رسم بياني',
                  ]),
                  _buildSection('المبيعات', [
                    'تقرير بالمبيعات',
                    'تقارير الارباح',
                    'عرض فواتير المبيعات',
                    'تقرير بالخصومات',
                    'تقرير بالفواتير الآجل',
                  ]),
                  _buildSection('المشتريات', [
                    'تقرير بالمشتريات',
                    'عرض فواتير المشتريات',
                    'تقرير بالفواتير المرتجع-مشتريات',
                  ]),
                  _buildSection('الموردين', [
                    'تقرير بالمتبقي للموردين',
                    'كشف حساب مورد',
                    'تقرير بحركه الرصيد الافتتاحي والنقد للمورد',
                  ]),
                  _buildSection('المخازن', [
                    'جرد مخزني',
                    'جرد مخزني حسب التصنيف',
                    'تقرير بحركه منتج',
                    'تقرير بالمنتجات التالفة',
                  ]),
                  _buildSection('الصندوق', [
                    'تقرير بحركة الصندوق',
                    'تقرير رأس المال',
                    'حساب الزكاة',
                    'تقرير بالاقرار الضريبي',
                  ]),
                  _buildSection('المصروفات', [
                    'تقرير بصنيف المصروفات',
                    'تقرير بطلبات الشراء',
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> reports) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.errorRed,
            ),
          ),
        ),
        ...reports.map(
          (report) => Container(
            color: Colors.white,
            child: ListTile(
              title: Text(
                report,
                textAlign: TextAlign.right,
              ),
              trailing: const Icon(Icons.chevron_left, size: 20),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}


