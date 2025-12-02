# MicroPOS Flutter - Micro Point of Sale

A comprehensive Point of Sale (POS) system built with Flutter 3.24.3, featuring full RTL (Right-to-Left) support for Arabic language, matching the design and functionality of the original React web application.

## 🎯 Features

### Complete Feature Set
- ✅ **Splash Screen** with gradient animations
- ✅ **Dashboard** with 8 menu cards (Sales, Purchases, Suppliers, Customers, Expenses, Cash Box, Reports, Inventory)
- ✅ **Sales Management** with barcode support and register selection
- ✅ **Purchase Management**
- ✅ **Customer Management** with detailed forms
- ✅ **Supplier Management** with full CRUD operations
- ✅ **Inventory Management** with product forms and classification
- ✅ **Cash Box** with add/withdraw functionality
- ✅ **Expenses Tracking** with multiple payment methods
- ✅ **Comprehensive Reports** with date range filtering
- ✅ **Settings** menu
- ✅ **Sidebar** with advanced operations
- ✅ **RTL Support** for Arabic interface

### Design Features
- 🎨 Matching color scheme (Primary: #5B51D8, Accent: #C0E87F)
- 🎨 Gradient backgrounds and modern UI
- 🎨 Responsive layout for mobile, tablet, and desktop
- 🌐 Full RTL (Right-to-Left) support for Arabic
- 📱 Material Design 3 components

## 📋 Prerequisites

- Flutter SDK 3.24.3
- FVM (Flutter Version Management)
- Dart SDK
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)

## 🚀 Getting Started

### Installation

1. **Clone the repository**
   ```bash
   cd i:\anmka_apps
   ```

2. **Navigate to the project**
   ```bash
   cd micro_pos_flutter
   ```

3. **Install Flutter 3.24.3 using FVM**
   ```bash
   fvm use 3.24.3 --force
   ```

4. **Get dependencies**
   ```bash
   fvm flutter pub get
   ```

### Running the Application

#### Desktop (Windows)
```bash
fvm flutter run -d windows
```

#### Android Emulator
```bash
fvm flutter run -d emulator
```

#### iOS Simulator (macOS only)
```bash
fvm flutter run -d simulator
```

#### Chrome (Web)
```bash
fvm flutter run -d chrome
```

### Building the Application

#### Build for Windows
```bash
fvm flutter build windows
```

#### Build for Android
```bash
fvm flutter build apk --release
```

#### Build for iOS
```bash
fvm flutter build ios --release
```

## 📁 Project Structure

```
micro_pos_flutter/
├── lib/
│   ├── constants/
│   │   ├── app_colors.dart          # Color definitions
│   │   └── app_theme.dart           # Theme configuration
│   ├── screens/
│   │   ├── splash_screen.dart       # Splash screen with animations
│   │   ├── main_dashboard.dart      # Main dashboard with menu grid
│   │   ├── sales_menu.dart          # Sales screen with transaction form
│   │   ├── purchases_menu.dart      # Purchases management
│   │   ├── customers_menu.dart      # Customer management
│   │   ├── suppliers_menu.dart      # Supplier management
│   │   ├── inventory_menu.dart      # Inventory management
│   │   ├── cash_box_menu.dart       # Cash box operations
│   │   ├── expenses_menu.dart       # Expenses tracking
│   │   ├── reports_menu.dart        # Reports with filtering
│   │   └── settings_menu.dart       # Settings
│   ├── widgets/
│   │   ├── header_bar.dart          # AppBar with notifications
│   │   ├── sidebar.dart             # Drawer menu
│   │   └── menu_card.dart           # Dashboard menu cards
│   └── main.dart                    # App entry point
├── pubspec.yaml                     # Dependencies
└── README.md                        # This file
```

## 🎨 Screens Overview

### 1. Splash Screen
- Animated gradient background
- App logo with green accent
- Loading indicators
- Auto-navigates to dashboard after 3 seconds

### 2. Main Dashboard
- 8 menu cards with gradient backgrounds:
  - 📦 المشتريات (Purchases)
  - 🛒 المبيعات (Sales)
  - 🤝 الموردين (Suppliers)
  - 👤 العملاء (Customers)
  - 💼 المصروفات (Expenses)
  - 🔐 الصندوق (Cash Box)
  - 📊 التقارير (Reports)
  - 📦 المخزون (Inventory)

### 3. Sales Menu
- Register selection modal (1-4 + Price Display)
- Product search with barcode support
- Transaction form with items table
- Total calculation
- RTL layout

### 4. Customers Menu
- Add new customer
- Customer list
- Balance management
- Reports generation
- Customer form with all fields

### 5. Suppliers Menu
- Add new supplier
- Supplier list
- Balance tracking
- Reports

### 6. Inventory Menu
- Add products
- View products
- Classifications
- Price updates
- Excel import option

### 7. Cash Box
- Add/Withdraw operations
- Transaction history
- Balance display
- Date filtering

### 8. Expenses Menu
- Expense tracking
- Payment method selection (Cash/Card/Check)
- Category management

### 9. Reports Menu
- Comprehensive report categories:
  - Customers
  - Store Movement
  - Sales
  - Purchases
  - Suppliers
  - Warehouses
  - Cash Box
  - Expenses
- Date range filtering

## 🛠️ Technologies Used

- **Flutter 3.24.3** - UI framework
- **Material Design 3** - Design system
- **Provider 6.1.2** - State management (ready for implementation)
- **Intl 0.19.0** - Internationalization support
- **Dart** - Programming language

## 🌍 RTL Support

The entire application supports Right-to-Left layout for Arabic language:
- All text aligned to the right
- Navigation flows from right to left
- Icons and UI elements properly positioned for RTL
- Date pickers and forms adapted for RTL

## 🎨 Color Scheme

```dart
Primary Purple: #5B51D8
Primary Dark:   #4a45b0
Accent Green:   #C0E87F
Accent Dark:    #b8d870
```

## 📝 Development Notes

- All screens are fully functional with navigation
- Forms capture user input (ready for backend integration)
- Modal dialogs for register selection and notifications
- Drawer menu with comprehensive options
- Responsive design adapts to screen sizes

## 🔜 Future Enhancements

- Backend integration for data persistence
- Barcode scanner implementation
- Printer integration
- Export to PDF/Excel
- Multi-language support (Arabic/English toggle)
- Database integration (SQLite/Firebase)
- Authentication and user management

## 📄 License

© 2017 MIS, All rights reserved

## 👨‍💻 Development

This Flutter application is a faithful recreation of the original React web application (micro-pos-web-app-2), maintaining the same:
- Screen flow and navigation
- UI/UX design
- Color scheme and styling
- Feature set and functionality
- RTL support for Arabic

---

**Built with ❤️ using Flutter 3.24.3**
