#Requires -Version 5.1
<#
.SYNOPSIS
  Verify the Negarit AI Windows toolchain and print a pass/fail table.

.DESCRIPTION
  Checks tools required for the Flutter + NestJS + PostgreSQL MVP.
  Optional tools are reported and do not fail the script.
  Exit code 0 when every required check passes, 1 otherwise.

  Open a new terminal after installing tools so PATH changes are visible.
#>
$ErrorActionPreference = "Continue"

$sdk = $env:ANDROID_HOME
if (-not $sdk) { $sdk = $env:ANDROID_SDK_ROOT }
if (-not $sdk) { $sdk = Join-Path $env:LOCALAPPDATA "Android\Sdk" }

$pgRoot = "C:\Program Files\PostgreSQL\18"

$script:rows = New-Object System.Collections.Generic.List[object]

function Add-Check {
    param(
        [string]$Name,
        [bool]$Ok,
        [string]$Detail,
        [bool]$Required = $true
    )
    $result = if ($Ok) { "PASS" } elseif ($Required) { "FAIL" } else { "SKIP" }
    $script:rows.Add([pscustomobject]@{
        Check    = $Name
        Result   = $result
        Required = $(if ($Required) { "yes" } else { "no" })
        Detail   = ($Detail -replace "\s+", " ").Trim()
    }) | Out-Null
}

function Get-CommandText {
    param(
        [string]$Command,
        [string[]]$Arguments
    )
    $cmd = Get-Command $Command -ErrorAction SilentlyContinue
    if (-not $cmd) {
        return $null
    }
    $output = & $cmd.Source @Arguments 2>&1 | ForEach-Object {
        if ($_ -is [System.Management.Automation.ErrorRecord]) { $_.Exception.Message } else { "$_" }
    }
    $line = ($output | Where-Object { $_.Trim() } | Select-Object -First 1)
    if (-not $line) { $line = $cmd.Source }
    return $line.Trim()
}

$git = Get-CommandText "git" @("--version")
Add-Check "Git" ($null -ne $git) $(if ($git) { $git } else { "not on PATH" })

$flutter = Get-CommandText "flutter" @("--version")
Add-Check "Flutter" ($null -ne $flutter) $(if ($flutter) { $flutter } else { "not on PATH" })

$dart = Get-CommandText "dart" @("--version")
Add-Check "Dart" ($null -ne $dart) $(if ($dart) { $dart } else { "not on PATH" })

$javaHome = $env:JAVA_HOME
$javaOk = $false
$javaDetail = "JAVA_HOME is not set"
if ($javaHome -and (Test-Path (Join-Path $javaHome "bin\java.exe"))) {
    $javaLine = Get-CommandText "java" @("-version")
    $javaOk = $javaLine -match "17\."
    $javaDetail = "JAVA_HOME=$javaHome; $javaLine"
    if (-not $javaOk -and $javaLine) {
        $javaDetail = "JDK 17 required. $javaDetail"
    }
}
Add-Check "JDK 17" $javaOk $javaDetail

$androidHomeOk = Test-Path $sdk
Add-Check "ANDROID_HOME" $androidHomeOk $(if ($androidHomeOk) { $sdk } else { "Android SDK directory not found" })

$adb = Get-CommandText "adb" @("version")
if (-not $adb -and (Test-Path (Join-Path $sdk "platform-tools\adb.exe"))) {
    $adb = (& (Join-Path $sdk "platform-tools\adb.exe") version 2>&1 | Select-Object -First 1)
}
Add-Check "adb" ($null -ne $adb) $(if ($adb) { $adb } else { "platform-tools not installed" })

$sdkmanager = Join-Path $sdk "cmdline-tools\latest\bin\sdkmanager.bat"
Add-Check "sdkmanager" (Test-Path $sdkmanager) $(if (Test-Path $sdkmanager) { $sdkmanager } else { "cmdline-tools\latest missing" })

$platform = Join-Path $sdk "platforms\android-36"
Add-Check "Android platform 36" (Test-Path $platform) $(if (Test-Path $platform) { $platform } else { "platforms;android-36 missing" })

$buildTools = Join-Path $sdk "build-tools\36.0.0"
Add-Check "Android build-tools 36.0.0" (Test-Path $buildTools) $(if (Test-Path $buildTools) { $buildTools } else { "build-tools;36.0.0 missing" })

$node = Get-CommandText "node" @("-v")
Add-Check "Node.js" ($null -ne $node) $(if ($node) { $node } else { "not on PATH" })

$npm = Get-CommandText "npm" @("-v")
Add-Check "npm" ($null -ne $npm) $(if ($npm) { $npm } else { "not on PATH" })

$nest = Get-CommandText "nest" @("--version")
Add-Check "NestJS CLI" ($null -ne $nest) $(if ($nest) { $nest } else { "not on PATH; npm install -g @nestjs/cli" })

$psql = Get-CommandText "psql" @("--version")
if (-not $psql -and (Test-Path (Join-Path $pgRoot "bin\psql.exe"))) {
    $psql = "found at $pgRoot\bin\psql.exe but not on PATH"
    Add-Check "psql" $false $psql
} else {
    Add-Check "psql" ($null -ne $psql) $(if ($psql) { $psql } else { "PostgreSQL client not installed" })
}

$postgis = Join-Path $pgRoot "share\extension\postgis.control"
Add-Check "PostGIS files" (Test-Path $postgis) $(if (Test-Path $postgis) { $postgis } else { "postgis.control missing under $pgRoot" })

$vector = Join-Path $pgRoot "share\extension\vector.control"
Add-Check "pgvector files" (Test-Path $vector) $(if (Test-Path $vector) { "$vector (community Windows build until CREATE EXTENSION is verified)" } else { "vector.control missing under $pgRoot" })

$python = Get-CommandText "python" @("--version")
Add-Check "Python (optional)" ($null -ne $python) $(if ($python) { $python } else { "not installed" }) $false

$gh = Get-CommandText "gh" @("--version")
Add-Check "GitHub CLI (optional)" ($null -ne $gh) $(if ($gh) { $gh } else { "not installed" }) $false

$docker = Get-CommandText "docker" @("--version")
Add-Check "Docker (optional, not used)" ($null -ne $docker) $(if ($docker) { $docker } else { "not installed; native PostgreSQL is the local database" }) $false

$rows | Format-Table -AutoSize -Wrap | Out-String -Width 200 | Write-Host

$failed = @($rows | Where-Object { $_.Result -eq "FAIL" })
if ($failed.Count -gt 0) {
    Write-Host "$($failed.Count) required check(s) failed."
    exit 1
}

Write-Host "All required checks passed."
exit 0
