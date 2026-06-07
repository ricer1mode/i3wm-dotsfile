#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Starting Configuration Setup ===${NC}\n"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
SRC_CONFIG_DIR="$SCRIPT_DIR/config"
TARGET_CONFIG_DIR="$HOME/.config"

COMPONENTS=("i3" "kitty" "polybar" "picom")

mkdir -p "$TARGET_CONFIG_DIR"

for item in "${COMPONENTS[@]}"; do
    if [ -d "$SRC_CONFIG_DIR/$item" ]; then
        if [ -d "$TARGET_CONFIG_DIR/$item" ]; then
            BACKUP_NAME="${item}_backup_$(date +%F_%R)"
            echo -e "${YELLOW}[Backup]${NC} Existing folder $item found. Renaming to $BACKUP_NAME"
            mv "$TARGET_CONFIG_DIR/$item" "$TARGET_CONFIG_DIR/$BACKUP_NAME"
        fi
        
        echo -e "${GREEN}[Installing]${NC} Copying configuration for $item..."
        cp -r "$SRC_CONFIG_DIR/$item" "$TARGET_CONFIG_DIR/"
    fi
done

echo -e "\n${BLUE}=== Setup Completed Successfully! ===${NC}"
echo -e "Restart i3 (usually Mod+Shift+R) to apply changes."
