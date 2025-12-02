import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/header_bar.dart';
import '../widgets/sidebar.dart';
import '../widgets/menu_card.dart';
import 'sales_menu.dart';
import 'purchases_menu.dart';
import 'customers_menu.dart';
import 'suppliers_menu.dart';
import 'inventory_menu.dart';
import 'cash_box_menu.dart';
import 'expenses_menu.dart';
import 'reports_menu.dart';
import 'settings_menu.dart';
import 'operation_placeholder.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentScreen = 'dashboard';
  bool showRegisterModal = false;
  int? selectedRegister;
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
    'taxes': 'الضرائب',
    'printer': 'الطابعه',
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
        showRegisterModal = true;
      } else if (menuId == 'settings') {
        currentScreen = 'settings';
      } else if (['customers', 'suppliers', 'inventory', 'cash-box', 'expenses', 'reports', 'purchases'].contains(menuId)) {
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

  void _handleRegisterSelect(int registerNum) {
    setState(() {
      selectedRegister = registerNum;
      showRegisterModal = false;
      currentScreen = 'sales';
    });
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
            if (showRegisterModal) _buildRegisterModal(),
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
        return SalesMenu(
          onBack: () => setState(() => currentScreen = 'dashboard'),
          registerNum: selectedRegister,
        );
      case 'purchases':
        return PurchasesMenu(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'customers':
        return CustomersMenu(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'suppliers':
        return SuppliersMenu(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'inventory':
        return InventoryMenu(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'cash-box':
        return CashBoxMenu(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'expenses':
        return ExpensesMenu(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'reports':
        return ReportsMenu(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'settings':
        return SettingsMenu(
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      case 'operation':
        return OperationPlaceholder(
          title: operationTitle ?? 'العملية',
          onBack: () => setState(() => currentScreen = 'dashboard'),
        );
      default:
        return _buildDashboardGrid();
    }
  }

  Widget _buildDashboardGrid() {
    final menuItems = [
      {'id': 'purchases', 'label': 'المشتريات', 'emoji': '📦', 'gradient': AppColors.purchasesGradient},
      {'id': 'sales', 'label': 'المبيعات', 'emoji': '🛒', 'gradient': AppColors.salesGradient},
      {'id': 'suppliers', 'label': 'الموردين', 'emoji': '🤝', 'gradient': AppColors.suppliersGradient},
      {'id': 'customers', 'label': 'العملاء', 'emoji': '👤', 'gradient': AppColors.customersGradient},
      {'id': 'expenses', 'label': 'المصروفات', 'emoji': '💼', 'gradient': AppColors.expensesGradient},
      {'id': 'cash-box', 'label': 'الصندوق', 'emoji': '🔐', 'gradient': AppColors.cashBoxGradient},
      {'id': 'reports', 'label': 'التقارير', 'emoji': '📊', 'gradient': AppColors.reportsGradient},
      {'id': 'inventory', 'label': 'المخزون', 'emoji': '📦', 'gradient': AppColors.inventoryGradient},
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
        Positioned(
          bottom: 16,
          left: 16,
          child: FloatingActionButton(
            onPressed: () => _showNotificationDialog(),
            backgroundColor: AppColors.primaryPurple,
            child: const Icon(Icons.settings, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterModal() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'فتح شاشه بيع رقم',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ...List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    onPressed: () => _handleRegisterSelect(index + 1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentGreen,
                      foregroundColor: AppColors.textPrimary,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: Text('شاشه بيع رقم ${index + 1}'),
                  ),
                );
              }),
              ElevatedButton(
                onPressed: () => _handleRegisterSelect(0),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentGreen,
                  foregroundColor: AppColors.textPrimary,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('عرض سعر'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => setState(() => showRegisterModal = false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('تصفيه جميع الشاشات'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تنبيهات', textAlign: TextAlign.right),
        content: const Text('لا توجد تنبيهات حاليا', textAlign: TextAlign.right),
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
