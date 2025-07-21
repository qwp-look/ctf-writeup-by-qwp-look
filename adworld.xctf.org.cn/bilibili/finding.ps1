# Set UTF-8 encoding for compatibility
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Target website configuration
$baseUrl = "http://223.112.5.141:65401"
$maxPages = 1000
$found = $false

# User agent string
$userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"

# Start search
Write-Host "`n[*] Starting search on $baseUrl..." -ForegroundColor Cyan
Write-Host "[*] Scanning up to $maxPages pages..." -ForegroundColor Cyan
Write-Host "`nProgress:" -ForegroundColor Yellow

# Main loop
for ($page = 1; $page -le $maxPages; $page++) {
    $url = "$baseUrl/shop?page=$page"
    
    # Show progress
    if ($page % 10 -eq 0) {
        Write-Host "  Checked: $page pages" -ForegroundColor Gray
    }
    
    try {
        # Send HTTP request
        $response = Invoke-WebRequest -Uri $url -UserAgent $userAgent -TimeoutSec 5 -ErrorAction Stop
        
        # Check content
        if ($response.StatusCode -eq 200) {
            if ($response.Content -match "lv6\.png") {
                Write-Host "`n[SUCCESS] Found lv6.png on page $page!" -ForegroundColor Green
                Write-Host "[LINK] $url" -ForegroundColor Green
                $found = $true
                break
            }
        }
        else {
            Write-Host "  [WARNING] Page $page returned status: $($response.StatusCode)" -ForegroundColor Yellow
        }
    }
    catch [System.Net.WebException] {
        # 修复变量引用问题
        $msg = $_.Exception.Message
        Write-Host "  [ERROR] Request failed for page $page : $msg" -ForegroundColor Red
        Start-Sleep -Milliseconds 500
    }
    catch {
        # 修复变量引用问题
        $msg = $_.Exception.Message
        Write-Host "  [ERROR] Unknown error for page $page : $msg" -ForegroundColor Red
        Start-Sleep -Milliseconds 500
    }
    
    # Add small delay
    Start-Sleep -Milliseconds 100
}

# Result output
if (-not $found) {
    Write-Host "`n[RESULT] lv6.png not found in the first $maxPages pages" -ForegroundColor Yellow
    Write-Host "[SUGGESTION] Try increasing max pages or check website status" -ForegroundColor Yellow
}

# Keep window open
Write-Host "`nPress any key to exit..." -ForegroundColor Gray
$null = [Console]::ReadKey($true)