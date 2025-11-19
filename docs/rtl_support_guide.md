# RTL (Right-to-Left) Support Guide

## Overview

This guide explains how RTL support is implemented for Arabic language in the AMOZIT Customer app.

---

## ✅ RTL Implementation Complete

### 1. Core RTL Support

**GetMaterialApp Configuration** (`lib/main.dart`)
- ✅ Automatically detects RTL based on locale
- ✅ Wraps entire app with `Directionality` widget
- ✅ Sets `TextDirection.rtl` for Arabic (`ar_SA`)
- ✅ Sets `TextDirection.ltr` for English (`en_US`)

**RTL Helper Utility** (`lib/core/utils/rtl_helper.dart`)
- ✅ Provides RTL-aware helper methods
- ✅ Handles icon direction flipping
- ✅ Provides directional padding utilities
- ✅ Checks current text direction

### 2. UI Components Updated

**Profile Screens:**
- ✅ `ProfileAndMoreScreen` - Uses RTL-aware icons
- ✅ `LanguageSelectionScreen` - Chevron icons flip correctly
- ✅ Back buttons flip direction (arrow_back ↔ arrow_forward)
- ✅ Navigation chevrons flip (chevron_right ↔ chevron_left)

---

## 🎯 How RTL Works

### Automatic RTL Detection

When Arabic is selected:
1. `GetMaterialApp` detects `locale.languageCode == 'ar'`
2. Sets `TextDirection.rtl` for entire app
3. Flutter automatically:
   - Flips text alignment
   - Mirrors padding/margins
   - Adjusts icon positions
   - Reverses list item order

### Manual RTL Checks

```dart
import 'package:amoz_customer/core/utils/rtl_helper.dart';

// Check if RTL
bool isRTL = RtlHelper.isRTL;

// Get text direction
TextDirection direction = RtlHelper.textDirection;

// Get RTL-aware icon
IconData chevron = RtlHelper.getChevronIcon(); // chevron_left in RTL
IconData backIcon = RtlHelper.getBackIcon(); // arrow_forward in RTL
```

---

## 📐 Using RTL-Aware Widgets

### 1. Directional Padding

**❌ Don't use:**
```dart
Padding(
  padding: EdgeInsets.only(left: 16, right: 8),
  child: Text('content'),
)
```

**✅ Use instead:**
```dart
import 'package:amoz_customer/core/utils/rtl_helper.dart';

Padding(
  padding: RtlHelper.directionalOnly(start: 16, end: 8),
  child: Text('content'),
)
```

Or use Flutter's built-in:
```dart
Padding(
  padding: EdgeInsetsDirectional.only(start: 16, end: 8),
  child: Text('content'),
)
```

### 2. RTL-Aware Icons

**❌ Don't use:**
```dart
Icon(Icons.chevron_right) // Always points right
Icon(Icons.arrow_back)    // Always points left
```

**✅ Use instead:**
```dart
import 'package:amoz_customer/core/utils/rtl_helper.dart';

Icon(RtlHelper.getChevronIcon()) // Flips in RTL
Icon(RtlHelper.getBackIcon())     // Flips in RTL
```

### 3. Alignment

**❌ Don't use:**
```dart
Align(
  alignment: Alignment.centerLeft, // Always left
  child: Text('content'),
)
```

**✅ Use instead:**
```dart
import 'package:amoz_customer/core/utils/rtl_helper.dart';

Align(
  alignment: RtlHelper.getStartAlignment(), // Left in LTR, Right in RTL
  child: Text('content'),
)
```

---

## 🔧 Common RTL Patterns

### List Items with Icons

```dart
Row(
  children: [
    Expanded(
      child: Text('title'.tr),
    ),
    Icon(
      RtlHelper.getChevronIcon(), // Flips automatically
      size: 20,
    ),
  ],
)
```

### AppBar Back Button

```dart
AppBar(
  leading: IconButton(
    icon: Icon(RtlHelper.getBackIcon()), // Flips automatically
    onPressed: () => Get.back(),
  ),
)
```

### Buttons with Icons

```dart
ElevatedButton(
  onPressed: () {},
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('switch'.tr),
      SizedBox(width: 8),
      Icon(RtlHelper.getChevronIcon()), // Flips automatically
    ],
  ),
)
```

---

## 🎨 RTL-Aware Widget Examples

### Settings List Item

```dart
class RtlAwareListItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const RtlAwareListItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(title),
            ),
            Icon(
              RtlHelper.getChevronIcon(),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
```

### RTL-Aware Container with Padding

```dart
Container(
  padding: EdgeInsetsDirectional.only(
    start: 16,  // Left in LTR, Right in RTL
    end: 8,     // Right in LTR, Left in RTL
    top: 12,
    bottom: 12,
  ),
  child: Text('content'.tr),
)
```

---

## ✅ RTL Checklist

When creating new screens or widgets, ensure:

- [ ] Use `EdgeInsetsDirectional` instead of `EdgeInsets`
- [ ] Use `RtlHelper.getChevronIcon()` for navigation icons
- [ ] Use `RtlHelper.getBackIcon()` for back buttons
- [ ] Test layout in both English (LTR) and Arabic (RTL)
- [ ] Verify text alignment is correct
- [ ] Check icon positions flip correctly
- [ ] Ensure padding/margins adjust properly
- [ ] Verify list items order correctly

---

## 🧪 Testing RTL

### Manual Testing Steps

1. **Switch to Arabic:**
   - Go to Profile & More → Language
   - Select Arabic
   - Tap Switch

2. **Verify RTL Layout:**
   - ✅ Text flows right-to-left
   - ✅ Icons flip positions (chevrons, arrows)
   - ✅ Padding adjusts automatically
   - ✅ Navigation feels natural

3. **Switch Back to English:**
   - Verify layout returns to LTR
   - All elements return to normal positions

### Visual Checks

**In Arabic (RTL):**
- Back button should be on the right
- Chevron icons should point left
- Text should align to the right
- List items should start from right

**In English (LTR):**
- Back button should be on the left
- Chevron icons should point right
- Text should align to the left
- List items should start from left

---

## 🐛 Common RTL Issues & Fixes

### Issue 1: Icons Don't Flip

**Problem:** Icons always point same direction

**Fix:** Use `RtlHelper.getChevronIcon()` or `RtlHelper.getBackIcon()`

### Issue 2: Padding Wrong Side

**Problem:** Padding appears on wrong side in RTL

**Fix:** Use `EdgeInsetsDirectional` instead of `EdgeInsets`

### Issue 3: Alignment Wrong

**Problem:** Content aligns incorrectly in RTL

**Fix:** Use `RtlHelper.getStartAlignment()` or `RtlHelper.getEndAlignment()`

### Issue 4: Hardcoded Directions

**Problem:** Using `left:` or `right:` in EdgeInsets

**Fix:** Use `start:` and `end:` in `EdgeInsetsDirectional`

---

## 📚 Best Practices

1. **Always Use Directional Widgets**
   - `EdgeInsetsDirectional` over `EdgeInsets`
   - `AlignmentDirectional` over `Alignment` (when needed)

2. **Use RTL Helper for Icons**
   - Navigation icons (chevrons, arrows)
   - Back buttons
   - Any directional icons

3. **Test in Both Languages**
   - Always test UI in English and Arabic
   - Verify layout looks correct in both

4. **Avoid Hardcoded Directions**
   - Don't use `left:` or `right:` directly
   - Use `start:` and `end:` instead

5. **Use Text Direction Aware Widgets**
   - `TextDirection.rtl` for Arabic
   - `TextDirection.ltr` for English

---

## 🔗 Related Files

- `lib/core/utils/rtl_helper.dart` - RTL helper utilities
- `lib/core/services/localization_service.dart` - Language detection
- `lib/modules/profile/controller/localization_controller.dart` - Language switching
- `lib/main.dart` - App-level RTL configuration

---

## 📝 Summary

✅ **RTL Support is Fully Implemented**

- GetMaterialApp handles RTL automatically
- RTL Helper provides utilities for icons and layouts
- Profile screens updated with RTL-aware widgets
- Expanded translations for common UI elements

**Next Steps:**
- Apply RTL helpers to other screens as needed
- Continue adding translations throughout the app
- Test all screens in both languages

---

**Last Updated:** November 2025  
**Status:** ✅ Complete and Ready for Use

