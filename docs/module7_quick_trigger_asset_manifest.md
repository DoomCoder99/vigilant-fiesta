# Module 7: Quick Trigger - Asset Manifest

This document lists all image assets extracted from Figma frames for the Quick Trigger module.

## Asset Directory Structure

All Quick Trigger assets are stored under: `assets/quick_trigger/`

## Image Assets

### Agent & User Avatars

| Figma Node ID | Asset Path | Usage | States |
|---------------|------------|-------|--------|
| 1:23053 (animoji) | `assets/quick_trigger/agent_avatar.png` | Agent avatar in service info overlay | onTheDay, onCompletion |
| 1:24881 (animoji) | `assets/quick_trigger/agent_avatar.png` | Agent avatar (minimized state) | minimized |

### Icons

| Figma Node ID | Asset Path | Usage | States |
|---------------|------------|-------|--------|
| 1:25059 (Group) | `assets/quick_trigger/lightning_icon.png` | Floating button icon | minimized |
| 1:23045 (hide) | `assets/quick_trigger/hide_icon.png` | Minimize/close button | onTheDay, onCompletion, thanks |
| 1:23061 (Star 1) | `assets/quick_trigger/star_icon.png` | Rating star icon | onTheDay |
| 1:23063 (sheild 1) | `assets/quick_trigger/shield_icon.png` | Verified badge icon | onTheDay |
| 1:23079 (shopping_cart) | `assets/quick_trigger/shopping_cart_icon.png` | Add-ons button icon | onTheDay |
| 1:23088 (call) | `assets/quick_trigger/call_icon.png` | Call button icon | onTheDay |

### Decorative Images

| Figma Node ID | Asset Path | Usage | States |
|---------------|------------|-------|--------|
| 1:24465 (confetti) | `assets/quick_trigger/confetti_icon.png` | Celebration/thanks decorative image | thanks |

## Figma Frame References

### Frame 1: Service information - on the day (node-id: 1-22819)
- Agent avatar: `1:23053`
- Hide icon: `1:23045`
- Star icon: `1:23061`
- Shield icon: `1:23063`
- Shopping cart icon: `1:23079`
- Call icon: `1:23088`

### Frame 2: Service information - minimized (node-id: 1-24836)
- Lightning icon: `1:25059`

### Frame 3-7: Service information - on completion (node-ids: 1-23365, 1-23637, 1-23904, 1-23091, 1-24183)
- Hide icon: `1:23045` (reused from on-the-day frame)

### Frame 8: Service information - thanks (node-id: 1-24465)
- Confetti icon: Decorative celebration image

## Image Export Instructions

1. **Agent Avatar**: Export as PNG at 2x resolution (80x80px for 40x40dp display)
2. **Icons**: Export as PNG at 2x resolution:
   - Lightning icon: 64x64px (for 32x32dp display)
   - Hide icon: 40x40px (for 20x20dp display)
   - Star icon: 16x16px (for 8x8dp display)
   - Shield icon: 40x40px (for 20x20dp display)
   - Shopping cart icon: 32x32px (for 16x16dp display)
   - Call icon: 32x32px (for 16x16dp display)
3. **Confetti Icon**: Export as PNG at 2x resolution (256x256px for 128x128dp display)

## Figma Asset URLs (Temporary - 7 days)

These URLs are available for 7 days from Figma MCP. Download and save to local assets:

- Agent avatar: `https://www.figma.com/api/mcp/asset/1402c0af-558c-4b02-b556-a63022519e22`
- Lightning icon: `https://www.figma.com/api/mcp/asset/f26b5ba0-cf93-4407-a47a-7c5b8ab2322c`
- Hide icon: `https://www.figma.com/api/mcp/asset/0c0a6c60-0b6d-4975-9aff-0d3bda72ff89`
- Star icon: `https://www.figma.com/api/mcp/asset/a86f3d95-2053-49f3-8317-09741c1c64af`
- Shield icon: `https://www.figma.com/api/mcp/asset/1731131b-ce23-493a-8956-6df7cefc68eb`
- Shopping cart icon: `https://www.figma.com/api/mcp/asset/abdfaaac-856b-49d9-ad01-b987f9737dfe`
- Call icon: `https://www.figma.com/api/mcp/asset/79ca1ecd-4b96-4a40-9a05-0cc7498b4806`
- Confetti icon: `https://www.figma.com/api/mcp/asset/954c3b07-fc01-4753-b164-f113e6251609`

## Notes

- All images should be exported at 2x resolution for retina displays
- Use PNG format for icons and avatars
- Ensure images are optimized for mobile (compressed but maintain quality)
- Fallback icons are provided in code using Material Icons if assets are missing

