# Optolith Database Installer

Install the database and its editor locally via a script.

## General considerations

Do not install the database to a cloud folder. It might create issues with your cloud provider, since a large amount of small files will be created.

## Linux

Download the script to the location where you want the Optolith database to be installed and run the following in your terminal:

```sh
sh install.sh
```

Alternatively, navigate to the folder you want it to be installed and do everything in one line:

```sh
bash <(curl -s https://github.com/elyukai/optolith-data-installer/raw/refs/heads/main/install.sh)
```

## macOS

You can do the same as for Linux. If you do not want to use the terminal at all:

1. Download the `install.sh` file.
2. Rename the file to `install.command` and place it where you want the database to be installed.
3. Double-click the `install.command` file and close the malware warning.
4. Navigate to the *Privacy & Security* tab in *System Settings* and navigate down to the *Security* section.
5. Click on *Open Anyway* next to *“install.command” was blocked to protect your Mac.*
6. Click on *Open Anyway* again in the popup.
