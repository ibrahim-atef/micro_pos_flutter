import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// أنواع الشاشات داخل صفحة العملاء
enum CustomersView {
  menu,
  addCustomer,
  customersList,
  remainingAmounts,
  openingBalances,
}

class CustomersMenuPage extends StatefulWidget {
  final VoidCallback onBack;

  const CustomersMenuPage({super.key, required this.onBack});

  @override
  State<CustomersMenuPage> createState() => _CustomersMenuPageState();
}

class _CustomersMenuPageState extends State<CustomersMenuPage> {
  CustomersView currentView = CustomersView.menu;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: currentView == CustomersView.menu
                ? widget.onBack
                : () => setState(() => currentView = CustomersView.menu),
          ),
          title: Text(_getTitleForView(currentView)),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('👨‍💼', style: TextStyle(fontSize: 32)),
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

  String _getTitleForView(CustomersView view) {
    switch (view) {
      case CustomersView.addCustomer:
        return 'العملاء - إضافة عميل';
      case CustomersView.customersList:
        return 'عرض العملاء';
      case CustomersView.remainingAmounts:
        return 'المبالغ المتبقية للعملاء';
      case CustomersView.openingBalances:
        return 'الأرصدة الافتتاحية والمبالغ النقدية للعملاء';
      case CustomersView.menu:
        return 'العملاء';
    }
  }

  Widget _buildBodyForView() {
    switch (currentView) {
      case CustomersView.addCustomer:
        return _buildAddCustomerForm();
      case CustomersView.customersList:
        return _buildCustomersList();
      case CustomersView.remainingAmounts:
        return _buildRemainingAmounts();
      case CustomersView.openingBalances:
        return _buildOpeningBalances();
      case CustomersView.menu:
        return _buildMenu();
    }
  }

  /// القائمة الرئيسية كما في التطبيق القديم
  Widget _buildMenu() {
    return ListView(
      children: [
        _menuItem(
          'اضافة عميل جديد',
          Icons.add,
          () => setState(() => currentView = CustomersView.addCustomer),
        ),
        _menuItem(
          'الأرصدة الافتتاحية والمبالغ النقدية للعملاء',
          Icons.account_balance_wallet,
          () => setState(() => currentView = CustomersView.openingBalances),
        ),
        _menuItem(
          'المبالغ المتبقية للعملاء من الفواتير الآجل',
          Icons.attach_money,
          () => setState(() => currentView = CustomersView.remainingAmounts),
        ),
        _menuItem(
          'عرض العملاء',
          Icons.search,
          () => setState(() => currentView = CustomersView.customersList),
        ),
      ],
    );
  }

  /// نموذج إضافة / تعديل العميل (مشابه للصورة الخاصة ببيانات العميل)
  Widget _buildAddCustomerForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          const _LinedTextField(label: 'رقم العميل'),
          const SizedBox(height: 12),
          const _LinedTextField(label: 'اسم العميل'),
          const SizedBox(height: 12),
          const _LinedTextField(label: 'العنوان', maxLines: 2),
          const SizedBox(height: 12),
          const _LinedTextField(
            label: 'رقم الهاتف',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          const _LinedTextField(
            label: 'الحد الأقصى للعميل من الفواتير الآجل',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          const _LinedTextField(
            label: 'اكتب عدد الأيام',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          const _LinedTextField(label: 'ملاحظات', maxLines: 3),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () => setState(() => currentView = CustomersView.menu),
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

  /// شاشة "عرض العملاء"
  Widget _buildCustomersList() {
    return Column(
      children: [
        _buildTopSearchAndReportRow(
          searchHint: 'بحث باسم العميل',
          onReportPressed: _showReportOptionsDialog,
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
                  'بيانات العميل',
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
                    const Expanded(child: Text('عميل تجريبي')),
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

  /// شاشة "المبالغ المتبقية للعملاء"
  Widget _buildRemainingAmounts() {
    return Column(
      children: [
        _buildTopSearchAndReportRow(
          searchHint: 'بحث باسم العميل',
          onReportPressed: () {},
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
                  'بيانات العميل',
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
                    const Expanded(child: Text('عميل تجريبي')),
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

  /// شاشة "الأرصدة الافتتاحية والمبالغ النقدية للعملاء"
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
                  'بيانات العميل',
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
                      child: Text('عميل تجريبي'),
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

  /// حوار إدخال رقم السند كما في الصور
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
                  border: const UnderlineInputBorder(),
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
                color: Color(0xFFB0C4DE),
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
