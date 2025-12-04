import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import 'invoice_labels_page.dart';

/// شاشة إعدادات الطابعة كما في الصور، مع زر يفتح شاشة تعديل مسميات الفاتورة.
class PrinterSettingsPage extends StatefulWidget {
  final VoidCallback onBack;

  const PrinterSettingsPage({super.key, required this.onBack});

  @override
  State<PrinterSettingsPage> createState() => _PrinterSettingsPageState();
}

class _PrinterSettingsPageState extends State<PrinterSettingsPage> {
  String _printerType = 'pdf';
  String _paperSize = '58';
  int _copies = 1;

  // سويتشات أسفل الصفحة
  bool _showCustomerAddress = false;
  bool _showPreviousBalance = true;
  bool _printProductNameAlone = false;
  bool _showExpiryOnA4 = false;
  bool _showProductCodeOnA4 = false;
  bool _showProductDescription = false;
  bool _forceA4OnSend = false;
  bool _printAfterSave = false;
  bool _showQrTax = false;
  bool _showProductImage = false;

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
          title: const Text('إعدادات الطابعه'),
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
                  _buildLabeledTextField(
                    label: 'نص اسفل فاتورة البيع',
                    hint: 'نص اسفل فاتورة البيع',
                  ),
                  const SizedBox(height: 8),
                  _buildLabeledTextField(
                    label: 'نص اسفل التقارير قياس A4',
                    hint: 'نص اسفل التقارير قياس A4',
                  ),
                  const SizedBox(height: 8),
                  _buildLabeledNumberField(
                    label: 'موقع النص الارتفاع',
                    initialValue: '10',
                  ),
                  const SizedBox(height: 12),
                  _buildPrinterTypeSection(),
                  const SizedBox(height: 12),
                  _buildLabeledTextField(
                    label: 'عنوان الطابعه',
                    hint: 'عنوان الطابعه',
                    hasLeadingSearch: true,
                  ),
                  const SizedBox(height: 12),
                  _buildPaperSizeSection(),
                  const SizedBox(height: 12),
                  _buildDropdownRow(
                    label: 'عدد نسخ الفاتورة',
                    value: _copies.toString(),
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => _copies = int.parse(v));
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildDropdownRow(
                    label: 'موديل الطابعه الحراريه',
                    value: '1',
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 8),
                  _buildDropdownRow(
                    label: 'موديل طابعة الباركود',
                    value: '1',
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 12),
                  _buildLabeledNumberField(
                    label: 'حجم الخط',
                    initialValue: '20',
                  ),
                  const SizedBox(height: 8),
                  _buildLabeledNumberField(
                    label: 'الهامش الايمن',
                    initialValue: '0',
                  ),
                  const SizedBox(height: 8),
                  _buildLabeledNumberField(
                    label: 'الهامش الاسفل',
                    initialValue: '0',
                  ),
                  const SizedBox(height: 12),
                  _buildSwitchesSection(),
                  const SizedBox(height: 12),
                  // صف "تعديل مسميات الفاتورة" مع زر تعديل
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    const InvoiceLabelsPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.black,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24),
                          ),
                          child: const Text('تعديل'),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'تعديل مسميات الفاتورة',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPurple,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم حفظ إعدادات الطابعه'),
                          ),
                        );
                      },
                      child: const Text('حفظ'),
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

  Widget _buildLabeledTextField({
    required String label,
    required String hint,
    bool hasLeadingSearch = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              prefixIcon:
                  hasLeadingSearch ? const Icon(Icons.search) : null,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 180,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blueGrey.shade200, width: 2),
            ),
            child: Text(
              label,
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabeledNumberField({
    required String label,
    required String initialValue,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: TextField(
            controller: TextEditingController(text: initialValue),
            keyboardType:
                const TextInputType.numberWithOptions(decimal: false),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildPrinterTypeSection() {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('نوع الطابعه'),
            RadioListTile<String>(
              value: 'pdf',
              groupValue: _printerType,
              onChanged: (v) =>
                  setState(() => _printerType = v ?? 'pdf'),
              title: const Text('PDF   A4'),
            ),
            RadioListTile<String>(
              value: 'bluetooth',
              groupValue: _printerType,
              onChanged: (v) =>
                  setState(() => _printerType = v ?? 'bluetooth'),
              title: const Text('Bluetooth   58/80mm'),
            ),
            RadioListTile<String>(
              value: 'wifi',
              groupValue: _printerType,
              onChanged: (v) =>
                  setState(() => _printerType = v ?? 'wifi'),
              title: const Text('WIFI   58/80mm'),
            ),
            RadioListTile<String>(
              value: 'usb',
              groupValue: _printerType,
              onChanged: (v) =>
                  setState(() => _printerType = v ?? 'usb'),
              title: const Text('USB   58/80mm'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaperSizeSection() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            value: '80',
            groupValue: _paperSize,
            onChanged: (v) =>
                setState(() => _paperSize = v ?? '80'),
            title: const Text('80mm'),
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            value: '58',
            groupValue: _paperSize,
            onChanged: (v) =>
                setState(() => _paperSize = v ?? '58'),
            title: const Text('58mm'),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownRow({
    required String label,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: DropdownButtonFormField<String>(
            value: value,
            items: const [
              DropdownMenuItem(value: '0', child: Text('0')),
              DropdownMenuItem(value: '1', child: Text('1')),
              DropdownMenuItem(value: '2', child: Text('2')),
            ],
            onChanged: onChanged,
            decoration: const InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchesSection() {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          SwitchListTile.adaptive(
            value: _showCustomerAddress,
            onChanged: (v) =>
                setState(() => _showCustomerAddress = v),
            title: const Text(
              'اظهار عنوان العميل ورقم تلفونه في الفاتورة',
            ),
          ),
          SwitchListTile.adaptive(
            value: _showPreviousBalance,
            onChanged: (v) =>
                setState(() => _showPreviousBalance = v),
            title: const Text(
              'اظهار مديونيه العميل السابقه في الفاتورة',
            ),
          ),
          SwitchListTile.adaptive(
            value: _printProductNameAlone,
            onChanged: (v) =>
                setState(() => _printProductNameAlone = v),
            title: const Text(
              'طباعه اسم المنتج في صف مستقل',
            ),
          ),
          SwitchListTile.adaptive(
            value: _showExpiryOnA4,
            onChanged: (v) =>
                setState(() => _showExpiryOnA4 = v),
            title: const Text(
              'عرض تاريخ الانتهاء في فاتورة المبيعات A4',
            ),
          ),
          SwitchListTile.adaptive(
            value: _showProductCodeOnA4,
            onChanged: (v) =>
                setState(() => _showProductCodeOnA4 = v),
            title: const Text(
              'عرض رقم المنتج في فاتورة المبيعات A4',
            ),
          ),
          SwitchListTile.adaptive(
            value: _showProductDescription,
            onChanged: (v) =>
                setState(() => _showProductDescription = v),
            title: const Text(
              'اظهار وصف المنتج في الفاتورة',
            ),
          ),
          SwitchListTile.adaptive(
            value: _forceA4OnSend,
            onChanged: (v) =>
                setState(() => _forceA4OnSend = v),
            title: const Text(
              'اختيار قياس A4 عند ارسال فاتورة البيع',
            ),
          ),
          SwitchListTile.adaptive(
            value: _printAfterSave,
            onChanged: (v) =>
                setState(() => _printAfterSave = v),
            title: const Text(
              'طباعة الفاتورة مباشرة بعد الحفظ',
            ),
          ),
          SwitchListTile.adaptive(
            value: _showQrTax,
            onChanged: (v) => setState(() => _showQrTax = v),
            title: const Text(
              'اظهار QR الضريبه في فاتورة البيع',
            ),
          ),
          SwitchListTile.adaptive(
            value: _showProductImage,
            onChanged: (v) =>
                setState(() => _showProductImage = v),
            title: const Text(
              'اظهار صورة المنتج في فاتورة البيع',
            ),
          ),
        ],
      ),
    );
  }
}

