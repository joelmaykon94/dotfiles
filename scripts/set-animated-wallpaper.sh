#!/usr/bin/env bash
# ==============================================================================
# set-animated-wallpaper.sh - Define um vídeo/GIF como papel de parede animado
# Otimizado para baixo consumo de CPU/GPU e temperatura fria
# ==============================================================================
set -euo pipefail

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
mkdir -p "$WALLPAPER_DIR"

if [ $# -eq 0 ]; then
    DEFAULT_VIDEO=$(find "$WALLPAPER_DIR" -type f \( -name "*.mp4" -o -name "*.webm" -o -name "*.gif" \) | head -n 1)
    if [ -n "$DEFAULT_VIDEO" ]; then
        VIDEO_PATH="$DEFAULT_VIDEO"
    else
        echo "Uso: $0 <caminho_do_video_ou_gif>"
        echo "Coloque seus vídeos em: $WALLPAPER_DIR"
        exit 1
    fi
else
    VIDEO_PATH="$1"
fi

if [ ! -f "$VIDEO_PATH" ]; then
    echo "Erro: Arquivo '$VIDEO_PATH' não encontrado."
    exit 1
fi

echo "🎬 Ativando wallpaper animado otimizado: $VIDEO_PATH"

# Encerra instâncias anteriores do swaybg e mpvpaper
killall swaybg 2>/dev/null || true
killall mpvpaper 2>/dev/null || true

# Otimizações para manter a temperatura baixa:
# 1. --hwdec=auto (decodificação por hardware)
# 2. --vf=fps=30 (limita animação de fundo em 30fps para cortar carga de GPU/CPU pela metade)
# 3. --no-audio (sem processamento de som)
# 4. --scale=bilinear (baixo uso de shaders)
nohup mpvpaper -o "no-audio --loop-file=inf --hwdec=auto --vf=fps=30 --scale=bilinear" '*' "$VIDEO_PATH" >/dev/null 2>&1 &
disown

echo "✅ Papel de parede animado ativado com perfil térmico otimizado!"
