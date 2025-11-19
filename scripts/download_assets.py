#!/usr/bin/env python3
"""
Figma Asset Download Script

Downloads assets from Figma MCP asset URLs and saves them to assets/images/ directory.
Asset URLs expire after 7 days - regenerate by running Figma MCP get_design_context.

Usage:
    python scripts/download_assets.py
"""

import json
import os
import requests
from pathlib import Path
from typing import Dict, Any

# Configuration
SCRIPT_DIR = Path(__file__).parent
PROJECT_ROOT = SCRIPT_DIR.parent
ASSETS_DIR = PROJECT_ROOT / "assets" / "images"
ASSET_URLS_FILE = SCRIPT_DIR / "figma_asset_urls.json"

def ensure_assets_directory():
    """Create assets directory if it doesn't exist"""
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    print(f"✓ Assets directory: {ASSETS_DIR}")

def load_asset_urls() -> Dict[str, Any]:
    """Load asset URLs from JSON file"""
    try:
        with open(ASSET_URLS_FILE, 'r', encoding='utf-8') as f:
            data = json.load(f)
        print(f"✓ Loaded asset URLs from {ASSET_URLS_FILE}")
        return data
    except FileNotFoundError:
        print(f"✗ Error: {ASSET_URLS_FILE} not found")
        return {}
    except json.JSONDecodeError as e:
        print(f"✗ Error parsing JSON: {e}")
        return {}

def download_asset(filename: str, url: str) -> bool:
    """Download a single asset from URL"""
    try:
        print(f"  Downloading {filename}...", end=" ", flush=True)
        response = requests.get(url, timeout=30)
        
        if response.status_code == 200:
            file_path = ASSETS_DIR / filename
            with open(file_path, 'wb') as f:
                f.write(response.content)
            
            file_size = len(response.content)
            print(f"✓ ({file_size:,} bytes)")
            return True
        else:
            print(f"✗ HTTP {response.status_code}")
            return False
            
    except requests.exceptions.Timeout:
        print("✗ Timeout")
        return False
    except requests.exceptions.RequestException as e:
        print(f"✗ Error: {e}")
        return False
    except Exception as e:
        print(f"✗ Unexpected error: {e}")
        return False

def download_all_assets():
    """Download all assets from the JSON file"""
    ensure_assets_directory()
    data = load_asset_urls()
    
    if not data or "assets" not in data:
        print("✗ No asset URLs found in JSON file")
        return
    
    print(f"\n{'='*60}")
    print("Figma Asset Downloader")
    print(f"{'='*60}\n")
    
    if "note" in data:
        print(f"Note: {data['note']}\n")
    
    total_downloaded = 0
    total_failed = 0
    
    # Download assets from each category
    for category, assets in data["assets"].items():
        print(f"Category: {category.replace('_', ' ').title()}")
        print("-" * 60)
        
        for filename, url in assets.items():
            if download_asset(filename, url):
                total_downloaded += 1
            else:
                total_failed += 1
        
        print()
    
    # Summary
    print(f"{'='*60}")
    print(f"Summary:")
    print(f"  ✓ Downloaded: {total_downloaded}")
    print(f"  ✗ Failed: {total_failed}")
    print(f"  Total: {total_downloaded + total_failed}")
    print(f"{'='*60}\n")
    
    if total_downloaded > 0:
        print(f"✓ Assets saved to: {ASSETS_DIR}")
        print("\nNext steps:")
        print("  1. Run 'flutter pub get'")
        print("  2. Verify assets in the app")
        print("  3. Check for any missing assets")

if __name__ == "__main__":
    try:
        download_all_assets()
    except KeyboardInterrupt:
        print("\n\n✗ Download cancelled by user")
    except Exception as e:
        print(f"\n✗ Fatal error: {e}")

