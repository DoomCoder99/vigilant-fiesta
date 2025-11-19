#!/usr/bin/env python3
"""
Download All Project Images from Figma
Downloads all images defined in all_project_images.json to their correct asset directories.
"""

import json
import os
import urllib.request
from pathlib import Path
import sys

def download_image(url, filepath):
    """Download an image from URL to filepath."""
    try:
        # Create directory if it doesn't exist
        os.makedirs(os.path.dirname(filepath), exist_ok=True)
        
        # Download the image
        print(f"Downloading: {os.path.basename(filepath)}...")
        urllib.request.urlretrieve(url, filepath)
        print(f"[OK] Saved to: {filepath}")
        return True
    except Exception as e:
        print(f"[ERROR] Error downloading {os.path.basename(filepath)}: {e}")
        return False

def main():
    # Get the project root directory
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    
    # Load the JSON file
    json_path = script_dir / "all_project_images.json"
    
    if not json_path.exists():
        print(f"Error: {json_path} not found!")
        sys.exit(1)
    
    with open(json_path, 'r') as f:
        data = json.load(f)
    
    print("=" * 60)
    print("DOWNLOADING ALL PROJECT IMAGES FROM FIGMA")
    print("=" * 60)
    print(f"Generated: {data.get('generated_date', 'Unknown')}")
    print(f"Note: {data.get('note', '')}")
    print("=" * 60)
    
    modules = data.get('modules', {})
    
    total_images = 0
    downloaded = 0
    failed = 0
    
    # Process Module 3 - Service Booking
    if 'module3_service_booking' in modules:
        print("\n[MODULE 3: SERVICE BOOKING]")
        print("-" * 60)
        
        module = modules['module3_service_booking']
        
        # Home Maintenance Categories
        if 'home_maintenance_categories' in module:
            print("\n  > Home Maintenance Categories")
            for filename, url in module['home_maintenance_categories'].items():
                total_images += 1
                filepath = project_root / "assets" / "service_booking" / filename
                if download_image(url, filepath):
                    downloaded += 1
                else:
                    failed += 1
        
        # Electrical Services Screen
        if 'electrical_services_screen' in module:
            print("\n  > Electrical Services Screen")
            for filename, url in module['electrical_services_screen'].items():
                total_images += 1
                filepath = project_root / "assets" / "service_booking" / filename
                if download_image(url, filepath):
                    downloaded += 1
                else:
                    failed += 1
        
        # Service Detail Screen
        if 'service_detail_screen' in module:
            print("\n  > Service Detail Screen")
            for filename, url in module['service_detail_screen'].items():
                total_images += 1
                # star_1.png goes to images directory
                if filename == 'star_1.png':
                    filepath = project_root / "assets" / "images" / filename
                else:
                    filepath = project_root / "assets" / "service_booking" / filename
                if download_image(url, filepath):
                    downloaded += 1
                else:
                    failed += 1
        
        # Add-ons Screen
        if 'addons_screen' in module:
            print("\n  > Add-ons Screen")
            for filename, url in module['addons_screen'].items():
                total_images += 1
                filepath = project_root / "assets" / "service_booking" / filename
                if download_image(url, filepath):
                    downloaded += 1
                else:
                    failed += 1
        
        # Common Icons
        if 'common_icons' in module:
            print("\n  > Common Icons (Module 3)")
            for filename, url in module['common_icons'].items():
                total_images += 1
                # Common icons go to both directories
                if filename == 'icon_back_arrow.png':
                    filepath = project_root / "assets" / "images" / filename
                else:
                    filepath = project_root / "assets" / "service_booking" / filename
                if download_image(url, filepath):
                    downloaded += 1
                else:
                    failed += 1
    
    # Common Status Bar Icons
    if 'common_status_bar' in modules:
        print("\n[COMMON: STATUS BAR ICONS]")
        print("-" * 60)
        for filename, url in modules['common_status_bar'].items():
            total_images += 1
            filepath = project_root / "assets" / "images" / filename
            if download_image(url, filepath):
                downloaded += 1
            else:
                failed += 1
    
    # Common Address Form Icons
    if 'common_address_form' in modules:
        print("\n[COMMON: ADDRESS FORM ICONS]")
        print("-" * 60)
        for filename, url in modules['common_address_form'].items():
            total_images += 1
            filepath = project_root / "assets" / "images" / filename
            if download_image(url, filepath):
                downloaded += 1
            else:
                failed += 1
    
    # Module 3 Add Location
    if 'module3_add_location' in modules:
        print("\n[MODULE 3: ADD LOCATION]")
        print("-" * 60)
        for filename, url in modules['module3_add_location'].items():
            total_images += 1
            if filename == 'map_farwaniyah.png':
                filepath = project_root / "assets" / "service_booking" / "maps" / filename
            else:
                filepath = project_root / "assets" / "service_booking" / filename
            if download_image(url, filepath):
                downloaded += 1
            else:
                failed += 1
    
    # Module 3 Add Address
    if 'module3_add_address' in modules:
        print("\n[MODULE 3: ADD ADDRESS]")
        print("-" * 60)
        for filename, url in modules['module3_add_address'].items():
            total_images += 1
            filepath = project_root / "assets" / "service_booking" / filename
            if download_image(url, filepath):
                downloaded += 1
            else:
                failed += 1
    
    # Module 3 Add Address Confirmation
    if 'module3_add_address_confirmation' in modules:
        print("\n[MODULE 3: ADD ADDRESS CONFIRMATION]")
        print("-" * 60)
        for filename, url in modules['module3_add_address_confirmation'].items():
            total_images += 1
            filepath = project_root / "assets" / "service_booking" / filename
            if download_image(url, filepath):
                downloaded += 1
            else:
                failed += 1
    
    # Module 3 Payment Cart
    if 'module3_payment_cart' in modules:
        print("\n[MODULE 3: PAYMENT CART]")
        print("-" * 60)
        for filename, url in modules['module3_payment_cart'].items():
            total_images += 1
            filepath = project_root / "assets" / "service_booking" / filename
            if download_image(url, filepath):
                downloaded += 1
            else:
                failed += 1
    
    # Module 3 Payment Method
    if 'module3_payment_method' in modules:
        print("\n[MODULE 3: PAYMENT METHOD]")
        print("-" * 60)
        for filename, url in modules['module3_payment_method'].items():
            total_images += 1
            filepath = project_root / "assets" / "service_booking" / "payment" / filename
            if download_image(url, filepath):
                downloaded += 1
            else:
                failed += 1
    
    # Module 3 Payment Success
    if 'module3_payment_success' in modules:
        print("\n[MODULE 3: PAYMENT SUCCESS]")
        print("-" * 60)
        for filename, url in modules['module3_payment_success'].items():
            total_images += 1
            filepath = project_root / "assets" / "service_booking" / "payment" / filename
            if download_image(url, filepath):
                downloaded += 1
            else:
                failed += 1
    
    # Print summary
    print("\n" + "=" * 60)
    print("DOWNLOAD SUMMARY")
    print("=" * 60)
    print(f"Total images: {total_images}")
    print(f"[OK] Downloaded: {downloaded}")
    print(f"[FAIL] Failed: {failed}")
    print("=" * 60)
    
    if failed == 0:
        print("\n[OK] All images downloaded successfully!")
        return 0
    else:
        print(f"\n[WARNING] {failed} image(s) failed to download. Check errors above.")
        return 1

if __name__ == "__main__":
    sys.exit(main())

