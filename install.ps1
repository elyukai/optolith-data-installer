#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

$TARGET_BRANCH = "develop-V2"
$TARGET_FOLDER = "./optolith-db"

function printNotice {
    param([string]$message)
    Write-Host $message -ForegroundColor Cyan
}

function printError {
    param([string]$message)
    Write-Host $message -ForegroundColor Red -BackgroundColor Black
}

# Checking for git
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    printError "#> Could not find git. Please install git or add it to your PATH environment variable."
    exit 1
}

# Checking for node
if (!(Get-Command node -ErrorAction SilentlyContinue)) {
    printError "#> Could not find node. Please install node or add it to your PATH environment variable."
    exit 1
}

# Checking node version
function hasInvalidNodeVersion {
    $version = (node --version)
    $majorVersion = $version -replace '^v(\d+).*', '$1'

    [int]$cleanMajorVersion = $majorVersion
    return $cleanMajorVersion -lt 24
}

if (hasInvalidNodeVersion) {
    printError "#> Please ensure your NodeJS has the major version 24 or higher... Your version is $(node --version)"
    exit 1
}

# Installing db
function installDB {
    if (Test-Path -Path $TARGET_FOLDER) {
        Write-Host "#> Skipping downloading DB due to existing folder"
        return 0
    }

    Write-Host "#> Downloading DB"
    git clone -b "$TARGET_BRANCH" https://github.com/elyukai/optolith-data.git "$TARGET_FOLDER"
    return 0
}

installDB

# Install dependencies
Write-Host "#> Install dependencies"

Set-Location "$TARGET_FOLDER"
npm ci

# Done
Write-Host "#> Install complete"

Write-Host ""
Write-Host "-- Run " -NoNewline
Write-Host "npm run start" -ForegroundColor Green -NoNewline
Write-Host " to start the database. --"
