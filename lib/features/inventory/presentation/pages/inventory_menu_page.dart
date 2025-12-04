import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class InventoryMenuPage extends StatefulWidget {
  final VoidCallback onBack;

  const InventoryMenuPage({super.key, required this.onBack});

  @override
  State<InventoryMenuPage> createState() => _InventoryMenuPageState();
}

class _InventoryMenuPageState extends State<InventoryMenuPage> {
  String currentView = 'menu';

  String get _title {
    switch (currentView) {
      case 'add_product':
        return 'إضافة منتج جديد';
      case 'products_list':
        return 'المنتجات المتوفرة في المخزن';
      case 'add_category':
        return 'إضافة تصنيف جديد';
      case 'edit_prices':
        return 'تعديل أسعار المنتجات';
      case 'import_excel':
        return 'استيراد بيانات المنتجات من ملف اكسل';
      default:
        return 'المخزون';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: currentView == 'menu'
                ? widget.onBack
                : () => setState(() => currentView = 'menu'),
          ),
          title: Text(_title),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('📦', style: TextStyle(fontSize: 32)),
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
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    switch (currentView) {
      case 'add_product':
        return _buildAddProductForm();
      case 'products_list':
        return _buildProductsList();
      case 'add_category':
        return _buildAddCategoryForm();
      case 'edit_prices':
        return _buildEditPrices();
      case 'import_excel':
        return _buildImportFromExcel();
      default:
        return _buildMenu();
    }
  }

  /// الشاشة الرئيسية للقائمة
  Widget _buildMenu() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        _menuItem('اضافة منتج جديد', Icons.add,
            () => setState(() => currentView = 'add_product')),
        _menuItem('عرض المنتجات', Icons.list_alt,
            () => setState(() => currentView = 'products_list')),
        _menuItem('اضافة تصنيف جديد', Icons.category,
            () => setState(() => currentView = 'add_category')),
        _menuItem('تعديل اسعار المنتجات', Icons.price_change,
            () => setState(() => currentView = 'edit_prices')),
        _menuItem(
          'استيراد بيانات المنتجات من ملف اكسل',
          Icons.upload_file,
          () => setState(() => currentView = 'import_excel'),
        ),
      ],
    );
  }

  /// شاشة إضافة منتج جديد (مطابقة للصورة قدر الإمكان)
  Widget _buildAddProductForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCard(
            child: const Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'رقم المنتج (Barcode)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'اسم المنتج',
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'الوصف',
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildCard(
            child: const Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'سعر البيع',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'سعر البيع 2',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'سعر البيع 3',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'سعر الشراء - التكلفة',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'الكمية',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText:
                        'حد الطلب (التنبيه عند وصول المنتج للكمية المحددة)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'تاريخ الانتهاء',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('الضريبة TAX'),
                const SizedBox(height: 8),
                _fakeDropdown(label: 'بدون'),
                const SizedBox(height: 12),
                const Text('التصنيف'),
                const SizedBox(height: 8),
                _fakeDropdown(label: '---'),
                const SizedBox(height: 12),
                const Text('الوحدة'),
                const SizedBox(height: 8),
                _fakeDropdown(label: '---', leading: Icons.add),
                const SizedBox(height: 12),
                const Text('علبة الوحدة'),
                const SizedBox(height: 8),
                const TextField(
                  decoration: InputDecoration(
                    labelText: '0',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                const Text('العبوة الأعلى'),
                const SizedBox(height: 8),
                _fakeDropdown(label: '---'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => setState(() => currentView = 'menu'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGreen,
              foregroundColor: AppColors.textPrimary,
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  /// شاشة عرض المنتجات
  Widget _buildProductsList() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(Icons.qr_code, size: 40),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'بحث',
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: AppColors.borderGray.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: const Row(
            children: [
              Expanded(child: Text('المنتج')),
              SizedBox(width: 8),
              SizedBox(
                  width: 60, child: Text('السعر', textAlign: TextAlign.center)),
              SizedBox(
                  width: 60,
                  child: Text('الكمية', textAlign: TextAlign.center)),
            ],
          ),
        ),
        const Expanded(
          child: Center(
            child: Text('لا توجد بيانات منتجات حالياً'),
          ),
        ),
        Container(
          color: Colors.yellow[600],
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child: const Text(
            'اضغط على المنتج لمزيد من الخيارات',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// شاشة إضافة تصنيف جديد
  Widget _buildAddCategoryForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: 'اسم التصنيف',
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => setState(() => currentView = 'menu'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              backgroundColor: AppColors.accentGreen,
            ),
            child: const Text('حفظ'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// شاشة تعديل أسعار المنتجات
  Widget _buildEditPrices() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCard(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('التأثير على الأسعار'),
                SizedBox(height: 8),
                RadioListTile(
                  value: true,
                  groupValue: true,
                  onChanged: null,
                  title: Text(
                    'بالزيادة',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                RadioListTile(
                  value: false,
                  groupValue: true,
                  onChanged: null,
                  title: Text(
                    'بالنقصان',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildCard(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('تعديل سعر'),
                SizedBox(height: 8),
                RadioListTile(
                  value: true,
                  groupValue: true,
                  onChanged: null,
                  title: Text('البيع'),
                ),
                RadioListTile(
                  value: false,
                  groupValue: true,
                  onChanged: null,
                  title: Text('الشراء'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildCard(
            child: const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('سعر بيع 1'),
                    Checkbox(value: true, onChanged: null),
                    Text('سعر بيع 2'),
                    Checkbox(value: true, onChanged: null),
                    Text('سعر بيع 3'),
                    Checkbox(value: true, onChanged: null),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('التعديل حسب التصنيف'),
                const SizedBox(height: 8),
                _fakeDropdown(label: 'الكل'),
                const SizedBox(height: 12),
                const Text('الطريقة'),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        value: 'amount',
                        groupValue: 'amount',
                        onChanged: null,
                        title: Text('مبلغ'),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        value: 'percent',
                        groupValue: 'amount',
                        onChanged: null,
                        title: Text('نسبة %'),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        value: 'fix',
                        groupValue: 'amount',
                        onChanged: null,
                        title: Text('سعر جديد'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'المبلغ',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () => setState(() => currentView = 'menu'),
              child: const Text('تعديل الأسعار'),
            ),
          ),
        ],
      ),
    );
  }

  /// شاشة استيراد من إكسل
  Widget _buildImportFromExcel() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ستمكنك هذه الشاشة من نقل بيانات المنتجات من ملف اكسل إلى قاعدة البيانات',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              hintText: 'ابحث عن الملف المراد معالجته',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'قبل البدء يجب اتباع التالي:\n'
            '1- يجب حفظ ملف الاكسل بالصيغة Excel 97-2003 Workbook (*.xls)\n'
            '2- يجب أن يكون شكل الملف مشابه للصورة الموضحة.',
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () => setState(() => currentView = 'menu'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentGreen,
                minimumSize: const Size(160, 48),
              ),
              child: const Text('استيراد'),
            ),
          ),
        ],
      ),
    );
  }

  /// عنصر موحد لبطاقات الأقسام
  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    );
  }

  /// Dropdown شكلي بدون منطق حقيقي (فقط للتصميم)
  Widget _fakeDropdown({required String label, IconData? leading}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderGray),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            Icon(leading, size: 20, color: AppColors.accentGreen),
            const SizedBox(width: 6),
          ],
          Expanded(child: Text(label)),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
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
