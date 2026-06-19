param (
    [Parameter(Mandatory=$true)]
    [string]$TargetProcess
)

# Define installation path for UWPSpy (C:\Utilities\UWPSpy)
$truePath = "C:\Utilities\UWPSpy"
if (Test-Path $truePath) {
    Set-Location $truePath
    $workingPath = $truePath
} else {
    Write-Host "[WARNING] Expected UWPSpy installation path not found at: $truePath" -ForegroundColor Yellow
    Write-Host "Attempting to continue with current working directory: $PSScriptRoot" -ForegroundColor Yellow
    $workingPath = $PSScriptRoot
}

# Define the log file destination path using the verified absolute path
$LogFile = Join-Path $workingPath "SpyHistory.log"

# Clean up the string to find the base process name safely
$baseName = $TargetProcess -replace '\.exe$', ''

Write-Host "[INFO] Verifying target state for: $TargetProcess" -ForegroundColor Cyan
$runningProcesses = Get-Process -Name $baseName -ErrorAction SilentlyContinue

if (-not $runningProcesses) {
    Write-Host "[INFO] Target process is not currently active. Launching: $TargetProcess" -ForegroundColor Yellow
    try {
        Start-Process $TargetProcess -ErrorAction Stop
        Start-Sleep -Seconds 2
    } catch {
        $errorMsg = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] [FAILED] Tried to target '$TargetProcess' but the application failed to start."
        Add-Content -Path $LogFile -Value $errorMsg
        Write-Error "Failed to execute or spawn target application pipeline: $_"
        exit 1
    }
} else {
    Write-Host "[SUCCESS] Active instance of $baseName found running on the host system." -ForegroundColor Green
}

# Fire up UWPSpy using the explicit true absolute directory path
Write-Host "[INFO] Launching inspection workspace via UWPSpy.exe..." -ForegroundColor Cyan
$targetExe = Join-Path $workingPath "UWPSpy.exe"

if (Test-Path $targetExe) {
    Start-Process $targetExe
    Start-Sleep -Seconds 2
} else {
    $errorMsg = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] [FAILED] UWPSpy.exe was missing from the directory ($workingPath) while attempting to hook '$TargetProcess'."
    Add-Content -Path $LogFile -Value $errorMsg
    Write-Error "UWPSpy.exe not found in the verified target directory."
    exit 1
}

# Create a clean Shell Object for user interface interaction
$wshell = New-Object -ComObject WScript.Shell

# Bring UWPSpy to active window focus
$maxAttempts = 10
$focused = $false

for ($i = 1; $i -le $maxAttempts; $i++) {
    if ($wshell.AppActivate("UWPSpy")) {
        $focused = $true
        break
    }
    Start-Sleep -Milliseconds 500
}

if (-not $focused) {
    $errorMsg = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] [FAILED] UWPSpy interface opened but script timed out trying to focus window for '$TargetProcess'."
    Add-Content -Path $LogFile -Value $errorMsg
    Write-Error "Could not focus or bind to the UWPSpy window layout."
    exit 1
}

# Inject your specific target text into the inspector UI
Start-Sleep -Milliseconds 300
$wshell.SendKeys($TargetProcess)
Start-Sleep -Milliseconds 200
$wshell.SendKeys("{TAB}")
Start-Sleep -Milliseconds 100
$wshell.SendKeys("{ENTER}")

# Log the successful injection event to your tracking file
$successMsg = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] [SUCCESS] Successfully injected and attached to process: $TargetProcess"
Add-Content -Path $LogFile -Value $successMsg

Write-Host "[SUCCESS] Automation attachment sequence completed for target: $TargetProcess" -ForegroundColor Green
