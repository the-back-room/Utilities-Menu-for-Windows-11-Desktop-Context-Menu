## Utilities Menu for Windows 11 Desktop Context Menu
A simple set of utilities added to the Windows 11 desktop context menu for quick access to common tasks.

<img src="Extras/Preview.bmp" alt="Preview" width="100%" height="auto" />

## Features

- **Kill Not Responding Tasks**: Finds and kills all non-responding tasks
- **Kill Task Manager**: Forcibly closes the Task Manager process to resolve issues
- **Restart Explorer**: Restarts Windows Explorer to resolve various UI issues
- **Restart Start Menu**: Restarts the Start Menu to resolve various UI issues
- **Verify Windows Integrity**: Verify and repair system files using the System File Checker (SFC) tool and Deployment Imaging Service and Management Tool (DISM)

## Optional Addons

- **Restart Explorer7**: Optional feature for explorer7 users to restart explorer 7 without needing the log off. *(Requires explorer7 to be installed into `C:\Utilities\explorer7`.)*
- **MKLINK Assistant**: Assists in creating symbolic/hard links, and directory junctions using the MKLINK command
- **Refresh Icon Cache**: Refreshes the icon and thumbnail cache to fix icon display issues.
- **Cleanup Memory**: Free up memory with by clearing the Working Sets, Standby List, and Modified Page List with the RAMMap Memory Cleanup Script.
- **Classic Personalizattion**: Add Classic Personlization menu to the Windows 11 desktop context menu.
- **Control Panel**: Add a Control Panel entree wtih `Icons View, Categories View and All Items (God Mode)` to the Windows 11 desktop context menu.

## Instructions

1. Download the ZIP file from the link below.
2. Extract the contents of the ZIP file to a folder of your choice.
3. Copy the `Utilities` folder to the root of your `C:` drive `(C:\Utilities)`.
4. Double-click the `Add Utilities Menu.reg` file to add the Utilities Menu to your desktop context menu.

To remove the Utilities Menu from your desktop context menu, double-click the `Remove Utilities Menu.reg` file.

## Addon Instructions

### Explorer7

- Follow the instructions [here](/Utilities/explorer7/README.md) to set up explorer7 on your system. You can download the latest version of explorer7 from the official [releases](https://github.com/world-windows-federation/explorer7/releases) page if ours is outdated. *(A windows 7 or xp iso file is required for explorer7. You can find a Windows 7 AIO ISO on [archive.org](https://archive.org/details/windows-7-all-in-one-iso-with-all-languages))*.

- **Enable Modern Apps**: Double-click the `Enable Modern Apps.reg` file included in the `Utilities\explorer7` directory to enable support for modern apps in explorer7.

### Cleanup Memory

1. Download and install [Sysinternals Suite](https://apps.microsoft.com/detail/9p7knl5rwt25) from the Microsoft Store.
2. Double-click the `Add Cleanup Memory.reg` file located in the Utilities\Addons` directory.

To remove, simply double-click the `Remove Cleanup Memory.reg` file located in the `Utilities\Addons` directory.

### Refresh Icon Cache

1. Double-click the `Add Refresh Icon Cache.reg` file located in the `Utilities\Addons` directory.

To remove, simply double-click the `Remove Refresh Icon Cache.reg` file located in the `Utilities\Addons` directory.

### MKLINK Assistant

1. Double-click the `Add MKLINK Assistant.reg` file located in the `Utilities\Addons` directory.

To remove, simply double-click the `Remove MKLINK Assistant.reg` file located in the `Utilities\Addons` directory.

---

**Download**: [Download ZIP](https://github.com/The-Back-Room/Utilities-Menu-for-Windows-11-Desktop-Context-Menu/archive/refs/heads/main.zip)
