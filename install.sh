#!/usr/bin/env bash
# ==============================================================================
# Dotfiles & System Bootstrap - Arch Linux / Omarchy
# Reprodutibilidade completa do ambiente de desenvolvimento e interface
# ==============================================================================
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$DOTFILES_DIR/scripts"

# Cores para logs
BOLD="\033[1m"
GREEN="\033[32m"
BLUE="\033[34m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

log_info() { echo -e "${BLUE}${BOLD}[INFO]${RESET} $1"; }
log_success() { echo -e "${GREEN}${BOLD}[OK]${RESET} $1"; }
log_warn() { echo -e "${YELLOW}${BOLD}[AVISO]${RESET} $1"; }
log_error() { echo -e "${RED}${BOLD}[ERRO]${RESET} $1"; }

# 1. Verificar ambiente Arch Linux
if [ ! -f /etc/arch-release ]; then
    log_error "Este script foi projetado especificamente para Arch Linux e derivados (Omarchy)."
    exit 1
fi

log_info "Iniciando bootstrap dos Dotfiles a partir de: $DOTFILES_DIR"

# 2. Instalar dependências básicas
log_info "Garantindo pacotes essenciais (stow, git, base-devel)..."
sudo pacman -S --needed --noconfirm git stow base-devel

# 3. Instalar pacotes oficiais do repositório
if [ -f "$SCRIPTS_DIR/pkglist-native.txt" ]; then
    log_info "Instalando pacotes nativos do Arch Linux..."
    sudo pacman -S --needed --noconfirm - < "$SCRIPTS_DIR/pkglist-native.txt"
    log_success "Pacotes nativos instalados!"
else
    log_warn "Arquivo pkglist-native.txt não encontrado."
fi

# 4. Verificar / Instalar AUR Helper (yay)
if ! command -v yay &>/dev/null && ! command -v paru &>/dev/null; then
    log_info "AUR Helper não encontrado. Instalando yay-bin..."
    TEMP_DIR=$(mktemp -d)
    git clone https://aur.archlinux.org/yay-bin.git "$TEMP_DIR/yay-bin"
    (cd "$TEMP_DIR/yay-bin" && makepkg -si --noconfirm)
    rm -rf "$TEMP_DIR"
    log_success "yay instalado com sucesso!"
fi

# 5. Instalar pacotes do AUR
AUR_HELPER=$(command -v yay || command -v paru)
if [ -f "$SCRIPTS_DIR/pkglist-aur.txt" ] && [ -s "$SCRIPTS_DIR/pkglist-aur.txt" ]; then
    log_info "Instalando pacotes do AUR via $AUR_HELPER..."
    "$AUR_HELPER" -S --needed --noconfirm - < "$SCRIPTS_DIR/pkglist-aur.txt"
    log_success "Pacotes do AUR instalados!"
fi

# 6. Aplicar Symlinks com GNU Stow
log_info "Aplicando configurações com GNU Stow..."
cd "$DOTFILES_DIR"

PACKAGES=("shared" "arch-omarchy" "fivves-ui")

for pkg in "${PACKAGES[@]}"; do
    if [ -d "$DOTFILES_DIR/$pkg" ]; then
        log_info "  -> Aplicando módulo: $pkg"
        # Cria diretórios pai se não existirem
        mkdir -p "$HOME/.config" "$HOME/.gemini/antigravity-cli" "$HOME/.agents/skills"
        stow -v -R -t "$HOME" "$pkg" 2>&1 | sed 's/^/     /'
    fi
done
log_success "Symlinks criados com sucesso!"

# 7. Sincronizar AI Workspace Commons (se presente)
COMMONS_SYNC="$HOME/Projects/ai-workspace-commons/scripts/sync-global-skills.sh"
if [ -f "$COMMONS_SYNC" ]; then
    log_info "Sincronizando skills globais do ai-workspace-commons..."
    bash "$COMMONS_SYNC" 2>&1 | sed 's/^/     /' || log_warn "Aviso ao sincronizar skills."
fi

# 8. Configuração de Segurança (Firewall UFW)
if command -v ufw &>/dev/null; then
    log_info "Configurando Firewall (UFW)..."
    sudo ufw default deny incoming || true
    sudo ufw default allow outgoing || true
    sudo systemctl enable --now ufw || true
    log_success "UFW ativo e configurado com segurança!"
fi

# 9. Criar template de segredos locais se não existir
if [ ! -f "$HOME/.zshrc.local" ]; then
    cat << 'EOF' > "$HOME/.zshrc.local"
# ==============================================================================
# Segredos e variáveis de ambiente locais (NÃO VERSIONAR NO GIT)
# ==============================================================================
# export GITHUB_TOKEN=""
# export OPENAI_API_KEY=""
# export ANTHROPIC_API_KEY=""
EOF
    chmod 600 "$HOME/.zshrc.local"
    log_info "Criado arquivo de template para segredos em ~/.zshrc.local"
fi

echo ""
echo -e "${GREEN}${BOLD}====================================================${RESET}"
echo -e "${GREEN}${BOLD}       Ambiente configurado com sucesso!            ${RESET}"
echo -e "${GREEN}${BOLD}====================================================${RESET}"
echo -e "Dicas:"
echo -e "  - Atualize sua lista de pacotes a qualquer momento: ${YELLOW}./scripts/sync-pkglist.sh${RESET}"
echo -e "  - Guarde chaves e segredos em: ${YELLOW}~/.zshrc.local${RESET}"
echo -e "  - Recarregue o Hyprland: ${YELLOW}hyprctl reload${RESET} ou reinicie o Waybar com ${YELLOW}killall waybar; waybar${RESET}"
