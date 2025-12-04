import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/header_bar.dart';
import '../../../../core/widgets/sidebar.dart';
import '../../../../core/widgets/menu_card.dart';
import '../../../sales/presentation/pages/sales_menu_page.dart';
import '../../../purchases/presentation/pages/purchases_menu_page.dart';
import '../../../customers/presentation/pages/customers_menu_page.dart';
import '../../../suppliers/presentation/pages/suppliers_menu_page.dart';
import '../../../inventory/presentation/pages/inventory_menu_page.dart';
import '../../../cash_box/presentation/pages/cash_box_menu_page.dart';
import '../../../expenses/presentation/pages/expenses_menu_page.dart';
import '../../../reports/presentation/pages/reports_menu_page.dart';
import '../../../settings/presentation/pages/settings_menu_page.dart';
import '../../../taxes/presentation/pages/taxes_page.dart';
import '../../../printer/presentation/pages/printer_settings_page.dart';
import '../../../operations/presentation/pages/operation_placeholder_page.dart';

/// Dashboard root page for the POS feature module.
///
/// This file lives under `features/dashboard/presentation` as part of a
/// Clean Architecture style structure:
/// - features/dashboard/domain      -> business rules (later)
/// - features/dashboard/data        -> data sources / repos (later)
/// - features/dashboard/presentation -> UI & state
class MainDashboardPage extends StatefulWidget {
  const MainDashboardPage({super.key});

  @override
  State<MainDashboardPage> createState() => _MainDashboardPageState();
}

class _MainDashboardPageState extends State<MainDashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentScreen = 'dashboard';
  String? operationTitle;

  final Map<String, String> operationTitles = {
    'edit_sales_invoice': 'تعديل فاتورة مبيعات',
    'edit_purchase_invoice': 'تعديل فاتورة مشتريات',
    'delete_invoice': 'إلغاء فاتورة مبيعات/مشتريات',
    'delete_cash_expense': 'إلغاء ملح -صندوق/مصروفات',
    'delete_check': 'إلغاء سند -قيض/صرف',
    'return_sales_invoice': 'إرجاع فاتورة مبيعات',
    'return_purchase_invoice': 'إرجاع فاتورة مشتريات',
    'delete_return_invoice': 'إلغاء فاتورة مرجع مبيعات/',
    'transfer_customers_suppliers': 'التحويل بين العملاء والموردين',
    'damaged_products': 'معالجة المنتجات الثالفة',
    'price_display': 'شاشة عرض الاسعار',
    'activate_program': 'تفعيل البرنامج',
    'backup': 'النسخ الاحتياطي',
    'data_backup': 'النسخ الاحتياطي للبيانات',
    'help': 'المساعدة',
    'update_program': 'تحديث البرنامج',
    'privacy_policy': 'Privacy Policy',
  };

  void _handleMenuClick(String menuId) {
    setState(() {
      if (menuId == 'sales') {
        // افتح شاشة المبيعات مباشرة
        currentScreen = 'sales';
      } else if (menuId == 'settings') {
        currentScreen = 'settings';
      } else if (menuId == 'taxes') {
        currentScreen = 'taxes';
      } else if (menuId == 'printer') {
        currentScreen = 'printer';
      } else if ([
        'customers',
        'suppliers',
        'inventory',
        'cash-box',
        'expenses',
        'reports',
        'purchases'
      ].contains(menuId)) {
        currentScreen = menuId;
      } else if (operationTitles.containsKey(menuId)) {
        operationTitle = operationTitles[menuId];
        currentScreen = 'operation';
      } else {
        // For drawer items that don't have dedicated screens yet, show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$menuId - قريبا', textAlign: TextAlign.right),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: HeaderBar(
          onMenuClick: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          onNotificationClick: () {
            _showNotificationDialog();
          },
        ),
        drawer: SidebarMenu(
          onMenuClick: _handleMenuClick,
        ),
        body: Stack(
          children: [
            _buildCurrentScreen(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (currentScreen) {
      case 'dashboard':
        return _buildDashboardGrid();
      case 'sales':
        return SalesMenuPage(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'purchases':
        return PurchasesMenuPage(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'customers':
        return CustomersMenuPage(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'suppliers':
        return SuppliersMenuPage(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'inventory':
        return InventoryMenuPage(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'cash-box':
        return CashBoxMenuPage(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'expenses':
        return ExpensesMenuPage(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'reports':
        return ReportsMenuPage(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'settings':
        return SettingsMenuPage(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'taxes':
        return TaxesPage(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'printer':
        return PrinterSettingsPage(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'operation':
        return OperationPlaceholderPage(
          title: operationTitle ?? 'العملية',
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      default:
        return _buildDashboardGrid();
    }
  }

  Widget _buildDashboardGrid() {
    final menuItems = [
      {
        'id': 'purchases',
        'label': 'المشتريات',
        'emoji': '📦',
        'gradient': AppColors.purchasesGradient
      },
      {
        'id': 'sales',
        'label': 'المبيعات',
        'emoji': '🛒',
        'gradient': AppColors.salesGradient
      },
      {
        'id': 'suppliers',
        'label': 'الموردين',
        'emoji': '🤝',
        'gradient': AppColors.suppliersGradient
      },
      {
        'id': 'customers',
        'label': 'العملاء',
        'emoji': '👤',
        'gradient': AppColors.customersGradient
      },
      {
        'id': 'expenses',
        'label': 'المصروفات',
        'emoji': '💼',
        'gradient': AppColors.expensesGradient
      },
      {
        'id': 'cash-box',
        'label': 'الصندوق',
        'emoji': '🔐',
        'gradient': AppColors.cashBoxGradient
      },
      {
        'id': 'reports',
        'label': 'التقارير',
        'emoji': '📊',
        'gradient': AppColors.reportsGradient
      },
      {
        'id': 'inventory',
        'label': 'المخزون',
        'emoji': '📦',
        'gradient': AppColors.inventoryGradient
      },
    ];

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return MenuCard(
                label: item['label'] as String,
                emoji: item['emoji'] as String,
                gradientColors: item['gradient'] as List<Color>,
                onTap: () => _handleMenuClick(item['id'] as String),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تنبيهات', textAlign: TextAlign.right),
        content:
            const Text('لا توجد تنبيهات حاليا', textAlign: TextAlign.right),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }
}
