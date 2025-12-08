import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SidebarMenu extends StatelessWidget {
  final Function(String) onMenuClick;

  const SidebarMenu({
    super.key,
    required this.onMenuClick,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 50,
            ),
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.borderGray),
                ),
              ),
              child: const Text(
                'سهل بضاعه',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            // Menu Sections
            _buildMenuSection(
              'معالجات متقدمة',
              [
                _MenuItem(
                    'تعديل فاتورة مبيعات', Icons.receipt, 'edit_sales_invoice'),
                _MenuItem('تعديل فاتورة مشتريات', Icons.receipt,
                    'edit_purchase_invoice'),
                _MenuItem('إلغاء فاتورة مبيعات/مشتريات', Icons.close,
                    'delete_invoice',
                    color: AppColors.errorRed),
                _MenuItem('إلغاء ملح -صندوق/مصروفات', Icons.close,
                    'delete_cash_expense',
                    color: AppColors.errorRed),
                _MenuItem('إلغاء سند -قيض/صرف', Icons.close, 'delete_check',
                    color: AppColors.errorRed),
                _MenuItem('إرجاع فاتورة مبيعات', Icons.refresh,
                    'return_sales_invoice'),
                _MenuItem('إرجاع فاتورة مشتريات', Icons.refresh,
                    'return_purchase_invoice'),
                _MenuItem('إلغاء فاتورة مرجع مبيعات/', Icons.close,
                    'delete_return_invoice',
                    color: AppColors.errorRed),
                _MenuItem('التحويل بين العملاء والموردين', Icons.swap_horiz,
                    'transfer_customers_suppliers'),
                _MenuItem('معالجة المنتجات الثالفة', Icons.inventory,
                    'damaged_products'),
              ],
            ),

            _buildMenuSection(
              'العمليات',
              [
                _MenuItem(
                    'شاشة عرض الاسعار', Icons.attach_money, 'price_display'),
              ],
            ),

            _buildMenuSection(
              'اعدادات النظام',
              [
                _MenuItem('الاعدادات', Icons.settings, 'settings'),
                _MenuItem('الضرائب', Icons.description, 'taxes'),
                _MenuItem('الطابعه', Icons.print, 'printer'),
                // _MenuItem('تفعيل البرنامج', Icons.lock, 'activate_program'),
              ],
            ),

            // _buildMenuSection(
            //   'النسخ الاحتياطي والمساعدة',
            //   [
            //     _MenuItem('النسخ الاحتياطي', Icons.backup, 'backup'),
            //     _MenuItem('النسخ الاحتياطي للبيانات', Icons.cloud_upload,
            //         'data_backup'),
            //     _MenuItem('المساعدة', Icons.help, 'help'),
            //     _MenuItem(
            //         'تحديث البرنامج', Icons.system_update, 'update_program'),
            //     _MenuItem(
            //         'Privacy Policy', Icons.privacy_tip, 'privacy_policy'),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...items.map((item) => _buildMenuItem(item)),
      ],
    );
  }

  Widget _buildMenuItem(_MenuItem item) {
    return InkWell(
      onTap: () => onMenuClick(item.actionId),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Icon(
              item.icon,
              size: 20,
              color: item.color ?? AppColors.textSecondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.label,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_left,
              size: 16,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final String label;
  final IconData icon;
  final String actionId;
  final Color? color;

  _MenuItem(this.label, this.icon, this.actionId, {this.color});
}
