#!/bin/env sh

set -eo pipefail

TARGET_BRANCH="develop-V2"
TARGET_FOLDER="./optolith-db"

printNotice() {
  echo -e "\e[36m$1\e[0m"
}

printError() {
  echo -e "\e[1;91m$1\e[0m"
}

# Checking for git
if ! command -v git > /dev/null; then
  printError "#> Could not find git. Please install git or add it to your PATH environment variable."
  exit 1
fi

# Checking for node
if ! command -v node > /dev/null; then
  printError "#> Could not find node. Please install node or add it to your PATH environment variable."
  exit 1
fi

# Checking node version
hasInvalidNodeVersion() {
  local version=$(node --version)

  local majorVersion=(${version//./ })
  local cleanMajorVersion="${majorVersion[0]:1}"

  [[ "$cleanMajorVersion" -ge "24" ]]
}

if ! hasInvalidNodeVersion; then
  printError "#> Please ensure your NodeJS has the major version 24 or higher... Your version is $(node --version)"
  exit 1
fi

# Installing db
installDB() {
  if [ -d "$TARGET_FOLDER" ]; then
    printNotice "#> Skipping downloading DB due to existing folder"
    return 0
  fi

  printNotice "#> Downloading DB"
  git clone -b "$TARGET_BRANCH" https://github.com/elyukai/optolith-data.git "$TARGET_FOLDER"
  return 0
}

installDB

# Install dependencies
printNotice "#> Install dependencies"

cd "$TARGET_FOLDER"
npm ci

# Done
printNotice "#> Install complete"

echo ""
echo -e "-- Run '\e[32mnpm run start\e[0m' to start the database. --"
