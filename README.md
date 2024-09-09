# Correct Me! Installer [![GitHub Release](https://img.shields.io/github/v/release/farid-rajabi/correct-me-installer)](https://github.com/farid-rajabi/correct-me-installer/releases/latest)

A desktop installer to help with installation of [*Correct Me!*](https://github.com/farid-rajabi/correct-me).

## Requirements

### Linux

- [Python 3.x](https://www.python.org)
- *pip* or *pip3*
- wget
- unzip

### Windows

- [Python 3.x](https://www.python.org)
- *pip* or *pip3*

## How to Use

1. Download the [latest release of *Correct Me! Installer*](https://github.com/farid-rajabi/correct-me-installer/releases/latest).

2. Extract it and put the directory wherever you want.

> [!NOTE]
> The installation requires internet connection.

3. If you are on **Linux**:

    1. Right click on *installer-linux.sh*, then click on *Run as a Program*.

    2. Wait until the message *Installation is completed* is printed in the terminal.

   If you are on **Windows**:

    1. Double click on *installer-windows.bat*.

    2. Wait until the "Installation is completed" message is printed in the cmd/powershell.

> [!CAUTION]
> DO NOT run *installer-windows.bat* as an administrator.

> [!TIP]
> Do not ignore the log. In case a problem occurs, the solution will be printed for you.

> [!WARNING]
> If you should remove the directory, locate the *Correct Me* directory CAREFULLY as the rest of the files/folders in the *Program Files* folder are important.

## Troubleshoot

### *pip* Instead of *pip3*
If you terminal/cmd/powershell tells you "pip3 command not found" or something similar,

1. Check whether the `pip` command is available on your system. If it is available, proceed. Otherwise, try installing `pip3` and follow the [*How to Use* section](#how-to-use).

2. With respect to your OS, open *installer-linux.sh* or *installer-windows.bat* with a text editor.

3. Search the file and replace every `pip3` with `pip`.

## Test Results

| Version | Configurations | Result |
| --- | --- | --- |
| 1.1.0 | ![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04.4_LTS-E95420?logo=ubuntu) ![Python](https://img.shields.io/badge/Python-3.10.12-3776AB?logo=python) ![GNU Bash](https://img.shields.io/badge/GNU_Bash-5.1.16-4EAA25?logo=gnubash) | ![Result](https://img.shields.io/badge/Passed-green) |
