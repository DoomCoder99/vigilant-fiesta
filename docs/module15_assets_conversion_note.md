# Module 15: Support Chat Assets - Format Note

## Current Status

✅ **Assets Downloaded**: All 10 icon assets have been successfully downloaded from Figma  
⚠️ **Format**: Assets are currently in **SVG format** (not PNG)

## Issue

The downloaded assets are SVG files but have `.png` extensions. Flutter's `Image.asset()` cannot directly render SVG content.

## Solutions

### Option 1: Convert SVG to PNG (Recommended)

Convert the SVG files to PNG format for direct use with `Image.asset()`:

**Using librsvg (macOS/Linux):**
```bash
brew install librsvg
cd assets/support_chat
for file in *.png; do
  if file "$file" | grep -q "SVG"; then
    rsvg-convert -w 32 -h 32 "$file" -o "${file%.png}_converted.png"
    mv "${file%.png}_converted.png" "$file"
  fi
done
```

**Using Inkscape:**
```bash
brew install inkscape
cd assets/support_chat
for file in *.png; do
  if file "$file" | grep -q "SVG"; then
    inkscape "$file" --export-type=png --export-filename="${file}" -w 32 -h 32
  fi
done
```

**Using Online Converter:**
- Upload SVG files to https://cloudconvert.com/svg-to-png
- Download PNG versions
- Replace files in `assets/support_chat/`

### Option 2: Use flutter_svg Package

Keep SVG files and update code to use `SvgPicture.asset()`:

1. ✅ Already added `flutter_svg: ^2.0.9` to `pubspec.yaml`
2. Update imports: `import 'package:flutter_svg/flutter_svg.dart';`
3. Replace `Image.asset()` with `SvgPicture.asset()` for support_chat icons
4. Rename files back to `.svg` extension

**Example:**
```dart
// Before
Image.asset('assets/support_chat/icon_add.png', ...)

// After
SvgPicture.asset('assets/support_chat/icon_add.svg', ...)
```

## Current Behavior

The code includes `errorBuilder` callbacks that provide Material Icons fallbacks, so the app will function correctly even with SVG files. However, visual fidelity will be reduced until proper PNG conversion or SVG support is implemented.

## Recommendation

**Convert to PNG** for consistency with the rest of the project and simpler code maintenance.

## Files Affected

All files in `assets/support_chat/`:
- icon_add.png (SVG content)
- icon_check.png (SVG content)
- icon_check_circle.png (SVG content)
- icon_check_done_all.png (SVG content)
- icon_download.png (SVG content)
- icon_flag.png (SVG content)
- icon_keyboard_double_arrow_up.png (SVG content)
- icon_mic.png (SVG content)
- icon_more_vert.png (SVG content)
- icon_stat_2.png (SVG content)

## Verification

After conversion, verify with:
```bash
file assets/support_chat/*.png
```

All files should show "PNG image" not "SVG".

