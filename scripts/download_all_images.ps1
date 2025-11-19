# Download All Project Images from Figma
# PowerShell script to download all images defined in all_project_images.json

$ErrorActionPreference = "Stop"

# Get paths
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir
$jsonPath = Join-Path $scriptDir "all_project_images.json"

# Check if JSON file exists
if (-not (Test-Path $jsonPath)) {
    Write-Error "Error: $jsonPath not found!"
    exit 1
}

# Load JSON
$data = Get-Content $jsonPath -Raw | ConvertFrom-Json

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "DOWNLOADING ALL PROJECT IMAGES FROM FIGMA" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Generated: $($data.generated_date)"
Write-Host "Note: $($data.note)"
Write-Host "============================================================" -ForegroundColor Cyan

$totalImages = 0
$downloaded = 0
$failed = 0

function Download-Image {
    param(
        [string]$url,
        [string]$filepath
    )
    
    try {
        # Create directory if it doesn't exist
        $dir = Split-Path -Parent $filepath
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
        }
        
        # Download the image
        $filename = Split-Path -Leaf $filepath
        Write-Host "  Downloading: $filename..." -NoNewline
        
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($url, $filepath)
        
        Write-Host " OK" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host " FAILED" -ForegroundColor Red
        Write-Host "    Error: $_" -ForegroundColor Red
        return $false
    }
}

# Process Module 3 - Service Booking
if ($data.modules.PSObject.Properties.Name -contains 'module3_service_booking') {
    Write-Host ""
    Write-Host "MODULE 3: SERVICE BOOKING" -ForegroundColor Yellow
    Write-Host "------------------------------------------------------------"
    
    $module = $data.modules.module3_service_booking
    
    # Home Maintenance Categories
    if ($module.PSObject.Properties.Name -contains 'home_maintenance_categories') {
        Write-Host ""
        Write-Host "  Home Maintenance Categories" -ForegroundColor White
        foreach ($prop in $module.home_maintenance_categories.PSObject.Properties) {
            $totalImages++
            $filepath = Join-Path $projectRoot "assets\service_booking\$($prop.Name)"
            if (Download-Image -url $prop.Value -filepath $filepath) {
                $downloaded++
            }
            else {
                $failed++
            }
        }
    }
    
    # Electrical Services Screen
    if ($module.PSObject.Properties.Name -contains 'electrical_services_screen') {
        Write-Host ""
        Write-Host "  Electrical Services Screen" -ForegroundColor White
        foreach ($prop in $module.electrical_services_screen.PSObject.Properties) {
            $totalImages++
            $filepath = Join-Path $projectRoot "assets\service_booking\$($prop.Name)"
            if (Download-Image -url $prop.Value -filepath $filepath) {
                $downloaded++
            }
            else {
                $failed++
            }
        }
    }
    
    # Service Detail Screen
    if ($module.PSObject.Properties.Name -contains 'service_detail_screen') {
        Write-Host ""
        Write-Host "  Service Detail Screen" -ForegroundColor White
        foreach ($prop in $module.service_detail_screen.PSObject.Properties) {
            $totalImages++
            # star_1.png goes to images directory
            if ($prop.Name -eq 'star_1.png') {
                $filepath = Join-Path $projectRoot "assets\images\$($prop.Name)"
            }
            else {
                $filepath = Join-Path $projectRoot "assets\service_booking\$($prop.Name)"
            }
            if (Download-Image -url $prop.Value -filepath $filepath) {
                $downloaded++
            }
            else {
                $failed++
            }
        }
    }
    
    # Add-ons Screen
    if ($module.PSObject.Properties.Name -contains 'addons_screen') {
        Write-Host ""
        Write-Host "  Add-ons Screen" -ForegroundColor White
        foreach ($prop in $module.addons_screen.PSObject.Properties) {
            $totalImages++
            $filepath = Join-Path $projectRoot "assets\service_booking\$($prop.Name)"
            if (Download-Image -url $prop.Value -filepath $filepath) {
                $downloaded++
            }
            else {
                $failed++
            }
        }
    }
    
    # Common Icons
    if ($module.PSObject.Properties.Name -contains 'common_icons') {
        Write-Host ""
        Write-Host "  Common Icons (Module 3)" -ForegroundColor White
        foreach ($prop in $module.common_icons.PSObject.Properties) {
            $totalImages++
            # Common icons go to appropriate directories
            if ($prop.Name -eq 'icon_back_arrow.png') {
                $filepath = Join-Path $projectRoot "assets\images\$($prop.Name)"
            }
            else {
                $filepath = Join-Path $projectRoot "assets\service_booking\$($prop.Name)"
            }
            if (Download-Image -url $prop.Value -filepath $filepath) {
                $downloaded++
            }
            else {
                $failed++
            }
        }
    }
}

# Common Status Bar Icons
if ($data.modules.PSObject.Properties.Name -contains 'common_status_bar') {
    Write-Host ""
    Write-Host "COMMON: STATUS BAR ICONS" -ForegroundColor Yellow
    Write-Host "------------------------------------------------------------"
    foreach ($prop in $data.modules.common_status_bar.PSObject.Properties) {
        $totalImages++
        $filepath = Join-Path $projectRoot "assets\images\$($prop.Name)"
        if (Download-Image -url $prop.Value -filepath $filepath) {
            $downloaded++
        }
        else {
            $failed++
        }
    }
}

# Common Address Form Icons
if ($data.modules.PSObject.Properties.Name -contains 'common_address_form') {
    Write-Host ""
    Write-Host "COMMON: ADDRESS FORM ICONS" -ForegroundColor Yellow
    Write-Host "------------------------------------------------------------"
    foreach ($prop in $data.modules.common_address_form.PSObject.Properties) {
        $totalImages++
        $filepath = Join-Path $projectRoot "assets\images\$($prop.Name)"
        if (Download-Image -url $prop.Value -filepath $filepath) {
            $downloaded++
        }
        else {
            $failed++
        }
    }
}

# Print summary
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "DOWNLOAD SUMMARY" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Total images: $totalImages"
Write-Host "Downloaded: $downloaded" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor $(if ($failed -eq 0) { "Green" } else { "Red" })
Write-Host "============================================================" -ForegroundColor Cyan

if ($failed -eq 0) {
    Write-Host ""
    Write-Host "All images downloaded successfully!" -ForegroundColor Green
    exit 0
}
else {
    Write-Host ""
    Write-Host "$failed image(s) failed to download. Check errors above." -ForegroundColor Yellow
    exit 1
}

