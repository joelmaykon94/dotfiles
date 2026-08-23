#!/usr/bin/env bash
# ==============================================================================
# set-animated-wallpaper.sh - Define um vídeo/GIF como papel de parede animado
# ==============================================================================
set -euo pipefail

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
mkdir -p "$WALLPAPER_DIR"

if [ $# -eq 0 ]; then
    # Se nenhum arquivo for passado, procura o primeiro vídeo na pasta de wallpapers
    DEFAULT_VIDEO=$(find "$WALLPAPER_DIR" -type f \( -name "*.mp4" -o -name "*.webm" -o -name "*.gif" \) | head -n 1)
    if [ -n "$DEFAULT_VIDEO" ]; then
        VIDEO_PATH="$DEFAULT_VIDEO"
    else
        echo "Uso: $0 <caminho_do_video_ou_gif>"
        echo "Coloque seus vídeos 4K em: $WALLPAPER_DIR"
        exit 1
    fi
else
    VIDEO_PATH="$1"
fi

if [ ! -f "$VIDEO_PATH" ]; then
    echo "Erro: Arquivo '$VIDEO_PATH' não encontrado."
    exit 1
fi

echo "🎬 Ativando wallpaper animado: $VIDEO_PATH"

# Encerra instâncias anteriores do swaybg e mpvpaper
killall swaybg 2>/dev/null || true
killall mpvpaper 2>/dev/null || true

# Inicia o mpvpaper com aceleração de GPU (Intel/NVIDIA), sem áudio e em loop infinito
nohup mpvpaper -o "no-audio --loop-file=inf --hwdec=auto" '*' "$VIDEO_PATH" >/dev/null 2>&1 &
disown

echo "✅ Papel de parede animado ativado!"
