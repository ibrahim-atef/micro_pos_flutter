import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class SalesMenuPage extends StatefulWidget {
  final VoidCallback onBack;

  const SalesMenuPage({
    super.key,
    required this.onBack,
  });

  @override
  State<SalesMenuPage> createState() => _SalesMenuPageState();
}

class _SalesMenuPageState extends State<SalesMenuPage> {
  bool _showCustomerSearch = false;

  void _toggleCustomerSearch() {
    setState(() {
      _showCustomerSearch = !_showCustomerSearch;
    });
  }

  Future<void> _openBarcodeScanner() async {
    // هنا يمكنك لاحقاً ربط حزمة ماسح الباركود (مثل mobile_scanner أو qr_code_scanner)
    // حالياً نعرض حوار توضيحي فقط
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ماسح الباركود', textAlign: TextAlign.right),
        content: const Text(
          'هنا سيتم فتح الكاميرا لقراءة الباركود.\n'
          'يمكن لاحقاً ربط حزمة ماسح الباركود الحقيقية.',
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.onBack,
          ),
          centerTitle: true,
          title: const Text('المبيعات'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 8),
            // صف البحث (حاسب + حقل البحث + الايقونات)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  // حقل البحث عن منتج
                  const Expanded(
                    child: TextField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: 'ابحث عن منتج أو استخدم الباركود',
                        hintStyle: TextStyle(fontSize: 14),
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
                  // زر العميل
                  _SquareIconButton(
                    icon: Icons.person,
                    background: Colors.orangeAccent,
                    onTap: _toggleCustomerSearch,
                  ),
                  const SizedBox(width: 4),
                  // زر الباركود
                  _SquareIconButton(
                    icon: Icons.qr_code_scanner,
                    background: Colors.black87,
                    iconColor: Colors.white,
                    onTap: _openBarcodeScanner,
                  ),
                ],
              ),
            ),
            // حقل البحث عن العميل أسفل زر الشخص
            if (_showCustomerSearch)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                child: TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن عميل أو اكتب اسم',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    border: OutlineInputBorder(),
                  ),
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
                      'السعر',
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
            // مساحة جدول المنتجات (حالياً فارغة)
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
                        'TA+ ضريبة',
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

class _SquareIconButton extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color iconColor;
  final VoidCallback? onTap;

  const _SquareIconButton({
    required this.icon,
    required this.background,
    this.iconColor = Colors.black,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 22,
        ),
      ),
    );
  }
}
