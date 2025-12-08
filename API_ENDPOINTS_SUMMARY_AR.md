# ملخص نقاط النهاية (API Endpoints) - تطبيق MicroPOS

## نظرة عامة
هذا الملف يحتوي على ملخص شامل لجميع نقاط النهاية المطلوبة لتطبيق MicroPOS Flutter.

**الرابط الأساسي:** `https://api.micropos.com/api/v1`

---

## 📊 1. لوحة التحكم (Dashboard)

| الوظيفة | Method | Endpoint |
|---------|--------|----------|
| إحصائيات لوحة التحكم | GET | `/dashboard/statistics` |

---

## 🛒 2. المبيعات (Sales)

| الوظيفة | Method | Endpoint |
|---------|--------|----------|
| البحث عن منتج | GET | `/sales/products/search?q={term}&barcode={barcode}` |
| البحث عن عميل | GET | `/sales/customers/search?q={term}` |
| إنشاء فاتورة مبيعات | POST | `/sales/invoices` |
| الحصول على فاتورة | GET | `/sales/invoices/{id}` |
| تحديث فاتورة | PUT | `/sales/invoices/{id}` |
| حذف فاتورة | DELETE | `/sales/invoices/{id}` |
| طباعة فاتورة | GET | `/sales/invoices/{id}/print` |
| إرجاع فاتورة | POST | `/sales/invoices/{id}/return` |

---

## 📦 3. المشتريات (Purchases)

| الوظيفة | Method | Endpoint |
|---------|--------|----------|
| البحث عن منتج | GET | `/purchases/products/search?q={term}&barcode={barcode}` |
| البحث عن مورد | GET | `/purchases/suppliers/search?q={term}` |
| إنشاء فاتورة مشتريات | POST | `/purchases/invoices` |
| الحصول على فاتورة | GET | `/purchases/invoices/{id}` |
| تحديث فاتورة | PUT | `/purchases/invoices/{id}` |
| حذف فاتورة | DELETE | `/purchases/invoices/{id}` |
| طباعة فاتورة | GET | `/purchases/invoices/{id}/print` |
| إرجاع فاتورة | POST | `/purchases/invoices/{id}/return` |
| استيراد من طلب شراء | GET | `/purchases/purchase-orders/{order_id}` |

---

## 👤 4. العملاء (Customers)

| الوظيفة | Method | Endpoint |
|---------|--------|----------|
| قائمة العملاء | GET | `/customers?page=1&limit=20&search={term}` |
| الحصول على عميل | GET | `/customers/{id}` |
| إنشاء عميل | POST | `/customers` |
| تحديث عميل | PUT | `/customers/{id}` |
| حذف عميل | DELETE | `/customers/{id}` |
| المبالغ المتبقية | GET | `/customers/remaining-amounts?search={term}` |
| الأرصدة الافتتاحية | GET | `/customers/opening-balances?search={term}` |
| كشف حساب | GET | `/customers/{id}/statement?from_date={date}&to_date={date}` |
| سند قبض | POST | `/customers/{id}/receipt-vouchers` |
| سند صرف | POST | `/customers/{id}/payment-vouchers` |
| طباعة سند | GET | `/customers/vouchers/{voucher_id}/print` |

---

## 🤝 5. الموردين (Suppliers)

| الوظيفة | Method | Endpoint |
|---------|--------|----------|
| قائمة الموردين | GET | `/suppliers?page=1&limit=20&search={term}` |
| الحصول على مورد | GET | `/suppliers/{id}` |
| إنشاء مورد | POST | `/suppliers` |
| تحديث مورد | PUT | `/suppliers/{id}` |
| حذف مورد | DELETE | `/suppliers/{id}` |
| المبالغ المتبقية | GET | `/suppliers/remaining-amounts?search={term}` |
| الأرصدة الافتتاحية | GET | `/suppliers/opening-balances?search={term}` |
| كشف حساب | GET | `/suppliers/{id}/statement?from_date={date}&to_date={date}` |
| سند قبض/صرف | POST | `/suppliers/{id}/vouchers` |

---

## 📦 6. المخزون (Inventory)

| الوظيفة | Method | Endpoint |
|---------|--------|----------|
| قائمة المنتجات | GET | `/inventory/products?page=1&limit=20&search={term}&category_id={id}` |
| الحصول على منتج | GET | `/inventory/products/{id}` |
| إنشاء منتج | POST | `/inventory/products` |
| تحديث منتج | PUT | `/inventory/products/{id}` |
| حذف منتج | DELETE | `/inventory/products/{id}` |
| قائمة التصنيفات | GET | `/inventory/categories` |
| إنشاء تصنيف | POST | `/inventory/categories` |
| تحديث تصنيف | PUT | `/inventory/categories/{id}` |
| حذف تصنيف | DELETE | `/inventory/categories/{id}` |
| قائمة الوحدات | GET | `/inventory/units` |
| تعديل أسعار مجمعة | POST | `/inventory/products/bulk-update-prices` |
| استيراد من Excel | POST | `/inventory/products/import-excel` |

---

## 💼 7. الصندوق (Cash Box)

| الوظيفة | Method | Endpoint |
|---------|--------|----------|
| رصيد الصندوق | GET | `/cash-box/balance` |
| إضافة/سحب | POST | `/cash-box/transactions` |
| حركات الصندوق | GET | `/cash-box/transactions?from_date={date}&to_date={date}` |
| حذف حركة | DELETE | `/cash-box/transactions/{id}` |

---

## 💰 8. المصروفات (Expenses)

| الوظيفة | Method | Endpoint |
|---------|--------|----------|
| قائمة المصروفات | GET | `/expenses?from_date={date}&to_date={date}` |
| إنشاء مصروف | POST | `/expenses` |
| تحديث مصروف | PUT | `/expenses/{id}` |
| حذف مصروف | DELETE | `/expenses/{id}` |
| حسابات المصروفات | GET | `/expenses/accounts` |

---

## 📊 9. التقارير (Reports)

### 9.1 تقارير العملاء
- دمج العملاء: `GET /reports/customers/merge`
- كشف حساب عميل: `GET /reports/customers/{id}/statement`
- مصادقة حساب عميل: `GET /reports/customers/{id}/verification`
- حركة الرصيد الافتتاحي: `GET /reports/customers/{id}/opening-balance-movement`
- فواتير عميل: `GET /reports/customers/{id}/invoices`
- سندات القبض: `GET /reports/customers/{id}/receipt-vouchers`

### 9.2 تقارير المتجر
- حركة المتجر: `GET /reports/store/movement`
- حركة المتجر (رسم بياني): `GET /reports/store/movement/chart`

### 9.3 تقارير المبيعات
- تقرير المبيعات: `GET /reports/sales`
- تقارير الأرباح: `GET /reports/sales/profits`
- فواتير المبيعات: `GET /reports/sales/invoices`
- تقرير الخصومات: `GET /reports/sales/discounts`
- الفواتير الآجل: `GET /reports/sales/credit-invoices`

### 9.4 تقارير المشتريات
- تقرير المشتريات: `GET /reports/purchases`
- فواتير المشتريات: `GET /reports/purchases/invoices`
- الفواتير المرتجع: `GET /reports/purchases/return-invoices`

### 9.5 تقارير الموردين
- المتبقي للموردين: `GET /reports/suppliers/remaining`
- كشف حساب مورد: `GET /reports/suppliers/{id}/statement`
- حركة الرصيد الافتتاحي: `GET /reports/suppliers/{id}/opening-balance-movement`

### 9.6 تقارير المخازن
- جرد مخزني: `GET /reports/inventory/stock`
- جرد حسب التصنيف: `GET /reports/inventory/stock-by-category`
- حركة منتج: `GET /reports/inventory/products/{id}/movement`
- المنتجات التالفة: `GET /reports/inventory/damaged-products`

### 9.7 تقارير الصندوق
- حركة الصندوق: `GET /reports/cash-box/movement`
- تقرير رأس المال: `GET /reports/cash-box/capital`
- حساب الزكاة: `GET /reports/cash-box/zakat`
- الإقرار الضريبي: `GET /reports/cash-box/tax-declaration`

### 9.8 تقارير المصروفات
- تقرير بصنيف المصروفات: `GET /reports/expenses/by-category`
- تقرير بطلبات الشراء: `GET /reports/expenses/purchase-orders`

---

## ⚙️ 10. الإعدادات (Settings)

| الوظيفة | Method | Endpoint |
|---------|--------|----------|
| الحصول على الإعدادات | GET | `/settings` |
| تحديث الإعدادات | PUT | `/settings` |
| رفع شعار | POST | `/settings/upload-logo` |
| رفع ختم | POST | `/settings/upload-stamp` |

---

## 📋 11. الضرائب (Taxes)

| الوظيفة | Method | Endpoint |
|---------|--------|----------|
| قائمة الضرائب | GET | `/taxes` |
| إنشاء ضريبة | POST | `/taxes` |
| تحديث ضريبة | PUT | `/taxes/{id}` |
| حذف ضريبة | DELETE | `/taxes/{id}` |
| إعدادات الضرائب | GET | `/taxes/settings` |
| تحديث إعدادات الضرائب | PUT | `/taxes/settings` |

---

## 🖨️ 12. الطابعة (Printer)

| الوظيفة | Method | Endpoint |
|---------|--------|----------|
| إعدادات الطابعة | GET | `/printer/settings` |
| تحديث إعدادات الطابعة | PUT | `/printer/settings` |
| مسميات الفاتورة | GET | `/printer/invoice-labels` |
| تحديث مسميات الفاتورة | PUT | `/printer/invoice-labels` |

---

## 🔧 13. العمليات (Operations)

| الوظيفة | Method | Endpoint |
|---------|--------|----------|
| تعديل فاتورة مبيعات | PUT | `/operations/sales-invoices/{id}` |
| تعديل فاتورة مشتريات | PUT | `/operations/purchases-invoices/{id}` |
| إلغاء فاتورة | DELETE | `/operations/invoices/{id}` |
| إلغاء حركة صندوق | DELETE | `/operations/cash-expenses/{id}` |
| إلغاء سند | DELETE | `/operations/vouchers/{id}` |
| إلغاء فاتورة مرتجع | DELETE | `/operations/return-invoices/{id}` |
| التحويل بين عملاء/موردين | POST | `/operations/transfer-customer-supplier` |
| معالجة منتجات تالفة | POST | `/operations/damaged-products` |

---

## 🔐 14. المصادقة (Authentication) - اختياري

| الوظيفة | Method | Endpoint |
|---------|--------|----------|
| تسجيل الدخول | POST | `/auth/login` |
| تسجيل الخروج | POST | `/auth/logout` |
| تحديث Token | POST | `/auth/refresh` |

---

## 📝 ملاحظات مهمة

### المصادقة (Authentication)
جميع الـ endpoints تحتاج إلى Bearer Token:
```
Authorization: Bearer {token}
```

### التواريخ
جميع التواريخ بصيغة: `YYYY-MM-DD`
مثال: `2025-12-04`

### Pagination
معظم الـ endpoints تدعم:
- `page`: رقم الصفحة (افتراضي: 1)
- `limit`: عدد النتائج (افتراضي: 20)

### رفع الملفات
- رفع شعار/ختم: `multipart/form-data`
- استيراد Excel: `multipart/form-data`

### رموز الحالة (Status Codes)
- `200` - نجاح
- `201` - تم الإنشاء
- `400` - خطأ في البيانات
- `401` - غير مصرح
- `403` - محظور
- `404` - غير موجود
- `500` - خطأ في الخادم

---

## 📄 الملفات المتاحة

1. **API_ENDPOINTS.md** - ملف تفصيلي شامل بجميع الـ endpoints مع الأمثلة
2. **api_endpoints.json** - ملف JSON منظم يمكن استخدامه برمجياً
3. **API_ENDPOINTS_SUMMARY_AR.md** - هذا الملف (ملخص سريع)

---

**تاريخ الإنشاء:** 2025-12-04  
**الإصدار:** 1.0

