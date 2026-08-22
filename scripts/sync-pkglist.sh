#!/usr/bin/env bash
# ==============================================================================
# sync-pkglist.sh - Exporta a lista atual de pacotes instalados para o repositório
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

echo "📦 Sincronizando listas de pacotes instalados..."

# Pacotes nativos do Arch Linux (excluindo AUR)
pacman -Qqe | grep -vx "$(pacman -Qqm 2>/dev/null || true)" > "$SCRIPT_DIR/pkglist-native.txt"
echo "  ✓ Pacotes nativos salvos em scripts/pkglist-native.txt ($(wc -l < "$SCRIPT_DIR/pkglist-native.txt") pacotes)"

# Pacotes do AUR
if command -v yay &>/dev/null || command -v paru &>/dev/null; then
    pacman -Qqm > "$SCRIPT_DIR/pkglist-aur.txt" 2>/dev/null || true
    echo "  ✓ Pacotes AUR salvos em scripts/pkglist-aur.txt ($(wc -l < "$SCRIPT_DIR/pkglist-aur.txt") pacotes)"
fi

echo "✅ Sincronização de pacotes concluída!"
