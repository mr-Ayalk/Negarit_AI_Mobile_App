# Windows setup

This is the toolchain used to build Negarit AI on Windows 11. Android Studio, Docker Desktop, and Visual Studio are not required.

The first machine this was verified on (29 Oct 2026) is a 64-bit Windows 11 25H2 PC with 8 GB RAM and about 43 GB free disk. Android and Chrome targets passed `flutter doctor`. Windows desktop builds stay unavailable until Visual Studio is installed, and that target is out of scope.

## Verified versions

| Tool | Version | Location |
|---|---|---|
| Git | 2.54.0.windows.1 | `C:\Program Files\Git\cmd\git.exe` |
| Flutter | 3.47.7 stable | `C:\Users\<you>\flutter` |
| Dart | 3.13.5 | bundled with Flutter |
| Temurin JDK | 17.0.20.1+1 | `C:\Program Files\Eclipse Adoptium\jdk-17.0.20.101-hotspot` |
| Android command-line tools | 15859902 | `%LOCALAPPDATA%\Android\Sdk\cmdline-tools\latest` |
| Android SDK platform | android-36 | `%LOCALAPPDATA%\Android\Sdk\platforms\android-36` |
| Android build-tools | 36.0.0 | `%LOCALAPPDATA%\Android\Sdk\build-tools\36.0.0` |
| Android platform-tools / adb | 37.0.1 | `%LOCALAPPDATA%\Android\Sdk\platform-tools` |
| Node.js | 24.15.0 | `C:\Program Files\nodejs` |
| npm | 11.12.1 | with Node.js |
| NestJS CLI | 12.0.11 | `%APPDATA%\npm` |
| PostgreSQL | 18.6 (service `postgresql-x64-18`) | `C:\Program Files\PostgreSQL\18` |
| PostGIS | 3.6.2 bundle | installed into the PostgreSQL 18 directory |
| pgvector | 0.8.7 | community Windows build, files copied into PostgreSQL 18 |
| Python (optional) | 3.14.6 | already present; not required for the app |

`sdkmanager` prints a deprecation notice and points at the newer `android` CLI. Flutter 3.47.7 accepts this SDK, so the classic command-line tools stay in place.

## What a new teammate installs

Open a new PowerShell window after each PATH change.

### 1. Git, Node.js, JDK 17

```powershell
winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements
winget install --id OpenJS.NodeJS.LTS -e --source winget --accept-package-agreements --accept-source-agreements
winget install --id EclipseAdoptium.Temurin.17.JDK -e --source winget --accept-package-agreements --accept-source-agreements
```

The Temurin installer sets `JAVA_HOME` and adds `bin` to the system PATH. Confirm with `java -version`. The major version must be 17.

### 2. Flutter

Install the official stable SDK from [https://docs.flutter.dev/install/manual](https://docs.flutter.dev/install/manual) (or the Windows zip on [https://flutter.dev/install](https://flutter.dev/install)) and add `flutter\bin` to the user PATH.

```powershell
flutter --version
flutter config --android-sdk "$env:LOCALAPPDATA\Android\Sdk"
```

On this PC, `flutter doctor` warns `Unknown upstream repository` because the SDK checkout at `C:\Users\teket\flutter` has no git remote. The SDK still builds. Repair the remote only if `flutter upgrade` fails. Do not reinstall a working SDK just to clear that warning.

### 3. Android SDK without Android Studio

Flutter 3.47 expects compile SDK 36.

```powershell
$sdk = Join-Path $env:LOCALAPPDATA "Android\Sdk"
$latest = Join-Path $sdk "cmdline-tools\latest"
New-Item -ItemType Directory -Force -Path $latest | Out-Null
$zip = Join-Path $env:TEMP "commandlinetools-win-15859902_latest.zip"
curl.exe -L --fail -o $zip "https://dl.google.com/android/repository/commandlinetools-win-15859902_latest.zip"
# SHA-256 published on https://developer.android.com/studio (Command line tools only):
# 90ae805d20434428bffcb699c290860f19bb5f66a67e6b330067e3de801fb04a
Expand-Archive -Path $zip -DestinationPath (Join-Path $env:TEMP "cmdline-extract") -Force
Copy-Item -Path (Join-Path $env:TEMP "cmdline-extract\cmdline-tools\*") -Destination $latest -Recurse -Force

[System.Environment]::SetEnvironmentVariable("ANDROID_HOME", $sdk, "User")
[System.Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", $sdk, "User")
```

Add these directories to the user PATH:

- `%LOCALAPPDATA%\Android\Sdk\platform-tools`
- `%LOCALAPPDATA%\Android\Sdk\cmdline-tools\latest\bin`

Accept licenses and install one platform plus matching build-tools:

```powershell
$env:JAVA_HOME = "C:\Program Files\Eclipse Adoptium\jdk-17.0.20.101-hotspot"
$sdk = Join-Path $env:LOCALAPPDATA "Android\Sdk"
$sdkmanager = Join-Path $sdk "cmdline-tools\latest\bin\sdkmanager.bat"
$yes = Join-Path $env:TEMP "android-yes.txt"
1..80 | ForEach-Object { "y" } | Set-Content $yes -Encoding ascii
cmd /c "`"$sdkmanager`" --sdk_root=`"$sdk`" --licenses < `"$yes`""
cmd /c "`"$sdkmanager`" --sdk_root=`"$sdk`" `"platform-tools`" `"platforms;android-36`" `"build-tools;36.0.0`""
flutter doctor --android-licenses
flutter doctor -v
```

An Android Studio warning in `flutter doctor` is acceptable because Studio is not installed. A Visual Studio warning is also acceptable: it only blocks `flutter run -d windows`.

### 4. NestJS CLI

```powershell
npm install -g @nestjs/cli
nest --version
```

### 5. PostgreSQL, PostGIS, and pgvector

This PC already had PostgreSQL 18.6. The SRS asks for PostgreSQL 16. Version 18 is the server we use, so a second major version is not installed.

Add `C:\Program Files\PostgreSQL\18\bin` to the user PATH, then open a new terminal and run `psql --version`.

PostGIS 3.6.2 for PostgreSQL 18 was installed with the official bundle (silent NSIS install). It must run elevated because it writes under `C:\Program Files\PostgreSQL\18`.

```powershell
curl.exe -L --fail -o "$env:TEMP\postgis-bundle-pg18x64-setup-3.6.2-1.exe" "https://download.postgresql.org/pub/postgis/pg18/v3.6.2/win64/postgis-bundle-pg18x64-setup-3.6.2-1.exe"
Start-Process -FilePath "$env:TEMP\postgis-bundle-pg18x64-setup-3.6.2-1.exe" -ArgumentList "/S" -Wait
```

pgvector has no official Windows installer. The files on this PC are the community build `vector.v0.8.7-pg18.zip` from [andreiramani/pgvector_pgsql_windows](https://github.com/andreiramani/pgvector_pgsql_windows/releases/tag/0.8.7), SHA-256 `7c4ae0e2b2cb1e547779209a34a7d3f05b82fd7912818bf3d7042266eda87e7d`. Treat that binary as unofficial. The official alternative is to build pgvector 0.8.7 with Visual Studio C++ tools, which this setup avoids.

Copy, from an elevated PowerShell, `lib\vector.dll` to `C:\Program Files\PostgreSQL\18\lib` and `share\extension\*` to `C:\Program Files\PostgreSQL\18\share\extension`.

Docker Desktop is not used. RAM on the reference PC is under 8 GB.

### 6. Enable the extensions

Local PostgreSQL uses `scram-sha-256`. There is no `pgpass` file on this PC, and the superuser password is not stored in the repo. `CREATE EXTENSION` has **not** been executed yet.

In a terminal where `PGPASSWORD` is set to the `postgres` role password (do not commit it):

```powershell
$env:PGPASSWORD = "<postgres-superuser-password>"
psql -U postgres -h 127.0.0.1 -d postgres -c "SELECT version();"
psql -U postgres -h 127.0.0.1 -d postgres -c "CREATE EXTENSION IF NOT EXISTS postgis;"
psql -U postgres -h 127.0.0.1 -d postgres -c "CREATE EXTENSION IF NOT EXISTS vector;"
psql -U postgres -h 127.0.0.1 -d postgres -c "SELECT extname, extversion FROM pg_extension WHERE extname IN ('postgis','vector');"
Remove-Item Env:PGPASSWORD
```

Until those two queries succeed, spatial and vector search stay unverified. The extension files are on disk.

## Check the toolchain

From the repository root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\check-env.ps1"
```

The script exits 0 when every required check passes. Python, GitHub CLI, and Docker are optional.

## Phone

Enable Developer options and USB debugging, then connect the phone with a data cable:

```powershell
adb devices
flutter devices
```

No Android phone was attached on 29 Oct 2026. UI work can use Chrome:

```powershell
flutter run -d chrome
```

Real BLE and NFC still need a physical Android device. An emulator is a poor fit on 8 GB RAM.
