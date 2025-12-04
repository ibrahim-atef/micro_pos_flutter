import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// أنواع الشاشات داخل صفحة الموردين
enum SuppliersView {
  menu,
  addSupplier,
  suppliersList,
  remainingAmounts,
  openingBalances,
}

class SuppliersMenuPage extends StatefulWidget {
  final VoidCallback onBack;

  const SuppliersMenuPage({super.key, required this.onBack});

  @override
  State<SuppliersMenuPage> createState() => _SuppliersMenuState();
}

class _SuppliersMenuState extends State<SuppliersMenuPage> {
  SuppliersView currentView = SuppliersView.menu;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: currentView == SuppliersView.menu
                ? widget.onBack
                : () => setState(() => currentView = SuppliersView.menu),
          ),
          title: Text(_getTitleForView(currentView)),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('🤝', style: TextStyle(fontSize: 32)),
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
        body: _buildBodyForView(),
      ),
    );
  }

  String _getTitleForView(SuppliersView view) {
    switch (view) {
      case SuppliersView.addSupplier:
        return 'الموردين - إضافة مورد';
      case SuppliersView.suppliersList:
        return 'عرض الموردين';
      case SuppliersView.remainingAmounts:
        return 'المبالغ المتبقية للموردين';
      case SuppliersView.openingBalances:
        return 'الأرصدة الافتتاحية والمبالغ النقدية للموردين';
      case SuppliersView.menu:
        return 'الموردين';
    }
  }

  Widget _buildBodyForView() {
    switch (currentView) {
      case SuppliersView.addSupplier:
        return _buildAddSupplierForm();
      case SuppliersView.suppliersList:
        return _buildSuppliersList();
      case SuppliersView.remainingAmounts:
        return _buildRemainingAmounts();
      case SuppliersView.openingBalances:
        return _buildOpeningBalances();
      case SuppliersView.menu:
        return _buildMenu();
    }
  }

  /// القائمة الرئيسية كما في التطبيق القديم
  Widget _buildMenu() {
    return ListView(
      children: [
        _menuItem(
          'اضافة مورد جديد',
          Icons.add,
          () => setState(() => currentView = SuppliersView.addSupplier),
        ),
        _menuItem(
          'الأرصدة الافتتاحية والمبالغ النقدية للموردين',
          Icons.account_balance_wallet,
          () => setState(() => currentView = SuppliersView.openingBalances),
        ),
        _menuItem(
          'المبالغ المتبقية للموردين',
          Icons.attach_money,
          () => setState(() => currentView = SuppliersView.remainingAmounts),
        ),
        _menuItem(
          'عرض الموردين',
          Icons.search,
          () => setState(() => currentView = SuppliersView.suppliersList),
        ),
      ],
    );
  }

  /// نموذج إضافة / تعديل المورد (مشابه للصورة الثالثة)
  Widget _buildAddSupplierForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          const _LinedTextField(label: 'رقم المورد'),
          const SizedBox(height: 12),
          const _LinedTextField(label: 'اسم المورد'),
          const SizedBox(height: 12),
          const _LinedTextField(label: 'العنوان', maxLines: 2),
          const SizedBox(height: 12),
          const _LinedTextField(
            label: 'رقم الهاتف',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          const _LinedTextField(
            label: 'الرقم الضريبي للمورد',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          const _LinedTextField(
            label: 'رقم السجل التجاري',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          const _LinedTextField(label: 'ملاحظات', maxLines: 3),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () => setState(() => currentView = SuppliersView.menu),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentGreen,
                foregroundColor: AppColors.textPrimary,
              ),
              icon: const Icon(Icons.save),
              label: const Text('حفظ'),
            ),
          ),
        ],
      ),
    );
  }

  /// شاشة "عرض الموردين"
  Widget _buildSuppliersList() {
    return Column(
      children: [
        _buildTopSearchAndReportRow(
          searchHint: 'بحث باسم المورد',
          onReportPressed: () {
            // يمكن ربطه بتقارير لاحقاً
          },
        ),
        const Divider(height: 1),
        // رأس الجدول
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.grey.shade200,
          child: const Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'بيانات المورد',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'رقم الهاتف',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // بيانات افتراضية
        Expanded(
          child: ListView.separated(
            itemCount: 5,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    const Expanded(child: Text('مورد تجريبي')),
                    Expanded(
                      child: Text(
                        '05000000$index',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// شاشة "المبالغ المتبقية للموردين"
  Widget _buildRemainingAmounts() {
    return Column(
      children: [
        _buildTopSearchAndReportRow(
          searchHint: 'بحث باسم المورد',
          onReportPressed: () {
            // يمكن ربطه بتقارير لاحقاً
          },
        ),
        const Divider(height: 1),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.grey.shade200,
          child: const Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'بيانات المورد',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'المبلغ الباقي',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.separated(
            itemCount: 5,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    const Expanded(child: Text('مورد تجريبي')),
                    Expanded(
                      child: Text(
                        '1,000.${index}0',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// شاشة "الأرصدة الافتتاحية والمبالغ النقدية للموردين"
  Widget _buildOpeningBalances() {
    return Column(
      children: [
        _buildTopSearchAndReportRow(
          searchHint: 'بحث',
          keyboardType: TextInputType.number,
          onReportPressed: _showReportOptionsDialog,
        ),
        const Divider(height: 1),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.grey.shade200,
          child: const Row(
            children: [
              Expanded(
                child: Text(
                  'عليه',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'له',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'بيانات المورد',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.separated(
            itemCount: 5,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '0.00',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '0.00',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('مورد تجريبي'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// الصف العلوي: زر تقرير + حقل البحث كما في الصور
  Widget _buildTopSearchAndReportRow({
    required String searchHint,
    TextInputType? keyboardType,
    required VoidCallback onReportPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: onReportPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.black87,
                elevation: 0,
              ),
              child: const Text('تقرير'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                hintText: searchHint,
                filled: true,
                fillColor: Colors.grey.shade100,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide:
                      const BorderSide(color: AppColors.primaryPurpleDark),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// حوار اختيار التقرير / إعادة طباعة السندات
  Future<void> _showReportOptionsDialog() async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _dialogOption(
                'تقرير',
                onTap: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 8),
              _dialogOption(
                'اعاده طباعه سند الصرف',
                onTap: () {
                  Navigator.of(context).pop();
                  _showReprintVoucherDialog(
                    title: 'اعاده طباعه سند الصرف',
                    label: 'ادخل رقم سند الصرف',
                  );
                },
              ),
              const SizedBox(height: 8),
              _dialogOption(
                'اعاده طباعه سند القبض',
                onTap: () {
                  Navigator.of(context).pop();
                  _showReprintVoucherDialog(
                    title: 'اعاده طباعه سند القبض',
                    label: 'ادخل رقم سند القبض',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _dialogOption(String title, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  /// حوار إدخال رقم السند كما في أول صورتين
  Future<void> _showReprintVoucherDialog({
    required String title,
    required String label,
  }) async {
    final controller = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: label,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'تراجع',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // هنا يمكن تنفيذ منطق الطباعة لاحقاً
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'متابعة',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _menuItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.borderGray),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.accentGreen, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// حقل نصي يشبه حقول التطبيق القديم (إطار أزرق خفيف وزوايا مستديرة)
class _LinedTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final TextInputType? keyboardType;

  const _LinedTextField({
    required this.label,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label),
        const SizedBox(height: 4),
        TextField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFB0C4DE), // لون أزرق فاتح مشابه للصورة
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primaryPurpleDark,
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
