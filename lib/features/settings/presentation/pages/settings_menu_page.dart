import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class SettingsMenuPage extends StatefulWidget {
  final VoidCallback onBack;

  const SettingsMenuPage({super.key, required this.onBack});

  @override
  State<SettingsMenuPage> createState() => _SettingsMenuPageState();
}

class _SettingsMenuPageState extends State<SettingsMenuPage> {
  // البلاد واللغة
  String _selectedCountry = 'السعودية';
  String _selectedLanguage = 'العربية';

  // العملة
  final TextEditingController _currencyController =
      TextEditingController(text: 'ريال');
  final TextEditingController _currencyPartController =
      TextEditingController(text: 'فلس');
  int _currencyPartsCount = 2;

  // معلومات المتجر
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _storeAddressController = TextEditingController();
  final TextEditingController _storePhoneController = TextEditingController();

  // معلومات ضريبية
  final TextEditingController _taxNumberController = TextEditingController();
  final TextEditingController _crNumberController = TextEditingController();

  // شعار / ختم
  String _logoSize = 'صغير';

  // مفاتيح إعدادات مختلفة (عينات تماثل الصور)
  bool _enableLowStockWarning = true;
  bool _preventSaleWhenOutOfStock = false;
  bool _allowDuplicateItemInSale = false;
  bool _allowCreditSale = true;
  bool _showHelperMessages = true;
  bool _muteSounds = false;

  @override
  void dispose() {
    _currencyController.dispose();
    _currencyPartController.dispose();
    _storeNameController.dispose();
    _storeAddressController.dispose();
    _storePhoneController.dispose();
    _taxNumberController.dispose();
    _crNumberController.dispose();
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
          title: const Text('الإعدادات'),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.build),
            ),
          ],
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
                  _SettingsSection(
                    title: 'معلومات أساسية',
                    children: [
                      _buildDropdownRow(
                        label: 'الدولة',
                        value: _selectedCountry,
                        items: const [
                          'السعودية',
                          'اليمن',
                          'الكويت',
                          'الإمارات'
                        ],
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() => _selectedCountry = v);
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildDropdownRow(
                        label: 'اللغة',
                        value: _selectedLanguage,
                        items: const ['العربية', 'الإنجليزية'],
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() => _selectedLanguage = v);
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildTextRow('العملة', _currencyController),
                      const SizedBox(height: 8),
                      _buildTextRow('أجزاء العملة', _currencyPartController),
                      const SizedBox(height: 8),
                      _buildDropdownRow(
                        label: 'عدد الأجزاء',
                        value: '$_currencyPartsCount',
                        items: const ['1', '2', '3'],
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() => _currencyPartsCount = int.parse(v));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _SettingsSection(
                    title: 'بيانات المتجر',
                    children: [
                      _buildTextRow('اسم المتجر', _storeNameController),
                      const SizedBox(height: 8),
                      _buildTextRow('العنوان', _storeAddressController),
                      const SizedBox(height: 8),
                      _buildTextRow('رقم الهاتف', _storePhoneController,
                          keyboardType: TextInputType.phone),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _SettingsSection(
                    title: 'البيانات الضريبية',
                    children: [
                      _buildTextRow('الرقم الضريبي', _taxNumberController),
                      const SizedBox(height: 8),
                      _buildTextRow('رقم السجل التجاري', _crNumberController),
                      const SizedBox(height: 12),
                      _buildImageRow('صورة الشعار'),
                      const SizedBox(height: 8),
                      _buildDropdownRow(
                        label: 'حجم الشعار',
                        value: _logoSize,
                        items: const ['صغير', 'متوسط', 'كبير'],
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() => _logoSize = v);
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildImageRow('صورة الختم أو التوقيع'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _SettingsSection(
                    title: 'إعدادات المخزون',
                    children: [
                      _buildSwitchTile(
                        title: 'التحذير حال نقص المخزون',
                        value: _enableLowStockWarning,
                        onChanged: (v) =>
                            setState(() => _enableLowStockWarning = v),
                      ),
                      _buildSwitchTile(
                        title: 'منع البيع في حال نفاذ المخزون',
                        value: _preventSaleWhenOutOfStock,
                        onChanged: (v) =>
                            setState(() => _preventSaleWhenOutOfStock = v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _SettingsSection(
                    title: 'إعدادات المبيعات',
                    children: [
                      _buildSwitchTile(
                        title: 'السماح ببيع الآجل',
                        value: _allowCreditSale,
                        onChanged: (v) => setState(() => _allowCreditSale = v),
                      ),
                      _buildSwitchTile(
                        title: 'السماح بتكرار المنتج أثناء البيع',
                        value: _allowDuplicateItemInSale,
                        onChanged: (v) =>
                            setState(() => _allowDuplicateItemInSale = v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _SettingsSection(
                    title: 'عام',
                    children: [
                      _buildSwitchTile(
                        title: 'إظهار رسائل المساعدة',
                        value: _showHelperMessages,
                        onChanged: (v) =>
                            setState(() => _showHelperMessages = v),
                      ),
                      _buildSwitchTile(
                        title: 'إغلاق الأصوات',
                        value: _muteSounds,
                        onChanged: (v) => setState(() => _muteSounds = v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                        // TODO(ibrahim): ربط الحفظ بقاعدة البيانات / الإعدادات الحقيقية
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم حفظ الإعدادات')),
                        );
                      },
                      child: const Text(
                        'حفظ',
                        style: TextStyle(fontSize: 16, color: Colors.white),
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

  Widget _buildDropdownRow({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            initialValue: value,
            items: items
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            decoration: const InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildTextRow(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: const InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildImageRow(String label) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                  minimumSize: const Size(60, 40),
                ),
                onPressed: () {
                  // TODO: تنفيذ اختيار الصورة
                },
                child: const Text('تغيير'),
              ),
              const SizedBox(width: 8),
              Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                ),
                child: const Icon(Icons.image, size: 24),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}
