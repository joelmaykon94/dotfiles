# ==============================================================================
# Omarchy / Akita ZSH Configuration
# ==============================================================================

# --- Histórico Inteligente ---
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

# --- Autocompletion e Navegação de Menu ---
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive
setopt completealiases

# --- Teclas de Navegação (Home / End / Delete / Ctrl+Setas) ---
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# --- Version Manager (Mise) ---
if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

# --- Starship Prompt ---
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# --- Atuin (se instalado) ---
if command -v atuin &>/dev/null; then
    eval "$(atuin init zsh)"
fi

# --- Zoxide (Navegação Inteligente com 'z') ---
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
    
    zd() {
        if (( $# == 0 )); then
            builtin cd ~ || return
        elif [[ -d $1 ]]; then
            builtin cd "$1" || return
        else
            if ! z "$@"; then
                echo "Diretório não encontrado no zoxide"
                return 1
            fi
            printf "📂 "
            pwd
        fi
    }
    alias cd="zd"
fi

# --- FZF (Fuzzy Finder + Keybindings + Previews) ---
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

if command -v fzf &>/dev/null; then
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"
    
    if command -v bat &>/dev/null; then
        alias ff="fzf --preview 'bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || cat {}'"
    else
        alias ff="fzf --preview 'cat {}'"
    fi
    alias eff='$EDITOR "$(ff)"'
fi

# --- Eza (Substituto Moderno do ls) ---
if command -v eza &>/dev/null; then
    alias ls='eza -lh --group-directories-first --icons=auto'
    alias lsa='eza -lha --group-directories-first --icons=auto'
    alias lt='eza --tree --level=2 --long --icons --git'
    alias lta='eza --tree --level=2 --long --icons --git -a'
else
    alias ls='ls --color=auto'
    alias ll='ls -lah'
fi

# --- Navegação Rápida de Diretórios ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias dot='cd ~/Projects/dotfiles'

# --- Atalhos de Desenvolvimento & Neovim ---
n() {
    if [ "$#" -eq 0 ]; then
        command nvim .
    else
        command nvim "$@"
    fi
}
alias v='nvim'
alias grep='grep --color=auto'
alias top='btop'
alias lg='lazygit'
alias ld='lazydocker'
alias y='yazi'

# --- Git Shortcuts ---
alias g='git'
alias gs='git status'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gcm='git commit -m'
alias gcam='git commit -a -m'

# --- ZSH Plugins (Syntax Highlighting & Autosuggestions) ---
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- SSH Agent Socket (Systemd) ---
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$UID}/ssh-agent.socket"

# --- Carregar Configurações e Segredos Locais (Não Versionados) ---
if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi

# PATH Personalizado
export PATH="$HOME/.local/bin:$PATH"
