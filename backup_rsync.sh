#!/usr/bin/env bash
set -euo pipefail

#################################
# Colors
#################################
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
BOLD="\e[1m"
RESET="\e[0m"

#################################
# Parse flags
#################################
DRY_RUN=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -n|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -h|--help)
            echo -e "${BOLD}Usage:${RESET} ./backup.sh [options]"
            echo -e "  -n, --dry-run     Show what would be done without copying"
            echo -e "  -h, --help        Show this help message"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option:${RESET} $1"
            exit 1
            ;;
    esac
done

#################################
# Paths
#################################
FOLDERS_FILE="./folders.txt"

if [[ ! -f "$FOLDERS_FILE" ]]; then
    echo -e "${RED}Error:${RESET} $FOLDERS_FILE not found."
    exit 1
fi

mapfile -t FOLDERS < "$FOLDERS_FILE"

echo -e "\n${BLUE}${BOLD}Backing up the following folders:${RESET}\n"
for folder in "${FOLDERS[@]}"; do
    echo -e "  ${YELLOW}$folder${RESET}"
done

echo -ne "\n${GREEN}Enter the destination drive/mount path: ${RESET}"
read -r DRIVE
DRIVE=$(eval echo "$DRIVE")

if [[ ! -d "$DRIVE" ]]; then
    echo -e "${RED}\nError:${RESET} '$DRIVE' does not exist or is not a directory."
    read -rp "Press enter to exit"
    exit 1
fi

HOSTNAME=$(hostname)
BACKUP_PATH="$DRIVE/${HOSTNAME}.backup"

echo -e "\n${BLUE}Backup destination:${RESET} $BACKUP_PATH"
mkdir -p "$BACKUP_PATH"

#################################
# Check if sudo is needed
#################################
NEED_SUDO=""
for folder in "${FOLDERS[@]}"; do
    if [[ ! -r "$folder" ]]; then
        NEED_SUDO="sudo"
        break
    fi
done

if [[ -n "$NEED_SUDO" ]]; then
    echo -e "\n${YELLOW}Some folders require elevated permissions.${RESET}"
    sudo -v || { echo -e "${RED}Failed to authenticate sudo.${RESET}"; exit 1; }
fi

#################################
# Backup
#################################
for folder in "${FOLDERS[@]}"; do
    leaf=$(basename "$folder")
    dest="$BACKUP_PATH/$leaf"

    echo -e "\n${GREEN}${BOLD}Backing up:${RESET} ${YELLOW}$folder${RESET} → ${YELLOW}$dest${RESET}"

    if $DRY_RUN; then
        echo -e "${BLUE}(dry run) rsync would run:${RESET}"
        echo -e "  rsync -a --delete --info=progress2 \"$folder/\" \"$dest/\""
        $NEED_SUDO rsync -a --delete --info=progress2 --dry-run "$folder/" "$dest/"
        continue
    fi

    $NEED_SUDO rsync -a \
        --delete \
        --info=progress2 \
        "$folder/" "$dest/"
done

#################################
# Timestamp
#################################
if ! $DRY_RUN; then
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$timestamp" > "$BACKUP_PATH/timestamp.txt"
    echo -e "\n${GREEN}Timestamp written.${RESET}"
fi

echo -e "\n${BOLD}${GREEN}Backup completed.${RESET}"
read -rp "Press enter to exit"
