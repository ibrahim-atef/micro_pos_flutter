import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class PurchasesMenuPage extends StatefulWidget {
  final VoidCallback onBack;

  const PurchasesMenuPage({super.key, required this.onBack});

  @override
  State<PurchasesMenuPage> createState() => _PurchasesMenuPageState();
}

class _PurchasesMenuPageState extends State<PurchasesMenuPage> {
  DateTime _invoiceDate = DateTime.now();

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _invoiceDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.pink, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: AppColors.textPrimary, // body text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _invoiceDate) {
      setState(() {
        _invoiceDate = picked;
      });
    }
  }

  void _showBarcodeNotLinkedDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ماسح الباركود', textAlign: TextAlign.right),
        content: const Text(
          'هنا سيتم استخدام الكاميرا لمسح باركود المنتج للمشتريات.\n'
          'يمكن لاحقاً ربطه بنفس حزمة الماسح المستخدمة في المبيعات.',
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'هذا المنتج غير موجود في المخزن\nهل تريد إضافته؟',
          textAlign: TextAlign.right,
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              const Text('رقم المنتج (Barcode)', textAlign: TextAlign.right),
              const SizedBox(height: 4),
              TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.qr_code),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text('اسم المنتج', textAlign: TextAlign.right),
              const SizedBox(height: 4),
              const TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('الضريبة', textAlign: TextAlign.right),
                        const SizedBox(height: 4),
                        DropdownButtonFormField<String>(
                          items: const [
                            DropdownMenuItem(
                              value: 'none',
                              child: Text('---'),
                            ),
                          ],
                          onChanged: (_) {},
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('التصنيف', textAlign: TextAlign.right),
                        const SizedBox(height: 4),
                        DropdownButtonFormField<String>(
                          items: const [
                            DropdownMenuItem(
                              value: 'none',
                              child: Text('---'),
                            ),
                          ],
                          onChanged: (_) {},
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('عبوة الوحدة', textAlign: TextAlign.right),
                        SizedBox(height: 4),
                        TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('الوحدة', textAlign: TextAlign.right),
                        const SizedBox(height: 4),
                        DropdownButtonFormField<String>(
                          items: const [
                            DropdownMenuItem(
                              value: 'unit',
                              child: Text('الوحدة'),
                            ),
                          ],
                          onChanged: (_) {},
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text('العبوة الأعلى', textAlign: TextAlign.right),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem(
                    value: 'none',
                    child: Text('---'),
                  ),
                ],
                onChanged: (_) {},
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('تراجع'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showImportFromPurchaseOrderDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'استيراد البيانات من طلب شراء',
          textAlign: TextAlign.right,
        ),
        content: const TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: 'ادخل رقم طلب شراء',
            border: UnderlineInputBorder(),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('تراجع'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('متابعة'),
          ),
        ],
      ),
    );
  }

  void _showReprintInvoiceDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'إعادة طباعة فاتورة',
          textAlign: TextAlign.right,
        ),
        content: const TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: 'ادخل رقم الفاتورة',
            border: UnderlineInputBorder(),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('تراجع'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('متابعة'),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String value) {
    switch (value) {
      case 'add_product':
        _showAddProductDialog();
        break;
      case 'reprint_invoice':
        _showReprintInvoiceDialog();
        break;
      case 'edit_invoice':
        // يمكن لاحقاً ربط شاشة تعديل فاتورة المشتريات
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تعديل فاتورة مشتريات - قريباً')),
        );
        break;
      case 'import_po':
        _showImportFromPurchaseOrderDialog();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String invoiceDateText =
        '${_invoiceDate.year.toString().padLeft(4, '0')}-'
        '${_invoiceDate.month.toString().padLeft(2, '0')}-'
        '${_invoiceDate.day.toString().padLeft(2, '0')}';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: widget.onBack,
          ),
          title: const Text('المشتريات'),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu),
              onSelected: _handleMenuAction,
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'add_product',
                  child: Text('اضافة منتج جديد'),
                ),
                PopupMenuItem(
                  value: 'reprint_invoice',
                  child: Text('اعاده طباعه الفاتورة'),
                ),
                PopupMenuItem(
                  value: 'edit_invoice',
                  child: Text('تعديل فاتورة مشتريات'),
                ),
                PopupMenuItem(
                  value: 'import_po',
                  child: Text('استيراد البيانات من طلب شراء'),
                ),
              ],
            ),
          ],
          backgroundColor: Colors.white,
          foregroundColor: AppColors.textPrimary,
          elevation: 1,
        ),
        body: Column(
          children: [
            // صف تاريخ الفاتورة
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _selectDate,
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          invoiceDateText,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'تاريخ الفاتورة',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            // صف البحث عن منتج + حفظ + باركود
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  // زر الحفظ
                  Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: const Icon(
                      Icons.save,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // حقل البحث
                  const Expanded(
                    child: TextField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: 'ابحث عن منتج أو استخدم الكامير',
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pinkAccent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // زر الباركود
                  InkWell(
                    onTap: _showBarcodeNotLinkedDialog,
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: const Icon(
                        Icons.qr_code_scanner,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // عناوين جدول المنتجات
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: Colors.grey.shade200,
              child: const Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'المنتج',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'التكلفة',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'الكمية',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'الإجمالي',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            // مساحة جدول المنتجات (فارغة حالياً)
            Expanded(
              child: Container(
                color: Colors.white,
              ),
            ),
          ],
        ),
        // شريط الإجمالي أسفل الشاشة
        bottomNavigationBar: Container(
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              // نصوص الإجمالي في اليمين
              const Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'الإجمالي',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'ريال ع.ق',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
              // الإجمالي الرئيسي (خلفية خضراء)
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.accentGreen,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '0.00',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              // الصندوق الصغير في اليسار
              Expanded(
                flex: 3,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '0.0',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.apps,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
