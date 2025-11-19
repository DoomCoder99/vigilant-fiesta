# Amoz Customer - Flutter Mobile App

A hybrid mobile application built with Flutter for Android and iOS platforms, following WDI Flutter Coding Standards.

---

## 📋 Table of Contents

- [Project Information](#project-information)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Coding Standards](#coding-standards)
- [Design System](#design-system)
- [Package Guidelines](#package-guidelines)
- [Common Widgets & Patterns](#common-widgets--patterns)
- [API Integration](#api-integration)
- [Testing](#testing)
- [Build & Deployment](#build--deployment)
- [Documentation](#documentation)

---

## 📱 Project Information

**Version:** 0.1.0  
**Flutter SDK:** ^3.9.2  
**State Management:** GetX (^4.6.6)  
**Architecture:** WDI GetX Architecture Pattern

### Device Support

**Supported Platforms:**
- ✅ Android (minSDK 21)
- ✅ iOS (min iOS 12)

**Unsupported Platforms:**
- ❌ Web
- ❌ Windows
- ❌ macOS
- ❌ Linux

---

## 🔧 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** 3.9.2 or higher
- **Dart SDK** (comes with Flutter)
- **Android Studio** (for Android development)
  - Android SDK
  - Android Emulator
- **Xcode** (for iOS development, macOS only)
  - CocoaPods
- **Git**
- **VS Code** or **Android Studio** with Flutter/Dart plugins

### Verify Installation

```bash
flutter doctor -v
```

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd amoz_customer
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the Application

**Debug Mode:**
```bash
# Android
flutter run

# iOS (macOS only)
flutter run -d ios
```

**Release Mode:**
```bash
flutter run --release
```

### 4. Build the Application

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle (for Play Store):**
```bash
flutter build appbundle --release
```

**iOS (macOS only):**
```bash
flutter build ios --release
```

---

## 📁 Project Structure

This project follows the **WDI GetX Architecture** pattern:

```
lib/
│
├── main.dart                          # Application entry point
├── core/                              # Core application components
│   ├── constants/                     # App-wide constants
│   ├── routes/                        # Navigation and routing
│   │   └── app_routes.dart
│   ├── services/                      # Global services
│   │   ├── auth_service.dart
│   │   └── location_permission_service.dart
│   ├── theme/                         # Design system & theming
│   │   ├── app_theme.dart
│   │   ├── colors.dart
│   │   ├── spacing.dart
│   │   └── typography.dart
│   ├── utils/                         # Utility functions
│   │   └── asset_helper.dart
│   └── widgets/                       # Common reusable widgets
│       ├── bottom_navigation_bar.dart
│       ├── auth_guard.dart
│       └── ...
│
├── data/                              # Data layer
│   ├── models/                        # Data models
│   ├── services/                      # API services
│   └── repository/                    # Data repositories
│
└── modules/                           # Feature modules
    ├── home/
    │   ├── controller/                # GetX controllers
    │   ├── view/                      # UI screens
    │   └── widgets/                   # Module-specific widgets
    ├── profile/
    ├── rent_vehicle/
    ├── service_booking/
    └── ...
```

### Key Directories

- **`core/`** - Application-wide shared code (theme, routing, services, common widgets)
- **`data/`** - Data models, API services, and repositories
- **`modules/`** - Feature modules, each containing controllers, views, and widgets
- **`assets/`** - Images, icons, and other static assets
- **`docs/`** - Project documentation (87+ detailed guides)

---

## 📐 Coding Standards

This project strictly follows the **WDI Flutter Coding Standard Guide**. Key principles:

### 1. Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| **Classes** | PascalCase | `UserModel`, `HomeController` |
| **Variables** | camelCase | `userName`, `selectedDate` |
| **Constants** | SCREAMING_SNAKE_CASE | `APP_MAIN_COLOR`, `API_BASE_URL` |
| **Files** | snake_case.dart | `home_screen.dart`, `user_model.dart` |
| **Enums** | PascalCase (type)<br>camelCase (values) | `enum ApiType { get, post }` |

### 2. File Naming

- Screens: `*_screen.dart` (e.g., `home_screen.dart`)
- Widgets: `*_widget.dart` (e.g., `custom_button_widget.dart`)
- Controllers: `*_controller.dart` (e.g., `home_controller.dart`)
- Models: `*_model.dart` (e.g., `user_model.dart`)
- Services: `*_service.dart` (e.g., `auth_service.dart`)

### 3. Code Style Best Practices

✅ **DO:**
- Use `const` constructors wherever possible
- Keep business logic OUT of UI code
- Extract large widgets into smaller, reusable components
- Handle errors gracefully with try-catch blocks
- Add meaningful comments for complex logic
- Use named parameters for functions with multiple arguments
- Maintain consistent spacing and indentation (2 spaces)

❌ **DON'T:**
- Put business logic inside `build()` methods
- Hardcode values (use constants and theme variables)
- Create deeply nested widget trees (extract widgets)
- Ignore linter warnings
- Use magic numbers or strings

### 4. JSON for Repeated UI Elements

For repeated UI elements (grids, lists, carousels), use JSON data structures to reduce code duplication:

**Example:**

```dart
// ✅ Good: Data-driven UI
final List<Map<String, dynamic>> menuItems = [
  {'icon': Icons.home, 'title': 'Home', 'route': '/home'},
  {'icon': Icons.person, 'title': 'Profile', 'route': '/profile'},
  {'icon': Icons.settings, 'title': 'Settings', 'route': '/settings'},
];

ListView.builder(
  itemCount: menuItems.length,
  itemBuilder: (context, index) {
    final item = menuItems[index];
    return ListTile(
      leading: Icon(item['icon']),
      title: Text(item['title']),
      onTap: () => Get.toNamed(item['route']),
    );
  },
);
```

**Use cases:**
- GridView items
- ListView items
- Card collections
- Menu options
- Carousels
- Tab content

---

## 🎨 Design System

All theme values are centralized in `lib/core/theme/`:

### Colors (`colors.dart`)

```dart
// Primary colors
const Color appMainColor = Color(0xff0fffff);
const Color appSecondaryColor = Color(0xff2c3e50);

// Semantic colors
const Color successColor = Color(0xff27ae60);
const Color errorColor = Color(0xffe74c3c);
const Color warningColor = Color(0xfff39c12);

// Neutral colors
const Color textPrimary = Color(0xff2c3e50);
const Color textSecondary = Color(0xff7f8c8d);
const Color backgroundColor = Color(0xfff8f9fa);
```

### Typography (`typography.dart`)

Define all text styles in one place:

```dart
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimary,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textSecondary,
  );
}
```

### Spacing (`spacing.dart`)

Consistent spacing tokens:

```dart
// Spacing scale
const double kSpacingXs = 4.0;
const double kSpacingSm = 8.0;
const double kSpacingMd = 16.0;
const double kSpacingLg = 24.0;
const double kSpacingXl = 32.0;
const double kSpacing2Xl = 48.0;

// Border radius
const double kRadiusSm = 4.0;
const double kRadiusMd = 8.0;
const double kRadiusLg = 16.0;
const double kRadiusXl = 24.0;
```

### Theme Management (`app_theme.dart`)

Support for light and dark modes:

```dart
class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: appMainColor,
    scaffoldBackgroundColor: backgroundColor,
    // ... define complete theme
  );
  
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // ... define complete dark theme
  );
}
```

**Key Principles:**
- ✅ Never inline hex colors in widgets
- ✅ Always use theme constants or `Theme.of(context)`
- ✅ Maintain design tokens for spacing, typography, colors
- ✅ Support both light and dark modes

---

## 📦 Package Guidelines

### Core Dependencies

Current packages in use:

| Package | Version | Purpose |
|---------|---------|---------|
| **get** | ^4.6.6 | State management & navigation |
| **intl** | ^0.19.0 | Internationalization & date formatting |
| **url_launcher** | ^6.2.5 | Launch URLs, phone, email |
| **shared_preferences** | ^2.2.2 | Local key-value storage |
| **flutter_svg** | ^2.0.9 | SVG rendering |

### Package Selection Policy

✅ **Use well-supported packages with:**
- High pub.dev score (>130)
- Regular maintenance (updated within 6 months)
- Large community (>1000 likes)
- Good documentation
- Null-safety support

✅ **Preferred packages:**
- `get` - State management
- `dio` - HTTP client (recommended for API calls)
- `intl` - Internationalization
- `google_fonts` - Custom fonts
- `shared_preferences` - Local storage
- `cached_network_image` - Image caching
- `flutter_svg` - SVG support

❌ **Avoid:**
- Small, unmaintained packages
- Packages with low pub.dev scores
- Packages with unresolved issues
- Packages that haven't been updated in >1 year

**Alternative:** Create your own common widget instead of adding a small package.

### Adding New Packages

```bash
# Add a package
flutter pub add package_name

# Add a dev dependency
flutter pub add --dev package_name

# Always run after adding packages
flutter pub get
```

---

## 🧩 Common Widgets & Patterns

### 1. Common Text Widget

**Location:** `lib/core/widgets/common_text.dart`

```dart
class CommonText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CommonText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? AppTextStyles.bodyText,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
```

### 2. Common Button Widget

**Location:** `lib/core/widgets/common_button.dart`

```dart
class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;

  const CommonButton({
    super.key,
    required this.title,
    required this.onTap,
    this.loading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: loading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? appMainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadiusMd),
          ),
        ),
        child: loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                title,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
```

### 3. Common Image Widget

**Location:** `lib/core/widgets/common_image.dart`

```dart
class CommonImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool isAsset;

  const CommonImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.isAsset = true,
  });

  @override
  Widget build(BuildContext context) {
    return isAsset
        ? Image.asset(
            imagePath,
            width: width,
            height: height,
            fit: fit,
          )
        : Image.network(
            imagePath,
            width: width,
            height: height,
            fit: fit,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          );
  }
}
```

### 4. Common Spacing Widget

**Location:** `lib/core/widgets/common_spacing.dart`

```dart
class VSpace extends StatelessWidget {
  final double height;
  const VSpace(this.height, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}

class HSpace extends StatelessWidget {
  final double width;
  const HSpace(this.width, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: width);
}

// Usage:
// VSpace(kSpacingMd)
// HSpace(kSpacingSm)
```

---

## 🌐 API Integration

### API Service Setup

**Location:** `lib/data/services/api_service.dart`

```dart
enum ApiType { get, post, put, delete }

class ApiService {
  static const String baseUrl = "https://api.example.com/";

  static Future<dynamic> callApi({
    required String endpoint,
    required ApiType type,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      http.Response response;

      switch (type) {
        case ApiType.get:
          response = await http.get(url, headers: headers);
          break;
        case ApiType.post:
          response = await http.post(
            url,
            headers: headers,
            body: jsonEncode(body),
          );
          break;
        case ApiType.put:
          response = await http.put(
            url,
            headers: headers,
            body: jsonEncode(body),
          );
          break;
        case ApiType.delete:
          response = await http.delete(url, headers: headers);
          break;
      }

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
```

### API Response Model

```dart
class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return ApiResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}
```

### GetX Controller Example

```dart
class UserController extends GetxController {
  var users = [].obs;
  var isLoading = false.obs;

  Future<void> fetchUsers() async {
    isLoading(true);
    try {
      final response = await ApiService.callApi(
        endpoint: 'users',
        type: ApiType.get,
      );
      users.assignAll(response['data']);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users');
    } finally {
      isLoading(false);
    }
  }
}
```

---

## 🧪 Testing

### Run Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

### Test Structure

```
test/
├── unit/                   # Unit tests
│   ├── models/
│   ├── controllers/
│   └── services/
├── widget/                 # Widget tests
│   └── common_button_test.dart
└── integration/            # Integration tests
```

### Writing Tests

```dart
void main() {
  group('CommonButton Widget Tests', () {
    testWidgets('displays title correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonButton(
              title: 'Test Button',
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });
  });
}
```

---

## 🏗️ Build & Deployment

### Version Management

Update version in `pubspec.yaml`:

```yaml
version: 1.0.0+1  # version_name+build_number
```

### Android Release Build

1. **Configure signing** in `android/app/build.gradle`
2. **Build release APK:**
   ```bash
   flutter build apk --release
   ```
3. **Build App Bundle (for Play Store):**
   ```bash
   flutter build appbundle --release
   ```

**Output locations:**
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- Bundle: `build/app/outputs/bundle/release/app-release.aab`

### iOS Release Build (macOS only)

1. **Configure signing** in Xcode
2. **Build release IPA:**
   ```bash
   flutter build ios --release
   ```
3. **Archive and upload** via Xcode or Transporter

---

## 📚 Documentation

Detailed implementation guides and module documentation are available in the `docs/` folder:

### Key Documentation Files

- **Module Implementation Guides**: `module*_implementation.md`
- **Asset Management**: `asset_implementation_guide.md`
- **Flow Diagrams**: `module*_state_flow_diagram.md`
- **Design Fixes**: `design_fidelity_fixes_summary.md`
- **Testing Guides**: `module*_testing_guide.md`

### Generating Documentation

```bash
# Generate Dart documentation
dart doc .

# View generated docs
open doc/api/index.html
```

---

## 🤝 Contributing

1. Follow WDI Flutter Coding Standards
2. Write meaningful commit messages
3. Add tests for new features
4. Update documentation as needed
5. Ensure all linter checks pass before committing

### Code Review Checklist

- [ ] Follows WDI naming conventions
- [ ] No business logic in UI code
- [ ] Uses theme constants (no hardcoded values)
- [ ] Proper error handling
- [ ] Includes tests
- [ ] Documentation updated
- [ ] No linter warnings

---

## 📞 Support

For questions or issues:

1. Check the `docs/` folder for detailed guides
2. Review the WDI Flutter Coding Standard Guide
3. Contact the development team

---

## 📄 License

[Add your license information here]

---

**Last Updated:** November 2025  
**Maintained by:** Amoz Development Team
