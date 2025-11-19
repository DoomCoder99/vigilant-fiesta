# Quick Reference Guide

A quick reference for common patterns, commands, and conventions in the Amoz Customer Flutter app.

---

## 🚀 Quick Start Commands

```bash
# Get dependencies
flutter pub get

# Run app (debug)
flutter run

# Run app (release)
flutter run --release

# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release

# Run tests
flutter test

# Check for issues
flutter analyze

# Format code
flutter format .

# Clean build
flutter clean
```

---

## 📐 Naming Conventions Cheat Sheet

| Type | Convention | Example |
|------|------------|---------|
| **Classes** | PascalCase | `UserModel`, `HomeController`, `ApiService` |
| **Variables** | camelCase | `userName`, `isLoading`, `totalAmount` |
| **Constants** | SCREAMING_SNAKE_CASE | `APP_MAIN_COLOR`, `API_BASE_URL` |
| **Files** | snake_case.dart | `home_screen.dart`, `user_model.dart` |
| **Private** | _camelCase | `_privateMethod`, `_internalVariable` |
| **Enums** | PascalCase (type)<br>camelCase (values) | `enum ApiType { get, post, put, delete }` |

---

## 🎨 Theme Constants Quick Access

### Colors

```dart
// Import
import 'package:amoz_customer/core/theme/colors.dart';

// Usage
appMainColor          // Primary color
appSecondaryColor     // Secondary color
successColor          // Success green
errorColor            // Error red
warningColor          // Warning orange
textPrimary           // Primary text color
textSecondary         // Secondary text color
backgroundColor       // Background color
```

### Spacing

```dart
// Import
import 'package:amoz_customer/core/theme/spacing.dart';

// Usage
kSpacingXs    // 4.0
kSpacingSm    // 8.0
kSpacingMd    // 16.0
kSpacingLg    // 24.0
kSpacingXl    // 32.0
kSpacing2Xl   // 48.0

// Border radius
kRadiusSm     // 4.0
kRadiusMd     // 8.0
kRadiusLg     // 16.0
kRadiusXl     // 24.0
```

### Typography

```dart
// Import
import 'package:amoz_customer/core/theme/typography.dart';

// Usage
AppTextStyles.heading1     // Large heading
AppTextStyles.heading2     // Medium heading
AppTextStyles.bodyText     // Body text
AppTextStyles.caption      // Small caption

// Modify existing style
AppTextStyles.bodyText.copyWith(
  fontWeight: FontWeight.bold,
  color: appMainColor,
)
```

---

## 🧩 Common Widget Imports

```dart
// Core widgets
import 'package:amoz_customer/core/widgets/common_text.dart';
import 'package:amoz_customer/core/widgets/common_button.dart';
import 'package:amoz_customer/core/widgets/common_image.dart';
import 'package:amoz_customer/core/widgets/common_spacing.dart';

// State widgets
import 'package:amoz_customer/core/widgets/generic_error_state_widget.dart';
import 'package:amoz_customer/core/widgets/amozit_empty_state_widget.dart';
import 'package:amoz_customer/core/widgets/no_connection_state_widget.dart';

// Navigation
import 'package:amoz_customer/core/routes/app_routes.dart';
```

---

## 🔄 GetX Patterns

### Controller Template

```dart
import 'package:get/get.dart';

class MyController extends GetxController {
  // Reactive variables
  var data = [].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Computed properties
  bool get hasData => data.isNotEmpty;
  
  // Lifecycle
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  // Methods
  Future<void> fetchData() async {
    isLoading(true);
    try {
      // API call
      final response = await ApiService.callApi(
        endpoint: 'data',
        type: ApiType.get,
      );
      data.value = response['data'];
    } catch (e) {
      errorMessage.value = 'Failed to load data';
    } finally {
      isLoading(false);
    }
  }
}
```

### Screen Template with GetX

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Screen'),
      ),
      body: Obx(() {
        // Loading state
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error state
        if (controller.errorMessage.isNotEmpty) {
          return ErrorStateWidget(
            title: 'Error',
            message: controller.errorMessage.value,
            onRetry: () => controller.fetchData(),
          );
        }

        // Empty state
        if (controller.data.isEmpty) {
          return const EmptyStateWidget(
            image: 'assets/blank_states/generic_error.png',
            title: 'No data',
            subtitle: 'No data available',
          );
        }

        // Success state
        return ListView.builder(
          itemCount: controller.data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.data[index].toString()),
            );
          },
        );
      }),
    );
  }
}
```

---

## 🌐 API Call Templates

### GET Request

```dart
final response = await ApiService.callApi(
  endpoint: 'users',
  type: ApiType.get,
  headers: {'Authorization': 'Bearer $token'},
);
```

### POST Request

```dart
final response = await ApiService.callApi(
  endpoint: 'users',
  type: ApiType.post,
  body: {
    'name': 'John Doe',
    'email': 'john@example.com',
  },
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  },
);
```

### PUT Request

```dart
final response = await ApiService.callApi(
  endpoint: 'users/$userId',
  type: ApiType.put,
  body: {
    'name': 'Updated Name',
  },
  headers: {'Authorization': 'Bearer $token'},
);
```

### DELETE Request

```dart
final response = await ApiService.callApi(
  endpoint: 'users/$userId',
  type: ApiType.delete,
  headers: {'Authorization': 'Bearer $token'},
);
```

---

## 📱 Navigation Patterns

### Navigate to Named Route

```dart
// Simple navigation
Get.toNamed('/profile');

// With arguments
Get.toNamed('/profile', arguments: {'userId': 123});

// Replace current screen
Get.offNamed('/home');

// Clear stack and navigate
Get.offAllNamed('/login');
```

### Navigate Back

```dart
// Go back
Get.back();

// Go back with result
Get.back(result: {'success': true});

// Check if can go back
if (Get.isBottomSheetOpen ?? false) {
  Get.back();
}
```

### Receive Arguments

```dart
// In destination screen
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final userId = args['userId'];
    
    return Scaffold(
      appBar: AppBar(
        title: Text('User $userId'),
      ),
    );
  }
}
```

---

## 🎨 Common UI Patterns

### Card with Shadow

```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(kRadiusMd),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: // Your content
)
```

### Gradient Container

```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [appMainColor, appMainColor.withOpacity(0.8)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(kRadiusLg),
  ),
  child: // Your content
)
```

### Circular Avatar with Border

```dart
Container(
  width: 80,
  height: 80,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: appMainColor, width: 3),
    image: const DecorationImage(
      image: AssetImage('assets/profile/profile_avatar.png'),
      fit: BoxFit.cover,
    ),
  ),
)
```

### Dismissible List Item

```dart
Dismissible(
  key: Key(item.id),
  direction: DismissDirection.endToStart,
  background: Container(
    color: errorColor,
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.only(right: kSpacingMd),
    child: const Icon(Icons.delete, color: Colors.white),
  ),
  onDismissed: (direction) {
    controller.removeItem(item.id);
  },
  child: ListTile(
    title: Text(item.name),
  ),
)
```

---

## 🧪 Testing Snippets

### Widget Test Template

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group('MyWidget Tests', () {
    testWidgets('displays title correctly', (WidgetTester tester) async {
      // Build widget
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: MyWidget(title: 'Test Title'),
          ),
        ),
      );

      // Verify
      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('button triggers callback', (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: CommonButton(
              title: 'Tap Me',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Tap button
      await tester.tap(find.text('Tap Me'));
      await tester.pump();

      // Verify
      expect(tapped, true);
    });
  });
}
```

### Unit Test Template

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyController Tests', () {
    late MyController controller;

    setUp(() {
      controller = MyController();
    });

    test('initial state is correct', () {
      expect(controller.isLoading.value, false);
      expect(controller.data.isEmpty, true);
    });

    test('fetchData updates state correctly', () async {
      await controller.fetchData();
      
      expect(controller.isLoading.value, false);
      expect(controller.data.isNotEmpty, true);
    });
  });
}
```

---

## 📦 Commonly Used Packages

```yaml
dependencies:
  # State management & navigation
  get: ^4.6.6
  
  # Internationalization
  intl: ^0.19.0
  
  # Utilities
  url_launcher: ^6.2.5
  shared_preferences: ^2.2.2
  flutter_svg: ^2.0.9
  
  # Recommended additions
  dio: ^5.4.0                    # Better HTTP client
  cached_network_image: ^3.3.0  # Image caching
  google_fonts: ^6.1.0          # Custom fonts
```

---

## ⚡ Performance Tips

1. **Use `const` wherever possible**
   ```dart
   const Padding(padding: EdgeInsets.all(16), child: Text('Hello'))
   ```

2. **Extract widgets instead of methods**
   ```dart
   // ❌ Bad
   Widget _buildTitle() => Text('Title');
   
   // ✅ Good
   class TitleWidget extends StatelessWidget {
     const TitleWidget({super.key});
     @override
     Widget build(BuildContext context) => const Text('Title');
   }
   ```

3. **Use ListView.builder for long lists**
   ```dart
   ListView.builder(
     itemCount: items.length,
     itemBuilder: (context, index) => ItemCard(items[index]),
   )
   ```

4. **Avoid rebuilding entire trees**
   ```dart
   // Use Obx only around widgets that need to react
   Column(
     children: [
       const StaticWidget(),  // Won't rebuild
       Obx(() => DynamicWidget(controller.value)),  // Will rebuild
     ],
   )
   ```

---

## 🔍 Debugging Tips

```dart
// Print debug messages
debugPrint('Debug message: $variable');

// Inspect widget tree
debugDumpApp();

// Check render tree
debugDumpRenderTree();

// Profile build time
Timeline.startSync('MyOperation');
// ... your code
Timeline.finishSync();
```

---

## 📂 File Structure Quick Lookup

```
lib/
├── main.dart                     # Entry point
├── core/
│   ├── routes/                   # Navigation routes
│   ├── services/                 # Global services
│   ├── theme/                    # Design system
│   ├── utils/                    # Utility functions
│   └── widgets/                  # Common widgets
├── data/
│   ├── models/                   # Data models
│   ├── services/                 # API services
│   └── repository/               # Data repositories
└── modules/
    └── [feature]/
        ├── controller/           # GetX controllers
        ├── view/                 # UI screens
        └── widgets/              # Feature widgets
```

---

## 🆘 Common Issues & Fixes

### Issue: "Null check operator used on a null value"
```dart
// ❌ Bad
final value = data!.field;

// ✅ Good
final value = data?.field ?? defaultValue;
```

### Issue: "RenderFlex overflowed"
```dart
// ❌ Bad
Row(children: [Text('Very long text...')])

// ✅ Good
Row(
  children: [
    Expanded(child: Text('Very long text...', overflow: TextOverflow.ellipsis))
  ]
)
```

### Issue: "setState called after dispose"
```dart
// ✅ Good
if (mounted) {
  setState(() {
    // Update state
  });
}
```

---

## 📞 Quick Links

- **Main README**: `/README.md`
- **Detailed Examples**: `/docs/coding_guidelines_examples.md`
- **WDI Standards**: See project rules in `.cursor/rules/`
- **Module Docs**: `/docs/module*_*.md`

---

**Tip**: Bookmark this file for quick reference during development!

**Last Updated:** November 2025

