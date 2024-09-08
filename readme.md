# Cross-platform Firefox Privacy & Security Setup

This repository contains **Linux**, **macOS**, and **Windows** scripts to automate the process of enhancing your privacy and security on Firefox.

## Features:
- Applies **Arkenfox user.js** for privacy.
- Installs **privacy-enhancing extensions**.
- Configures **about:config** for better privacy.
- Installs **StevenBlack's hosts file** to block ads and trackers.
- Sets up **DNS over HTTPS** (DoH) with Cloudflare.
- Optional **Tor Browser** installation.

## Supported Platforms:
- **Linux**
- **macOS**
- **Windows**

## How to Use:

### Linux/macOS:
1. Download the script for your OS (e.g., `install_firefox_privacy_linux.sh`).
2. Give the script execute permissions:
    ```bash
    chmod +x install_firefox_privacy_linux.sh
    ```
3. Run the script:
    ```bash
    ./install_firefox_privacy_linux.sh
    ```

### Windows:
1. Download the PowerShell script `install_firefox_privacy_windows.ps1`.
2. Run PowerShell as **Administrator**.
3. Execute the script:
    ```powershell
    Set-ExecutionPolicy Bypass -Scope Process -Force
    .\install_firefox_privacy_windows.ps1
    ```

### Notes:
- Make sure to run the script with **administrator privileges** for full functionality (especially for DNS and hosts file changes).
