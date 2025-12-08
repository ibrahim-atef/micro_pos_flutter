# API Endpoints Documentation - MicroPOS Flutter Application

## Base URL
```
BASE_URL = "https://api.micropos.com/api/v1"
```

## Authentication
جميع الـ endpoints تحتاج إلى Bearer Token في Header:
```
Authorization: Bearer {token}
```

---

## 1. Dashboard - لوحة التحكم

### 1.1 الحصول على إحصائيات لوحة التحكم
```
GET /dashboard/statistics
```

**Response:**
```json
{
  "total_sales_today": 0.00,
  "total_purchases_today": 0.00,
  "total_expenses_today": 0.00,
  "cash_box_balance": 0.00,
  "low_stock_products_count": 0,
  "pending_invoices_count": 0,
  "total_customers": 0,
  "total_suppliers": 0
}
```

---

## 2. Sales - المبيعات

### 2.1 البحث عن منتج للبيع
```
GET /sales/products/search?q={search_term}&barcode={barcode}
```

**Parameters:**
- `q` (optional): نص البحث
- `barcode` (optional): رقم الباركود

**Response:**
```json
{
  "products": [
    {
      "id": 1,
      "name": "اسم المنتج",
      "barcode": "123456789",
      "price": 100.00,
      "price2": 90.00,
      "price3": 80.00,
      "quantity": 50,
      "tax_id": 1,
      "tax_name": "TAX1",
      "tax_percent": 5.0
    }
  ]
}
```

### 2.2 البحث عن عميل
```
GET /sales/customers/search?q={search_term}
```

**Response:**
```json
{
  "customers": [
    {
      "id": 1,
      "name": "اسم العميل",
      "phone": "0500000000",
      "address": "العنوان",
      "balance": 0.00,
      "credit_limit": 5000.00
    }
  ]
}
```

### 2.3 إنشاء فاتورة مبيعات
```
POST /sales/invoices
```

**Request Body:**
```json
{
  "customer_id": 1,
  "date": "2025-12-04",
  "register_id": 1,
  "items": [
    {
      "product_id": 1,
      "quantity": 2,
      "price": 100.00,
      "discount": 0.00,
      "tax_id": 1
    }
  ],
  "total": 200.00,
  "tax": 10.00,
  "discount": 0.00,
  "net_total": 210.00,
  "paid": 210.00,
  "remaining": 0.00,
  "payment_method": "cash"
}
```

**Response:**
```json
{
  "invoice_id": 1,
  "invoice_number": "S-2025-001",
  "status": "success"
}
```

### 2.4 الحصول على فاتورة مبيعات
```
GET /sales/invoices/{invoice_id}
```

### 2.5 تحديث فاتورة مبيعات
```
PUT /sales/invoices/{invoice_id}
```

### 2.6 حذف فاتورة مبيعات
```
DELETE /sales/invoices/{invoice_id}
```

### 2.7 إعادة طباعة فاتورة مبيعات
```
GET /sales/invoices/{invoice_id}/print
```

### 2.8 إرجاع فاتورة مبيعات
```
POST /sales/invoices/{invoice_id}/return
```

**Request Body:**
```json
{
  "items": [
    {
      "invoice_item_id": 1,
      "quantity": 1
    }
  ],
  "reason": "سبب الإرجاع"
}
```

---

## 3. Purchases - المشتريات

### 3.1 البحث عن منتج للشراء
```
GET /purchases/products/search?q={search_term}&barcode={barcode}
```

### 3.2 البحث عن مورد
```
GET /purchases/suppliers/search?q={search_term}
```

### 3.3 إنشاء فاتورة مشتريات
```
POST /purchases/invoices
```

**Request Body:**
```json
{
  "supplier_id": 1,
  "date": "2025-12-04",
  "items": [
    {
      "product_id": 1,
      "quantity": 10,
      "cost": 50.00,
      "tax_id": 1
    }
  ],
  "total": 500.00,
  "tax": 25.00,
  "discount": 0.00,
  "net_total": 525.00
}
```

### 3.4 الحصول على فاتورة مشتريات
```
GET /purchases/invoices/{invoice_id}
```

### 3.5 تحديث فاتورة مشتريات
```
PUT /purchases/invoices/{invoice_id}
```

### 3.6 حذف فاتورة مشتريات
```
DELETE /purchases/invoices/{invoice_id}
```

### 3.7 إعادة طباعة فاتورة مشتريات
```
GET /purchases/invoices/{invoice_id}/print
```

### 3.8 إرجاع فاتورة مشتريات
```
POST /purchases/invoices/{invoice_id}/return
```

### 3.9 استيراد من طلب شراء
```
GET /purchases/purchase-orders/{order_id}
```

---

## 4. Customers - العملاء

### 4.1 الحصول على قائمة العملاء
```
GET /customers?page=1&limit=20&search={search_term}
```

**Response:**
```json
{
  "customers": [
    {
      "id": 1,
      "customer_number": "C-001",
      "name": "اسم العميل",
      "phone": "0500000000",
      "address": "العنوان",
      "credit_limit": 5000.00,
      "credit_days": 30,
      "notes": "ملاحظات",
      "balance": 0.00,
      "created_at": "2025-12-04T10:00:00Z"
    }
  ],
  "total": 1,
  "page": 1,
  "limit": 20
}
```

### 4.2 الحصول على عميل محدد
```
GET /customers/{customer_id}
```

### 4.3 إنشاء عميل جديد
```
POST /customers
```

**Request Body:**
```json
{
  "customer_number": "C-001",
  "name": "اسم العميل",
  "phone": "0500000000",
  "address": "العنوان",
  "credit_limit": 5000.00,
  "credit_days": 30,
  "notes": "ملاحظات"
}
```

### 4.4 تحديث عميل
```
PUT /customers/{customer_id}
```

### 4.5 حذف عميل
```
DELETE /customers/{customer_id}
```

### 4.6 الحصول على المبالغ المتبقية للعملاء
```
GET /customers/remaining-amounts?search={search_term}
```

**Response:**
```json
{
  "customers": [
    {
      "id": 1,
      "name": "اسم العميل",
      "remaining_amount": 1000.00
    }
  ]
}
```

### 4.7 الحصول على الأرصدة الافتتاحية للعملاء
```
GET /customers/opening-balances?search={search_term}
```

**Response:**
```json
{
  "customers": [
    {
      "id": 1,
      "name": "اسم العميل",
      "debit": 0.00,
      "credit": 0.00
    }
  ]
}
```

### 4.8 كشف حساب عميل
```
GET /customers/{customer_id}/statement?from_date={date}&to_date={date}
```

### 4.9 إنشاء سند قبض
```
POST /customers/{customer_id}/receipt-vouchers
```

**Request Body:**
```json
{
  "amount": 500.00,
  "date": "2025-12-04",
  "notes": "ملاحظات"
}
```

### 4.10 إنشاء سند صرف
```
POST /customers/{customer_id}/payment-vouchers
```

**Request Body:**
```json
{
  "amount": 500.00,
  "date": "2025-12-04",
  "notes": "ملاحظات"
}
```

### 4.11 إعادة طباعة سند القبض/الصرف
```
GET /customers/vouchers/{voucher_id}/print
```

---

## 5. Suppliers - الموردين

### 5.1 الحصول على قائمة الموردين
```
GET /suppliers?page=1&limit=20&search={search_term}
```

**Response:**
```json
{
  "suppliers": [
    {
      "id": 1,
      "supplier_number": "S-001",
      "name": "اسم المورد",
      "phone": "0500000000",
      "address": "العنوان",
      "tax_number": "123456789",
      "cr_number": "987654321",
      "notes": "ملاحظات",
      "balance": 0.00,
      "created_at": "2025-12-04T10:00:00Z"
    }
  ],
  "total": 1,
  "page": 1,
  "limit": 20
}
```

### 5.2 الحصول على مورد محدد
```
GET /suppliers/{supplier_id}
```

### 5.3 إنشاء مورد جديد
```
POST /suppliers
```

**Request Body:**
```json
{
  "supplier_number": "S-001",
  "name": "اسم المورد",
  "phone": "0500000000",
  "address": "العنوان",
  "tax_number": "123456789",
  "cr_number": "987654321",
  "notes": "ملاحظات"
}
```

### 5.4 تحديث مورد
```
PUT /suppliers/{supplier_id}
```

### 5.5 حذف مورد
```
DELETE /suppliers/{supplier_id}
```

### 5.6 الحصول على المبالغ المتبقية للموردين
```
GET /suppliers/remaining-amounts?search={search_term}
```

### 5.7 الحصول على الأرصدة الافتتاحية للموردين
```
GET /suppliers/opening-balances?search={search_term}
```

### 5.8 كشف حساب مورد
```
GET /suppliers/{supplier_id}/statement?from_date={date}&to_date={date}
```

### 5.9 إنشاء سند قبض/صرف للمورد
```
POST /suppliers/{supplier_id}/vouchers
```

---

## 6. Inventory - المخزون

### 6.1 الحصول على قائمة المنتجات
```
GET /inventory/products?page=1&limit=20&search={search_term}&category_id={id}
```

**Response:**
```json
{
  "products": [
    {
      "id": 1,
      "barcode": "123456789",
      "name": "اسم المنتج",
      "description": "الوصف",
      "category_id": 1,
      "category_name": "التصنيف",
      "unit_id": 1,
      "unit_name": "الوحدة",
      "quantity": 50,
      "reorder_level": 10,
      "expiry_date": "2025-12-31",
      "price": 100.00,
      "price2": 90.00,
      "price3": 80.00,
      "cost": 50.00,
      "tax_id": 1,
      "tax_name": "TAX1",
      "created_at": "2025-12-04T10:00:00Z"
    }
  ],
  "total": 1,
  "page": 1,
  "limit": 20
}
```

### 6.2 الحصول على منتج محدد
```
GET /inventory/products/{product_id}
```

### 6.3 إنشاء منتج جديد
```
POST /inventory/products
```

**Request Body:**
```json
{
  "barcode": "123456789",
  "name": "اسم المنتج",
  "description": "الوصف",
  "category_id": 1,
  "unit_id": 1,
  "quantity": 50,
  "reorder_level": 10,
  "expiry_date": "2025-12-31",
  "price": 100.00,
  "price2": 90.00,
  "price3": 80.00,
  "cost": 50.00,
  "tax_id": 1
}
```

### 6.4 تحديث منتج
```
PUT /inventory/products/{product_id}
```

### 6.5 حذف منتج
```
DELETE /inventory/products/{product_id}
```

### 6.6 الحصول على التصنيفات
```
GET /inventory/categories
```

**Response:**
```json
{
  "categories": [
    {
      "id": 1,
      "name": "اسم التصنيف",
      "created_at": "2025-12-04T10:00:00Z"
    }
  ]
}
```

### 6.7 إنشاء تصنيف جديد
```
POST /inventory/categories
```

**Request Body:**
```json
{
  "name": "اسم التصنيف"
}
```

### 6.8 تحديث تصنيف
```
PUT /inventory/categories/{category_id}
```

### 6.9 حذف تصنيف
```
DELETE /inventory/categories/{category_id}
```

### 6.10 الحصول على الوحدات
```
GET /inventory/units
```

### 6.11 تعديل أسعار المنتجات
```
POST /inventory/products/bulk-update-prices
```

**Request Body:**
```json
{
  "category_id": null,
  "price_type": "sale",
  "price_fields": ["price", "price2", "price3"],
  "change_type": "increase",
  "change_method": "percent",
  "change_value": 10.0
}
```

### 6.12 استيراد المنتجات من Excel
```
POST /inventory/products/import-excel
```

**Request:**
- Content-Type: multipart/form-data
- File: excel_file

---

## 7. Cash Box - الصندوق

### 7.1 الحصول على رصيد الصندوق
```
GET /cash-box/balance
```

**Response:**
```json
{
  "balance": 5000.00,
  "last_transaction_date": "2025-12-04T10:00:00Z"
}
```

### 7.2 إضافة مبلغ للصندوق
```
POST /cash-box/transactions
```

**Request Body:**
```json
{
  "type": "deposit",
  "amount": 1000.00,
  "date": "2025-12-04",
  "statement": "إضافة رأس مال",
  "add_sales": true,
  "add_purchases": true,
  "add_expenses": false
}
```

### 7.3 سحب مبلغ من الصندوق
```
POST /cash-box/transactions
```

**Request Body:**
```json
{
  "type": "withdraw",
  "amount": 500.00,
  "date": "2025-12-04",
  "statement": "سحب من الصندوق"
}
```

### 7.4 الحصول على حركات الصندوق
```
GET /cash-box/transactions?from_date={date}&to_date={date}&page=1&limit=20
```

**Response:**
```json
{
  "transactions": [
    {
      "id": 1,
      "type": "deposit",
      "amount": 1000.00,
      "date": "2025-12-04",
      "statement": "إضافة رأس مال",
      "balance_after": 5000.00,
      "created_at": "2025-12-04T10:00:00Z"
    }
  ],
  "total": 1,
  "page": 1,
  "limit": 20
}
```

### 7.5 حذف حركة صندوق
```
DELETE /cash-box/transactions/{transaction_id}
```

---

## 8. Expenses - المصروفات

### 8.1 الحصول على قائمة المصروفات
```
GET /expenses?from_date={date}&to_date={date}&page=1&limit=20
```

**Response:**
```json
{
  "expenses": [
    {
      "id": 1,
      "account": "مصروفات عامة",
      "statement": "شراء مستلزمات",
      "amount": 200.00,
      "payment_method": "cash",
      "date": "2025-12-04",
      "created_at": "2025-12-04T10:00:00Z"
    }
  ],
  "total": 1,
  "page": 1,
  "limit": 20
}
```

### 8.2 إنشاء مصروف جديد
```
POST /expenses
```

**Request Body:**
```json
{
  "account": "مصروفات عامة",
  "statement": "شراء مستلزمات",
  "amount": 200.00,
  "payment_method": "cash",
  "date": "2025-12-04"
}
```

**Payment Methods:** `cash`, `card`, `check`

### 8.3 تحديث مصروف
```
PUT /expenses/{expense_id}
```

### 8.4 حذف مصروف
```
DELETE /expenses/{expense_id}
```

### 8.5 الحصول على حسابات المصروفات
```
GET /expenses/accounts
```

---

## 9. Reports - التقارير

### 9.1 تقارير العملاء

#### 9.1.1 دمج العملاء
```
GET /reports/customers/merge
```

#### 9.1.2 كشف حساب عميل
```
GET /reports/customers/{customer_id}/statement?from_date={date}&to_date={date}
```

#### 9.1.3 تقرير مصادقة حساب العميل
```
GET /reports/customers/{customer_id}/verification?from_date={date}&to_date={date}
```

#### 9.1.4 تقرير بحركة الرصيد الافتتاحي والنقد للعميل
```
GET /reports/customers/{customer_id}/opening-balance-movement?from_date={date}&to_date={date}
```

#### 9.1.5 تقرير بالفواتير لعميل
```
GET /reports/customers/{customer_id}/invoices?from_date={date}&to_date={date}
```

#### 9.1.6 تقرير بسندات القبض لعميل
```
GET /reports/customers/{customer_id}/receipt-vouchers?from_date={date}&to_date={date}
```

### 9.2 تقارير المتجر

#### 9.2.1 عرض حركة المتجر
```
GET /reports/store/movement?from_date={date}&to_date={date}
```

#### 9.2.2 عرض حركة المتجر - رسم بياني
```
GET /reports/store/movement/chart?from_date={date}&to_date={date}
```

### 9.3 تقارير المبيعات

#### 9.3.1 تقرير بالمبيعات
```
GET /reports/sales?from_date={date}&to_date={date}
```

#### 9.3.2 تقارير الأرباح
```
GET /reports/sales/profits?from_date={date}&to_date={date}
```

#### 9.3.3 عرض فواتير المبيعات
```
GET /reports/sales/invoices?from_date={date}&to_date={date}&page=1&limit=20
```

#### 9.3.4 تقرير بالخصومات
```
GET /reports/sales/discounts?from_date={date}&to_date={date}
```

#### 9.3.5 تقرير بالفواتير الآجل
```
GET /reports/sales/credit-invoices?from_date={date}&to_date={date}
```

### 9.4 تقارير المشتريات

#### 9.4.1 تقرير بالمشتريات
```
GET /reports/purchases?from_date={date}&to_date={date}
```

#### 9.4.2 عرض فواتير المشتريات
```
GET /reports/purchases/invoices?from_date={date}&to_date={date}&page=1&limit=20
```

#### 9.4.3 تقرير بالفواتير المرتجع - مشتريات
```
GET /reports/purchases/return-invoices?from_date={date}&to_date={date}
```

### 9.5 تقارير الموردين

#### 9.5.1 تقرير بالمتبقي للموردين
```
GET /reports/suppliers/remaining?from_date={date}&to_date={date}
```

#### 9.5.2 كشف حساب مورد
```
GET /reports/suppliers/{supplier_id}/statement?from_date={date}&to_date={date}
```

#### 9.5.3 تقرير بحركة الرصيد الافتتاحي والنقد للمورد
```
GET /reports/suppliers/{supplier_id}/opening-balance-movement?from_date={date}&to_date={date}
```

### 9.6 تقارير المخازن

#### 9.6.1 جرد مخزني
```
GET /reports/inventory/stock?date={date}
```

#### 9.6.2 جرد مخزني حسب التصنيف
```
GET /reports/inventory/stock-by-category?date={date}&category_id={id}
```

#### 9.6.3 تقرير بحركة منتج
```
GET /reports/inventory/products/{product_id}/movement?from_date={date}&to_date={date}
```

#### 9.6.4 تقرير بالمنتجات التالفة
```
GET /reports/inventory/damaged-products?from_date={date}&to_date={date}
```

### 9.7 تقارير الصندوق

#### 9.7.1 تقرير بحركة الصندوق
```
GET /reports/cash-box/movement?from_date={date}&to_date={date}
```

#### 9.7.2 تقرير رأس المال
```
GET /reports/cash-box/capital?from_date={date}&to_date={date}
```

#### 9.7.3 حساب الزكاة
```
GET /reports/cash-box/zakat?from_date={date}&to_date={date}
```

#### 9.7.4 تقرير بالإقرار الضريبي
```
GET /reports/cash-box/tax-declaration?from_date={date}&to_date={date}
```

### 9.8 تقارير المصروفات

#### 9.8.1 تقرير بصنيف المصروفات
```
GET /reports/expenses/by-category?from_date={date}&to_date={date}
```

#### 9.8.2 تقرير بطلبات الشراء
```
GET /reports/expenses/purchase-orders?from_date={date}&to_date={date}
```

---

## 10. Settings - الإعدادات

### 10.1 الحصول على الإعدادات
```
GET /settings
```

**Response:**
```json
{
  "country": "السعودية",
  "language": "العربية",
  "currency": "ريال",
  "currency_part": "فلس",
  "currency_parts_count": 2,
  "store_name": "اسم المتجر",
  "store_address": "عنوان المتجر",
  "store_phone": "0500000000",
  "tax_number": "123456789",
  "cr_number": "987654321",
  "logo_url": "https://...",
  "logo_size": "صغير",
  "stamp_url": "https://...",
  "enable_low_stock_warning": true,
  "prevent_sale_when_out_of_stock": false,
  "allow_duplicate_item_in_sale": false,
  "allow_credit_sale": true,
  "show_helper_messages": true,
  "mute_sounds": false
}
```

### 10.2 تحديث الإعدادات
```
PUT /settings
```

**Request Body:**
```json
{
  "country": "السعودية",
  "language": "العربية",
  "currency": "ريال",
  "currency_part": "فلس",
  "currency_parts_count": 2,
  "store_name": "اسم المتجر",
  "store_address": "عنوان المتجر",
  "store_phone": "0500000000",
  "tax_number": "123456789",
  "cr_number": "987654321",
  "logo_size": "صغير",
  "enable_low_stock_warning": true,
  "prevent_sale_when_out_of_stock": false,
  "allow_duplicate_item_in_sale": false,
  "allow_credit_sale": true,
  "show_helper_messages": true,
  "mute_sounds": false
}
```

### 10.3 رفع شعار المتجر
```
POST /settings/upload-logo
```

**Request:**
- Content-Type: multipart/form-data
- File: logo_file

### 10.4 رفع ختم/توقيع
```
POST /settings/upload-stamp
```

**Request:**
- Content-Type: multipart/form-data
- File: stamp_file

---

## 11. Taxes - الضرائب

### 11.1 الحصول على قائمة الضرائب
```
GET /taxes
```

**Response:**
```json
{
  "taxes": [
    {
      "id": 1,
      "name": "ضريبة القيمة المضافة",
      "short_name": "TAX1",
      "percent": 5.0,
      "enabled": true,
      "created_at": "2025-12-04T10:00:00Z"
    }
  ]
}
```

### 11.2 إنشاء ضريبة جديدة
```
POST /taxes
```

**Request Body:**
```json
{
  "name": "ضريبة القيمة المضافة",
  "short_name": "TAX1",
  "percent": 5.0,
  "enabled": true
}
```

### 11.3 تحديث ضريبة
```
PUT /taxes/{tax_id}
```

### 11.4 حذف ضريبة
```
DELETE /taxes/{tax_id}
```

### 11.5 الحصول على إعدادات الضرائب
```
GET /taxes/settings
```

**Response:**
```json
{
  "price_includes_tax": false,
  "calculate_tax_after_discount": true
}
```

### 11.6 تحديث إعدادات الضرائب
```
PUT /taxes/settings
```

**Request Body:**
```json
{
  "price_includes_tax": false,
  "calculate_tax_after_discount": true
}
```

---

## 12. Printer - إعدادات الطابعة

### 12.1 الحصول على إعدادات الطابعة
```
GET /printer/settings
```

**Response:**
```json
{
  "invoice_bottom_text": "نص اسفل فاتورة البيع",
  "report_bottom_text": "نص اسفل التقارير قياس A4",
  "text_position_height": 10,
  "printer_type": "pdf",
  "printer_address": "عنوان الطابعة",
  "paper_size": "58",
  "copies_count": 1,
  "thermal_printer_model": "1",
  "barcode_printer_model": "1",
  "font_size": 20,
  "right_margin": 0,
  "bottom_margin": 0,
  "show_customer_address": false,
  "show_previous_balance": true,
  "print_product_name_alone": false,
  "show_expiry_on_a4": false,
  "show_product_code_on_a4": false,
  "show_product_description": false,
  "force_a4_on_send": false,
  "print_after_save": false,
  "show_qr_tax": false,
  "show_product_image": false
}
```

### 12.2 تحديث إعدادات الطابعة
```
PUT /printer/settings
```

**Request Body:**
```json
{
  "invoice_bottom_text": "نص اسفل فاتورة البيع",
  "report_bottom_text": "نص اسفل التقارير قياس A4",
  "text_position_height": 10,
  "printer_type": "pdf",
  "printer_address": "عنوان الطابعة",
  "paper_size": "58",
  "copies_count": 1,
  "thermal_printer_model": "1",
  "barcode_printer_model": "1",
  "font_size": 20,
  "right_margin": 0,
  "bottom_margin": 0,
  "show_customer_address": false,
  "show_previous_balance": true,
  "print_product_name_alone": false,
  "show_expiry_on_a4": false,
  "show_product_code_on_a4": false,
  "show_product_description": false,
  "force_a4_on_send": false,
  "print_after_save": false,
  "show_qr_tax": false,
  "show_product_image": false
}
```

### 12.3 الحصول على مسميات الفاتورة
```
GET /printer/invoice-labels
```

**Response:**
```json
{
  "labels": {
    "sales_invoice": "فاتورة مبيعات",
    "sales_return_invoice": "فاتورة مرتجع مبيعات",
    "price_display": "عرض سعر",
    "type": "النوع :",
    "number": "الرقم :",
    "date": "التاريخ :",
    "time": "الوقت :",
    "customer_name": "اسم العميل",
    "customer_phone": "رقم الهاتف",
    "customer_address": "عنوان العميل",
    "product": "المنتج",
    "quantity": "الكمية",
    "price": "السعر",
    "total": "الإجمالي",
    "total_before_tax": "إجمالي ف.",
    "tax": "الضريبة TAX",
    "discount": "الخصم",
    "net_total": "صافي الفاتورة",
    "paid": "المدفوع",
    "remaining": "الباقي",
    "previous_balance": "الرصيد السابق",
    "current_balance": "الرصيد الحالي",
    "cash": "نقداً",
    "credit": "آجل",
    "card": "بطاقه",
    "check": "شيك",
    "debit": "لكم",
    "credit_label": "عليكم"
  }
}
```

### 12.4 تحديث مسميات الفاتورة
```
PUT /printer/invoice-labels
```

**Request Body:**
```json
{
  "sales_invoice": "فاتورة مبيعات",
  "sales_return_invoice": "فاتورة مرتجع مبيعات",
  "price_display": "عرض سعر",
  "type": "النوع :",
  "number": "الرقم :",
  "date": "التاريخ :",
  "time": "الوقت :",
  "customer_name": "اسم العميل",
  "customer_phone": "رقم الهاتف",
  "customer_address": "عنوان العميل",
  "product": "المنتج",
  "quantity": "الكمية",
  "price": "السعر",
  "total": "الإجمالي",
  "total_before_tax": "إجمالي ف.",
  "tax": "الضريبة TAX",
  "discount": "الخصم",
  "net_total": "صافي الفاتورة",
  "paid": "المدفوع",
  "remaining": "الباقي",
  "previous_balance": "الرصيد السابق",
  "current_balance": "الرصيد الحالي",
  "cash": "نقداً",
  "credit": "آجل",
  "card": "بطاقه",
  "check": "شيك",
  "debit": "لكم",
  "credit_label": "عليكم"
}
```

---

## 13. Operations - العمليات

### 13.1 تعديل فاتورة مبيعات
```
PUT /operations/sales-invoices/{invoice_id}
```

### 13.2 تعديل فاتورة مشتريات
```
PUT /operations/purchases-invoices/{invoice_id}
```

### 13.3 إلغاء فاتورة مبيعات/مشتريات
```
DELETE /operations/invoices/{invoice_id}
```

### 13.4 إلغاء حركة صندوق/مصروفات
```
DELETE /operations/cash-expenses/{transaction_id}
```

### 13.5 إلغاء سند قبض/صرف
```
DELETE /operations/vouchers/{voucher_id}
```

### 13.6 إلغاء فاتورة مرتجع مبيعات/مشتريات
```
DELETE /operations/return-invoices/{invoice_id}
```

### 13.7 التحويل بين العملاء والموردين
```
POST /operations/transfer-customer-supplier
```

**Request Body:**
```json
{
  "from_type": "customer",
  "from_id": 1,
  "to_type": "supplier",
  "to_id": 2,
  "amount": 500.00,
  "date": "2025-12-04",
  "notes": "ملاحظات"
}
```

### 13.8 معالجة المنتجات التالفة
```
POST /operations/damaged-products
```

**Request Body:**
```json
{
  "product_id": 1,
  "quantity": 5,
  "reason": "سبب التلف",
  "date": "2025-12-04"
}
```

---

## 14. Authentication - المصادقة (إن كانت مطلوبة)

### 14.1 تسجيل الدخول
```
POST /auth/login
```

**Request Body:**
```json
{
  "username": "admin",
  "password": "password"
}
```

**Response:**
```json
{
  "token": "Bearer token here",
  "user": {
    "id": 1,
    "username": "admin",
    "name": "اسم المستخدم",
    "role": "admin"
  }
}
```

### 14.2 تسجيل الخروج
```
POST /auth/logout
```

### 14.3 تحديث Token
```
POST /auth/refresh
```

---

## ملاحظات مهمة

1. **التواريخ**: جميع التواريخ يجب أن تكون بصيغة `YYYY-MM-DD`
2. **الأرقام**: جميع المبالغ يجب أن تكون بصيغة decimal (مثال: 100.00)
3. **Pagination**: معظم الـ endpoints التي تعيد قوائم تدعم pagination باستخدام `page` و `limit`
4. **الترميز**: جميع النصوص باللغة العربية
5. **الأخطاء**: في حالة حدوث خطأ، سيتم إرجاع response بالشكل التالي:
   ```json
   {
     "error": true,
     "message": "رسالة الخطأ",
     "code": "ERROR_CODE"
   }
   ```

---

## Status Codes

- `200` - نجاح العملية
- `201` - تم الإنشاء بنجاح
- `400` - خطأ في البيانات المرسلة
- `401` - غير مصرح (يحتاج تسجيل دخول)
- `403` - محظور (ليس لديك صلاحية)
- `404` - غير موجود
- `500` - خطأ في الخادم

---

**تم إنشاء هذا الملف بتاريخ: 2025-12-04**
**آخر تحديث: 2025-12-04**

