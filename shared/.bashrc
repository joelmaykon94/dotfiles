# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# Omarchy default bash functions & environment
if [ -f "$HOME/.local/share/omarchy/default/bash/rc" ]; then
    source "$HOME/.local/share/omarchy/default/bash/rc"
fi

# SSH Agent Socket (Systemd)
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$UID}/ssh-agent.socket"

# PATH Personalizado
export PATH="$HOME/.local/bin:$PATH"

# Starship Prompt
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi

# Zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi

# Mise
if command -v mise &>/dev/null; then
    eval "$(mise activate bash)"
fi

# Atuin (se instalado)
if command -v atuin &>/dev/null; then
    eval "$(atuin init bash)"
fi

# Eza Aliases
if command -v eza &>/dev/null; then
    alias ls='eza -lh --group-directories-first --icons=auto'
    alias lsa='eza -lha --group-directories-first --icons=auto'
    alias lt='eza --tree --level=2 --long --icons --git'
    alias lta='eza --tree --level=2 --long --icons --git -a'
else
    alias ls='ls --color=auto'
    alias ll='ls -lah'
fi

# Navegação Rápida
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias dot='cd ~/Projects/dotfiles'

# Dev Tools & TUIs
n() {
    if [ "$#" -eq 0 ]; then
        command nvim .
    else
        command nvim "$@"
    fi
}
alias v='nvim'
alias lg='lazygit'
alias ld='lazydocker'
alias top='btop'
alias y='yazi'

# FZF helpers
if command -v fzf &>/dev/null; then
    [ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
    [ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
    alias ff="fzf --preview 'bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || cat {}'"
    alias eff='$EDITOR "$(ff)"'
fi

# Git Shortcuts
alias g='git'
alias gs='git status'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gcm='git commit -m'
alias gcam='git commit -a -m'

# Carregar segredos locais e configurações privadas (não versionadas)
if [ -f "$HOME/.bashrc.local" ]; then
    source "$HOME/.bashrc.local"
fi
