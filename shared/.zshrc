# --- Configurações de Histórico ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt incappendhistory

# --- Configurações de Prompt e Teclado ---
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
setopt completealiases

# Teclas Home/End/Delete (comum falhar no Arch)
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# --- Aliases Úteis ---
alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color=auto'
alias dot='cd ~/Projects/dotfiles'
alias gs='git status'
alias gp='git push'

# --- Integração com Omarchy (se existir) ---
if [ -f "$HOME/.config/omarchy/zshrc" ]; then
    source "$HOME/.config/omarchy/zshrc"
fi

# --- Suporte a Plugins (Instalados via Pacman no Arch) ---
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- SSH Agent Socket (Systemd) ---
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$UID}/ssh-agent.socket"

# --- Carregar segredos locais e variáveis privadas (não versionadas) ---
if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi

# PATH personalizado
export PATH="$HOME/.local/bin:$PATH"
