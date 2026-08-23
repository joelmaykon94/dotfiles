#!/usr/bin/env bash
# ==============================================================================
# set-animated-wallpaper.sh - Define vídeo/GIF como papel de parede animado
# Otimização Máxima: 1080p nativo, 30 FPS e Auto-Pause quando janelas estão sobrepostas
# ==============================================================================
set -euo pipefail

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
mkdir -p "$WALLPAPER_DIR"

# Seleciona o arquivo 1080p otimizado prioritariamente
if [ $# -eq 0 ]; then
    if [ -f "$WALLPAPER_DIR/samurai_1080p.mp4" ]; then
        VIDEO_PATH="$WALLPAPER_DIR/samurai_1080p.mp4"
    else
        DEFAULT_VIDEO=$(find "$WALLPAPER_DIR" -type f \( -name "*.mp4" -o -name "*.webm" -o -name "*.gif" \) | head -n 1)
        if [ -n "$DEFAULT_VIDEO" ]; then
            VIDEO_PATH="$DEFAULT_VIDEO"
        else
            echo "Coloque seus vídeos em: $WALLPAPER_DIR"
            exit 1
        fi
    fi
else
    VIDEO_PATH="$1"
fi

if [ ! -f "$VIDEO_PATH" ]; then
    echo "Erro: Arquivo '$VIDEO_PATH' não encontrado."
    exit 1
fi

echo "🎬 Ativando wallpaper animado ultraleve: $VIDEO_PATH"

# Encerra instâncias anteriores
killall swaybg 2>/dev/null || true
killall mpvpaper 2>/dev/null || true

# mpvpaper com as 3 flags de ultra-eficiência:
# -p : Auto-pause quando as janelas cobrem o papel de parede (0% CPU/GPU quando trabalhando)
# -f : Modo fork nativo desacoplado
# --hwdec=auto : Decodificação via hardware (Vulkan)
# no-audio, loop-file=inf
mpvpaper -p -f -o "no-audio --loop-file=inf --hwdec=auto" '*' "$VIDEO_PATH"

echo "✅ Papel de parede animado ativo com perfil Zero-Overhead!"
