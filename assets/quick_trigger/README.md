# Quick Trigger Assets

This directory contains image assets for the Quick Trigger module.

## Required Assets

Place the following PNG files in this directory:

- `agent_avatar.png` - Agent profile picture (80x80px @2x)
- `lightning_icon.png` - Floating button icon (64x64px @2x)
- `hide_icon.png` - Minimize/close button (40x40px @2x)
- `star_icon.png` - Rating star icon (16x16px @2x)
- `shield_icon.png` - Verified badge icon (40x40px @2x)
- `shopping_cart_icon.png` - Add-ons button icon (32x32px @2x)
- `call_icon.png` - Call button icon (32x32px @2x)
- `confetti_icon.png` - Thanks state decorative image (256x256px @2x)

## Download Instructions

### Option 1: Use the Download Script

Run the script from the project root:
```bash
./scripts/download_quick_trigger_assets.sh
```

### Option 2: Manual Export from Figma

1. Open Figma file: `xu7kp6yBV1qiPwK77Hq7tl`
2. Use node IDs from `docs/module7_quick_trigger_asset_manifest.md`
3. Export each asset at 2x resolution as PNG
4. Save to this directory

### Option 3: Use Temporary Figma URLs

URLs are available in `docs/module7_quick_trigger_asset_manifest.md` (valid for 7 days).

## Fallback Icons

The code includes fallback Material Icons if assets are missing, so the app will function without these assets, but visual fidelity will be reduced.

